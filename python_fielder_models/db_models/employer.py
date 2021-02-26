from rest_framework import serializers

# new
class UserOrganisationSerialiser(serializers.Serializer):
    """helper"""

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


# not new
class EmployerSerialiser(serializers.Serializer):
    """collection with name employers"""

    name = serializers.CharField(max_length=75)
    brand_banner = serializers.CharField(required=True, allow_null=True)
    brand_logo = serializers.CharField(required=True, allow_null=True)
    brand_banner = serializers.CharField(required=True, allow_null=True)
