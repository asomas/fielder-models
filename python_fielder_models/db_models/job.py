from datetime import datetime
from enum import Enum, auto

from fielder_backend_utils.rest_utils import DocumentReferenceField
from python_fielder_models.api_models.matching import WorkerType
from python_fielder_models.common.job import BaseJobSerializer
from python_fielder_models.db_models.common import (
    AddressDBSerializer,
    RecurrenceSerializer,
)
from python_fielder_models.db_models.organisation import (
    OrganisationLocationDBSerializer,
)
from rest_framework import serializers


class OfferStatus(Enum):
    ACCEPTED = auto()
    DECLINED = auto()
    PENDING_CHECKS_BACKOFFICE = auto()
    PENDING_CHECKS_WORKER = auto()
    PENDING_WORKER_FINAL_CONFIRMATION = auto()
    PENDING_WORKER_RESPONSE = auto()
    QUEUED = auto()
    RETRACTED = auto()


class PaymentDBSerializer(serializers.Serializer):
    class StatutaryCostsSerializer(serializers.Serializer):
        total = serializers.FloatField()
        ni_contribution = serializers.FloatField()
        pension_contribution = serializers.FloatField()
        apprentice_levy = serializers.FloatField()
        sick_leave = serializers.FloatField()

    worker_rate = serializers.IntegerField()
    holiday_pay = serializers.IntegerField()
    statutary_costs = StatutaryCostsSerializer()
    total_cost_excl_fees = serializers.FloatField()
    umbrella_fee = serializers.FloatField()
    finders_fee = serializers.FloatField()
    total_umbrella_service_cost = serializers.IntegerField()
    total_staffing_service_cost = serializers.IntegerField()


class ShiftBudgetSharedDBSerializer(serializers.Serializer):
    enable_unpaid_breaks = serializers.BooleanField(default=False)
    enable_late_deduction = serializers.BooleanField(default=False)
    late_arrival = serializers.ChoiceField((0, 15, 30, 60), default=15)
    enable_early_deduction = serializers.BooleanField(default=False)
    early_leaver = serializers.ChoiceField((0, 15, 30, 60), default=15)


class ShiftBudgetDBSerializer(ShiftBudgetSharedDBSerializer):
    payment = PaymentDBSerializer()
    volunteer = serializers.BooleanField(default=False)
    pay_calculation = serializers.ChoiceField(
        (
            "Actual hours",
            "Shift hours",
        ),
        default="Actual hours",
    )
    overtime_rate = serializers.IntegerField(default=0)
    overtime_threshold = serializers.ChoiceField((0, 15, 30, 60), default=15)


class SharedJobShiftDBSerializer(BaseJobSerializer):
    end_date = serializers.DateTimeField(default=None, allow_null=True)
    job_reference_id = serializers.CharField()
    manager_ref = DocumentReferenceField(default=None, allow_null=True)
    supervisor_ref = DocumentReferenceField(default=None, allow_null=True)
    total_shift_count = serializers.IntegerField()

    created_at = serializers.DateTimeField(default=datetime.now())
    updated_at = serializers.DateTimeField(default=datetime.now())

    def to_internal_value(self, data):
        data["updated_at"] = datetime.now()
        return super().to_internal_value(data)


class ShiftPatternDBSerializer(
    SharedJobShiftDBSerializer, ShiftBudgetSharedDBSerializer
):
    start_date = serializers.DateTimeField()
    start_time = serializers.IntegerField()
    end_time = serializers.IntegerField()
    multi_day_shift = serializers.BooleanField(default=False)
    is_recurring = serializers.BooleanField(default=False)
    recurrence = RecurrenceSerializer()
    location_ref = DocumentReferenceField(default=None, allow_null=True)
    location_data = OrganisationLocationDBSerializer()
    assigned = serializers.BooleanField(default=False)
    geo_fence_distance = serializers.IntegerField(default=0)
    geo_fence_enabled = serializers.BooleanField(default=False)
    job_ref = DocumentReferenceField()
    role = serializers.CharField(required=False)
    shift_pattern_reference_id = serializers.CharField()
    total_shift_hours = serializers.FloatField()
    worker_ref = DocumentReferenceField(default=None, allow_null=True)
    worker_data = serializers.DictField(default=None, allow_null=True)
    shift_note_ref = DocumentReferenceField(
        required=False,
        default=None,
        allow_null=True,
    )


class JobDBSerializer(SharedJobShiftDBSerializer):
    start_date = serializers.DateTimeField(default=None, allow_null=True)
    description = serializers.CharField(allow_null=True, default=None)
    total_hours = serializers.FloatField(default=0.0)
    locations = serializers.DictField(child=AddressDBSerializer(), default={})
    workers = serializers.DictField(default={})
    is_archived = serializers.BooleanField(default=False)
    active = serializers.BooleanField(default=True)


class JobTemplateDBSerializer(BaseJobSerializer):
    name = serializers.CharField()
    description = serializers.CharField(allow_null=True, default=None)


class OfferDBSerializer(serializers.Serializer):
    shift_pattern_ref = DocumentReferenceField()
    worker_ref = DocumentReferenceField()
    worker_type = serializers.ChoiceField(choices=WorkerType._member_names_)
    job_ref = DocumentReferenceField()
    shift_pattern_data = serializers.DictField()
    job_data = serializers.DictField()
    status = serializers.ChoiceField(choices=OfferStatus._member_names_)
    expiry_time = serializers.DateTimeField(allow_null=True, default=None)
    sent_time = serializers.DateTimeField(allow_null=True, default=None)
    budget = serializers.DictField()

    created_at = serializers.DateTimeField(default=datetime.now())
    updated_at = serializers.DateTimeField(default=datetime.now())

    def to_internal_value(self, data):
        data["updated_at"] = datetime.now()
        return super().to_internal_value(data)


class ShiftNoteDBSerializer(serializers.Serializer):
    value = serializers.CharField()


class ShiftActivityBreakDBSerializer(serializers.Serializer):
    start_time = serializers.DateTimeField()
    end_time = serializers.DateTimeField()
    duration = serializers.IntegerField()
    early_stop = serializers.BooleanField(default=False)
