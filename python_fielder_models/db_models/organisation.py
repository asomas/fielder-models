from rest_framework import serializers

from .common import *


# new
class OrganisationSubscriptionSerializer(serializers.Serializer):
    company_name = serializers.CharField(max_length=COMPANY_NAME_MAX_LENGTH)
    signup_status = serializers.ChoiceField(
        choices=("contract_not_signed", "contract_in_review", "contract_signed")
    )
    status = serializers.ChoiceField(
        required=True, choices=["accepted", "declined", "pending"]
    )
    role = serializers.ChoiceField(
        required=True, choices=["owner", "admin", "hr", "manager", "supervisor"]
    )
    manager = serializers.CharField(required=False, allow_null=True)


# new
class OrganisationUserSerializer(serializers.Serializer):
    """collection with name organisation_users"""

    name = serializers.CharField()
    email = serializers.EmailField()
    organisations = serializers.DictField(
        child=OrganisationSubscriptionSerializer(), allow_empty=True
    )
    date_created = serializers.DateTimeField()


class ContactSerializer(serializers.Serializer):
    name = serializers.CharField(
        max_length=FULL_NAME_MAX_LENGTH, required=False, allow_null=True
    )
    phone = serializers.RegexField(PHONE_FIELD_REGEX, required=False, allow_null=True)
    email = serializers.EmailField(required=False, allow_null=True)


class OrganisationSerializer(serializers.Serializer):
    """collection with name organisations"""

    company_name = serializers.CharField(max_length=COMPANY_NAME_MAX_LENGTH)
    organisation_reference_id = serializers.CharField(max_length=6)
    brand_color = serializers.RegexField(HEX_COLOR_REGEX)
    signup_status = serializers.ChoiceField(
        choices=("contract_not_signed", "contract_in_review", "contract_signed")
    )


class BillingContact(ContactSerializer):
    """Document has fixed ID, billing_contact, inside Subcollection called company_info.  So the complete path to this document is  organisations/organisation_id/company_info/billing_contact"""

    # note, inherits fields from contacts Serializer
    pass


class GeneralContact(ContactSerializer):
    """Document has fixed ID, general_contact, inside Subcollection called company_info.  So the complete path to this document is  organisations/organisation_id/company_info/general_contact"""

    # note, inherits fields e.g. email from contacts Serializer
    website = serializers.RegexField(WEBSITE_REGEX, required=False, allow_null=True)
