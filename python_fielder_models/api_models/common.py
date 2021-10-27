from rest_framework import serializers


class UserPromptSerializer(serializers.Serializer):
    title = serializers.CharField()
    subtitle = serializers.CharField()
    read_more_button_text = serializers.CharField(
        required=False, allow_null=True, default=None
    )
    read_more_action_url = serializers.CharField(
        required=False, allow_null=True, default=None
    )


class AcceptedResponse(serializers.Serializer):
    accepted = serializers.BooleanField(default=True)


class SumsubAddressSerializer(serializers.Serializer):
    building = serializers.CharField(required=False, allow_null=True, default=None)
    street = serializers.CharField(required=False, allow_null=True, default=None)
    house_number = serializers.CharField(required=False, allow_null=True, default=None)
    locality = serializers.CharField(required=False, allow_null=True, default=None)
    town = serializers.CharField()
    postcode = serializers.CharField()


class GeolocationSerializer(serializers.Serializer):
    lat = serializers.FloatField()
    lng = serializers.FloatField()


class GooglePlaceDataSerializer(serializers.Serializer):
    google_place_id = serializers.CharField(required=True)
    coords = GeolocationSerializer()


class AddressAPISerializer(serializers.Serializer):
    flat = serializers.CharField(allow_null=True, allow_blank=True)
    building = serializers.CharField(allow_null=True, allow_blank=True)
    street = serializers.CharField(allow_null=True, allow_blank=True)
    county = serializers.CharField(allow_null=True, allow_blank=True)
    city = serializers.CharField(allow_null=True, allow_blank=True)
    country = serializers.CharField(allow_null=True, allow_blank=True)
    postal_code = serializers.CharField(allow_null=True, allow_blank=True)


class LocationAPISerializer(serializers.Serializer):
    address = AddressAPISerializer()
    coords = GeolocationSerializer(required=False)
