from django.utils import timezone
from fielder_backend_utils.rest_utils import DocumentReferenceField, LowercaseEmailField
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
    email = LowercaseEmailField()
    organisation_user_reference_id = serializers.CharField()
    organisations = serializers.DictField(
        child=OrganisationSubscriptionSerializer(), allow_empty=True
    )
    date_created = serializers.DateTimeField()


class ContactSerializer(serializers.Serializer):
    name = serializers.CharField(
        max_length=FULL_NAME_MAX_LENGTH, required=False, allow_null=True
    )
    phone = serializers.RegexField(PHONE_FIELD_REGEX, required=False, allow_null=True)
    email = LowercaseEmailField(required=False, allow_null=True)


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

    group_billing_enabled = serializers.BooleanField(required=False)


class GeneralContact(ContactSerializer):
    """Document has fixed ID, general_contact, inside Subcollection called company_info.  So the complete path to this document is  organisations/organisation_id/company_info/general_contact"""

    # note, inherits fields e.g. email from contacts Serializer
    website = serializers.RegexField(WEBSITE_REGEX, required=False, allow_null=True)


class OrganisationLocationDBSerializer(LocationDBSerializer):
    archived = serializers.BooleanField(default=False)
    created_at = serializers.DateTimeField(default=timezone.now)
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
