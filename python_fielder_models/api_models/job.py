from rest_framework import serializers

class ApproveShiftRequestSerializer(serializers.Serializer):
    shift_date = serializers.DateField(format="%Y-%m-%d", input_formats=["%Y-%m-%d"], required=False, allow_null=True)

class UnAssignWorkerfromShiftPatternRequestSerializer(serializers.Serializer):
    worker_id = serializers.CharField() 
    shift_date = serializers.DateField(format="%Y-%m-%d", input_formats=["%Y-%m-%d"])
    range = serializers.ChoiceField(
        (
        "current",
        "future",
        "all"
        )
    )

class DeleteShiftPatternRequestSerializer(serializers.Serializer):
    shift_date = serializers.DateField(format="%Y-%m-%d", input_formats=["%Y-%m-%d"])
    range = serializers.ChoiceField(
        (
        "current",
        "future",
        "all"
        )
    )