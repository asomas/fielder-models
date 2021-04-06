from rest_framework import serializers

DATE_FIELD_REGEX = "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"
PHONE_FIELD_REGEX = "^\+44[0-9]{10}$"
HEX_COLOR_REGEX = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"

COMPANY_NAME_MAX_LENGTH = 156
FULL_NAME_MAX_LENGTH = 75


class AddressBasicDBSerializer(serializers.Serializer):
    name = serializers.CharField(allow_null=True)
    street = serializers.CharField(allow_null=True)
    town = serializers.CharField(allow_null=True)
    county = serializers.CharField(allow_null=True)
    country = serializers.CharField(allow_null=True)
    postcode = serializers.CharField(allow_null=True)
    po_box = serializers.CharField(allow_null=True)


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
