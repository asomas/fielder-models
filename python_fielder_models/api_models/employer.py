from rest_framework import serializers

from ..db_models.common import PHONE_FIELD_REGEX, HEX_COLOR_REGEX
from ..db_models.employer import BillingContact, GeneralContact


class EmailExistsRequest(serializers.Serializer):
    email = serializers.EmailField()


class EmailExistsResponse(serializers.Serializer):
    user_exists = serializers.BooleanField()


class KeyContactsRequest(serializers.Serializer):
    employer_id = serializers.CharField()
    billing_contact = BillingContact(required=False)
    general_contact = GeneralContact(required=False)


class BrandingRequest(serializers.Serializer):
    employer_id = serializers.CharField()
    brand_color = serializers.RegexField(HEX_COLOR_REGEX)


class InviteUsersRequest(serializers.Serializer):
    employer_id = serializers.CharField()
    name = serializers.CharField(max_length=75)
    email = serializers.EmailField()
    role = serializers.ChoiceField(choices=["admin", "supervisor"])


class OrganizationAcceptInvite(serializers.Serializer):
    employer_id = serializers.CharField()
    status = serializers.ChoiceField(
        required=True, choices=["accepted", "declined", "pending"]
    )


class CompanyCreateRequest(serializers.Serializer):
    employer_id = serializers.CharField()
    company_number = serializers.CharField(max_length=8, min_length=8)


class CompanyUpdateVATInfoRequest(serializers.Serializer):
    employer_id = serializers.CharField()
    vat_number = serializers.CharField(max_length=15)
    date_of_registration = serializers.DateField()


class UsersListRequest(serializers.Serializer):
    employer_id = serializers.CharField()
