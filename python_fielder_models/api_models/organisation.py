from fielder_backend_utils.rest_utils import LowercaseEmailField
from python_fielder_models.api_models.common import (
    GooglePlaceDataSerializer,
    LocationAPISerializer,
)
from rest_framework import serializers

from ..db_models.common import COMPANY_NAME_MAX_LENGTH, HEX_COLOR_REGEX
from ..db_models.organisation import BillingContact, GeneralContact


class EmailExistsRequest(serializers.Serializer):
    email = LowercaseEmailField()


class EmailExistsResponse(serializers.Serializer):
    user_exists = serializers.BooleanField()


class KeyContactsRequest(serializers.Serializer):
    organisation_id = serializers.CharField()
    billing_contact = BillingContact(required=False)
    general_contact = GeneralContact(required=False)


class BrandingRequest(serializers.Serializer):
    organisation_id = serializers.CharField()
    brand_color = serializers.RegexField(HEX_COLOR_REGEX)


class InviteUsersRequest(serializers.Serializer):
    organisation_id = serializers.CharField()
    name = serializers.CharField(max_length=75)
    email = LowercaseEmailField()
    role = serializers.ChoiceField(
        choices=["owner", "admin", "hr", "manager", "supervisor"]
    )
    manager = serializers.CharField(required=False, allow_null=True)


class OrganisationAcceptInvite(serializers.Serializer):
    organisation_id = serializers.CharField()
    status = serializers.ChoiceField(
        required=True, choices=["accepted", "declined", "pending"]
    )


class CompanyCreateRequest(serializers.Serializer):
    organisation_id = serializers.CharField()
    company_number = serializers.CharField(max_length=8, min_length=8)


class CompanyUpdateVATInfoRequest(serializers.Serializer):
    organisation_id = serializers.CharField()
    vat_number = serializers.CharField(max_length=15)
    date_of_registration = serializers.DateField()


class UsersListRequest(serializers.Serializer):
    organisation_id = serializers.CharField()


class UserResponse(serializers.Serializer):
    id = serializers.CharField()
    name = serializers.CharField(max_length=COMPANY_NAME_MAX_LENGTH)
    email = LowercaseEmailField()
    date_created = serializers.DateTimeField()
    status = serializers.ChoiceField(choices=["accepted", "declined", "pending"])
    role = serializers.ChoiceField(
        choices=["owner", "admin", "hr", "manager", "supervisor"]
    )
    manager = serializers.CharField(allow_null=True)


class UsersListResponse(serializers.Serializer):
    users = serializers.ListField(child=UserResponse())


class OrganisationLocationAPISerializer(LocationAPISerializer):
    archived = serializers.BooleanField(default=False)
    is_live = serializers.BooleanField(default=True)
    short_name = serializers.CharField(
        allow_null=True, allow_blank=True, required=False
    )
    icon_url = serializers.URLField(allow_null=True, required=False)


class CreateLocationRequestSerializer(serializers.Serializer):
    google_place_data = GooglePlaceDataSerializer(required=False)
    location_data = OrganisationLocationAPISerializer(required=False)

    def validate(self, data):
        if ("location_data" in data and "google_place_data" in data) or not (
            "location_data" in data or "google_place_data" in data
        ):
            raise serializers.ValidationError(
                "Either location_data or google_place_data must be provided"
            )
        return super().validate(data)
