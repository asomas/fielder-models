from rest_framework import serializers

from ..db_models.common import PHONE_FIELD_REGEX
from ..db_models.employer import BillingContact, GeneralContact


class EmailExistsRequest(serializers.Serializer):
    email = serializers.EmailField()


class EmailExistsResponse(serializers.Serializer):
    user_exists = serializers.BooleanField()


class KeyContactsRequest(serializers.Serializer):
    billing_contact = BillingContact(required=True)
    general_contact = GeneralContact()
    website = serializers.URLField()
    phone = serializers.RegexField(PHONE_FIELD_REGEX)
