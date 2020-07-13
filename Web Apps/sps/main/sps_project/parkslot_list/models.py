from django.db import models
from datetime import datetime
from passlib.hash import pbkdf2_sha256

# Create your models here.
#Tabel Slot
class List(models.Model):
    slot = models.CharField(max_length=4)
    status = models.CharField(max_length=3)
    lock = models.BooleanField(default=False)

    def __str__(self):
        # return self.slot + ' | ' + str(self.status) + ' | ' + str(self.lock)
        return self.slot
#Tabel HistorySlot
class HistorySlot(models.Model):
    tanggal = models.DateTimeField(auto_now_add = True)
    slot = models.CharField(max_length=4)
    status = models.CharField(max_length=6)
#Tabel HistoryBooking
class HistoryBooking(models.Model):
    booktime = models.DateTimeField(auto_now_add = True)
    username = models.CharField(max_length=20, null = True)
    slot = models.CharField(max_length=4)
    bookfrom = models.DateTimeField()
    bookuntil = models.DateTimeField()
#Tabel HistoryOccupied
class HistoryOccupied(models.Model):
    tanggal = models.DateTimeField(auto_now_add = True)
    slot = models.CharField(max_length=4)
    status = models.CharField(max_length=10)
#Tabel Akun
class Akun(models.Model):
    username = models.CharField(max_length=20, unique=True)
    password = models.CharField(max_length=256)
    nama = models.CharField(max_length=32)

    def __str__(self):
        return self.username
#Tabel Booking
class Booking(models.Model):
    user = models.ForeignKey('Akun', on_delete=models.CASCADE, null=True)
    slot = models.ForeignKey('List', on_delete=models.CASCADE)
    booktime = models.DateTimeField(auto_now_add = True)
    bookfrom = models.DateTimeField()
    bookuntil = models.DateTimeField()
