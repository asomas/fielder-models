from rest_framework import serializers

DATE_FIELD_REGEX = "[0-9]{4}-[0-9]{2}-[0-9]{2}"


class AddressBasicDBSerializer(serializers.Serializer):
    county = serializers.CharField(allow_null=True)
    country = serializers.CharField()
    line_1 = serializers.CharField()
    line_2 = serializers.CharField(allow_null=True)
    postcode = serializers.CharField()
    po_box = serializers.CharField(allow_null=True)
    town = serializers.CharField()


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
