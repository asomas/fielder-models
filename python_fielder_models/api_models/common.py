from rest_framework import serializers


class AcceptedResponse(serializers.Serializer):
    accepted = serializers.BooleanField(default=True)


class AddressSerializer(serializers.Serializer):
    flat = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    building = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    street = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    county = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    city = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    country = serializers.CharField(allow_null=True, allow_blank=True, default=None)
    postal_code = serializers.CharField(allow_null=True, allow_blank=True, default=None)


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


class LocationSerializer(serializers.Serializer):
    address = AddressSerializer()
    name = serializers.CharField(allow_blank=True, allow_null=True, default=None)
