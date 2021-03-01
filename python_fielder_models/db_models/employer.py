from rest_framework import serializers
from common import *

# new
class UserOrganisationSerialiser(serializers.Serializer):
    name = serializers.CharField(max_length=COMPANY_NAME_MAX_LENGTH)
    status = serializers.ChoiceField(
        required=True, choices=["accepted", "declined", "pending"]
    )
    role = serializers.ChoiceField(
        required=True, choices=["owner", "manager", "superviser"]
    )


# new
class EmployerUserSerialiser(serializers.Serializer):
    """collection with name employer_users"""

    name = serializers.CharField()
    email = serializers.EmailField()
    organisations = serializers.DictField(
        child=UserOrganisationSerialiser(), allow_empty=True
    )
    date_created = serializers.DateTimeField()


class ContactSerializer(serializers.Serializer):
    name = serializers.CharField(max_length=FULL_NAME_MAX_LENGTH)
    phone = serializers.RegexField(PHONE_FIELD_REGEX)
    email = serializers.EmailField()


class EmployerSerializer(serializers.Serializer):
    """collection with name employers"""

    company_name = serializers.CharField(max_length=COMPANY_NAME_MAX_LENGTH)
    brand_color = serializers.RegexField(HEX_COLOR_REGEX)


class BillingContact(ContactSerializer):
    """Document has fixed ID, billing_contact, inside Subcollection called company_info.  So the complete path to this document is  employers/employer_id/company_info/billing_contact"""

    # note, inherits fields from contacts Serialiser
    pass


class GeneralContact(ContactSerializer):
    """Document has fixed ID, general_contact, inside Subcollection called company_info.  So the complete path to this document is  employers/employer_id/company_info/general_contact"""

    # note, inherits fields e.g. email from contacts Serialiser
    website = serializers.URLField()


class SICCodeSerializer(serializers.Serializer):
    code = serializers.CharField()
    description = serializers.CharField(max_length=200)


class CompanySerializer(serializers.Serializer):
    """Document has fixed ID, main, inside Subcollection called company_info.  So the complete path to this document is  employers/employer_id/company_info/main"""

    class DirectorSerializer(serializers.Serializer):
        name = serializers.CharField(max_length=FULL_NAME_MAX_LENGTH)
        appointment_date = serializers.DateTimeField()

    name = serializers.CharField(max_length=COMPANY_NAME_MAX_LENGTH)
    incorporation_date = serializers.DateTimeField()
    registration_number = serializers.CharField(min_length=8, max_length=8)
    sic_codes = serializers.ListField(allow_empty=False, child=SICCodeSerializer())
    directors = serializers.ListField(allow_empty=False, child=DirectorSerializer())
    address = AddressBasicDBSerializer()
    last_updated = serializers.DateTimeField()
    last_filing_date = serializers.DateTimeField()
    vat_number = serializers.CharField(max_length=15)
    vat_registration_date = serializers.DateTimeField()
