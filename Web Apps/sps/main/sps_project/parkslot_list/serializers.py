from .models import List
from .models import Booking
from rest_framework import serializers


class ListSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = List
        fields = ('id', 'slot', 'status', 'lock')
        extra_kwargs = {"id": {"message": {"Request successfully completed"}}}


class BookingSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Booking
        fields = ('booktime', 'slot', 'bookfrom', 'bookuntil')
