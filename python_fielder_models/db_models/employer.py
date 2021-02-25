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

    email = serializers.EmailField(required=True)  # string with email validation,
    organisations = serializers.DictField(
        child=UserOrganisationSerialiser(), allow_empty=True
    )
    # The above is a map where each key in the map is a firestore document reference to an employer document, the value value is the status/role information.
    # date_created = (
    #     FirestoreTimeStampSerialiser()
    # )  # @sarmad need to create this serializer


# not new
class EmployerSerialiser(serializers.Serializer):
    """collection with name employers"""

    name = serializers.CharField(max_length=75)
    brand_banner = serializers.CharField(required=True, allow_null=True)
    brand_logo = serializers.CharField(required=True, allow_null=True)
    brand_banner = serializers.CharField(required=True, allow_null=True)
