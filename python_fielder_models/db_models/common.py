from typing import OrderedDict

from fielder_backend_utils.rest_utils import DocumentReferenceField, GeoPointField
from rest_framework import serializers

DATE_FIELD_REGEX = "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"
PHONE_FIELD_REGEX = "^\+44[0-9]{10}$"
HEX_COLOR_REGEX = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
WEBSITE_REGEX = (
    "^(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$"
)

COMPANY_NAME_MAX_LENGTH = 156
FULL_NAME_MAX_LENGTH = 75


class VerifiedBaseSerializer(serializers.Serializer):
    dov = serializers.DateTimeField()
    is_verified = serializers.BooleanField()
    source = serializers.CharField()


class VerifiedStringSerializer(VerifiedBaseSerializer):
    value = serializers.CharField()


class VerifiedDateSerializer(VerifiedBaseSerializer):
    value = serializers.RegexField(DATE_FIELD_REGEX)


class VerifiedDateTimeSerializer(VerifiedBaseSerializer):
    value = serializers.DateTimeField()


class RecurrenceSerializer(serializers.Serializer):
    friday = serializers.BooleanField(default=False)
    interval_amount = serializers.IntegerField(min_value=0)
    monday = serializers.BooleanField(default=False)
    tuesday = serializers.BooleanField(default=False)
    repeat_interval_type = serializers.ChoiceField(
        choices=[None, "Daily", "Weekly"], allow_null=True
    )
    saturday = serializers.BooleanField(default=False)
    sunday = serializers.BooleanField(default=False)
    thursday = serializers.BooleanField(default=False)
    wednesday = serializers.BooleanField(default=False)


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
        if data["name"] is None:
            data["name"] = " ".join([v for _, v in data["address"].items() if v][:2])

        return super().to_internal_value(data)


class OrganisationLocationDBSerializer(LocationDBSerializer):
    archived = serializers.BooleanField(default=False)
    is_live = serializers.BooleanField(default=True)
    short_name = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    icon_url = serializers.URLField(allow_null=True, default=None)
    organisation_ref = DocumentReferenceField()

    def to_internal_value(self, data):
        # call super to generate schema before accessing the fields
        data = super().to_internal_value(data)

        # generate short_name if empty
        if data["short_name"] is None:
            data["short_name"] = data["name"]

        return super().to_internal_value(data)


class SICCodeSerializer(serializers.Serializer):
    code = serializers.CharField()
    description = serializers.CharField(max_length=200, allow_null=True)
