from datetime import datetime
from typing import OrderedDict

from fielder_backend_utils.rest_utils import GeoPointField
from rest_framework import serializers

DATE_FIELD_REGEX = "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"
PHONE_FIELD_REGEX = "^\+44[0-9]{10}$"
HEX_COLOR_REGEX = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
WEBSITE_REGEX = (
    "^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$"
)

COMPANY_NAME_MAX_LENGTH = 156
FULL_NAME_MAX_LENGTH = 75


class RecurrenceSerializer(serializers.Serializer):
    interval_amount = serializers.IntegerField(
        required=False, allow_null=True, default=1, min_value=0
    )
    repeat_interval_type = serializers.ChoiceField(
        required=True, choices=["Weekly", "Daily", "None", None], allow_null=True
    )
    friday = serializers.BooleanField(default=False)
    monday = serializers.BooleanField(default=False)
    tuesday = serializers.BooleanField(default=False)
    saturday = serializers.BooleanField(default=False)
    sunday = serializers.BooleanField(default=False)
    thursday = serializers.BooleanField(default=False)
    wednesday = serializers.BooleanField(default=False)

    def validate(self, data):
        if data["repeat_interval_type"] in ["Weekly", "Daily"] and (
            "interval_amount" not in data or data["interval_amount"] <= 0
        ):
            raise serializers.ValidationError(
                "Weekly/Daily repeat_interval_type needs interval_amount > 0"
            )
        if data["repeat_interval_type"] in ["None", None]:
            if "interval_amount" not in data or data["interval_amount"] != 1:
                raise serializers.ValidationError(
                    "None recurring repeat_interval_type needs interval_amount == 1"
                )
            # replace "None" with None
            data["repeat_interval_type"] = None
        return data


class AddressDBSerializer(serializers.Serializer):
    flat = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    building = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    street = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    county = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    city = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    country = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    postal_code = serializers.CharField(allow_null=True, allow_blank=True, default=None)


class LocationDBSerializer(serializers.Serializer):
    address = AddressDBSerializer()
    name = serializers.CharField(allow_blank=True, allow_null=True, default=None)
    formatted_address = serializers.CharField(
        allow_blank=True, allow_null=True, default=None
    )
    manual_entry = serializers.BooleanField(default=False)
    coords = GeoPointField(allow_null=True, default=None)

    def to_internal_value(self, data):
        # call super to generate schema before accessing the fields
        data = super().to_internal_value(data)

        # generate formatted_address
        order_of_keys = [
            "flat",
            "building",
            "street",
            "city",
            "county",
            "postal_code",
            "country",
        ]
        data["address"] = OrderedDict(
            [
                (key, data["address"][key])
                for key in order_of_keys
                if key in data["address"]
            ]
        )
        data["formatted_address"] = ", ".join(
            [v for _, v in data["address"].items() if v]
        )

        # generate name if empty
        if data.get("name") is None or data.get("manual_entry"):
            data["name"] = " ".join([v for _, v in data["address"].items() if v][:2])

        return super().to_internal_value(data)
