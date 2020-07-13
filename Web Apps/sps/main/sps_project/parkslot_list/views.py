from django.shortcuts import render, redirect
from .models import List
from .models import HistorySlot
from .models import HistoryBooking
from .models import HistoryOccupied
from .models import Booking
from .models import Akun
from .forms import SlotForm
from .forms import BookingForm
from .forms import AkunForm
from .forms import EditAkunForm
from .forms import LoginForm
from django.contrib import messages
from datetime import datetime
from rest_framework import viewsets
from .serializers import ListSerializer, BookingSerializer
from passlib.hash import pbkdf2_sha256
import hashlib
import paho.mqtt.publish as publish
import paho.mqtt.subscribe as subscribe
import time
import sweetify

class ListViewSet(viewsets.ModelViewSet):
    queryset = List.objects.all()
    serializer_class = ListSerializer

class BookingViewSet(viewsets.ModelViewSet):
    queryset = Booking.objects.all()
    serializer_class = BookingSerializer


# Prosedur on_message
# Deskripsi : Menginisialisasi mqtt untuk web apps, standby menunggu pesan
# Input : client, userdata, message
# Output : -
def on_message(client, userdata, message):
    msg = subscribe.simple("sps", hostname="192.168.1.93")
    pesan = msg.payload
    sumber,tujuan,perintah,idslot = pesan.split("_")
    if idslot == "S001":
        idslot = "1"
    elif idslot == "S002":
        idslot = "2"
    elif idslot == "S003":
        idslot = "3"
    elif idslot == "S004":
        idslot = "4"
    elif idslot == "S005":
        idslot = "5"
    elif idslot == "S006":
        idslot = "6"
    elif idslot == "S007":
        idslot = "7"
    elif idslot == "S008":
        idslot = "8"
    elif idslot == "S009":
        idslot = "9"
    elif idslot == "S010":
        idslot = "10"

    if perintah == "lock" and tujuan == "server" and idslot != "":
        # write to database status LOCK
        slot_edit = List.objects.get(pk=idslot)
        if slot_edit.lock == False:
            slot_edit.lock = True
            # Operasi saveSlot()
            slot_edit.save()
            form.save()
            # Operasi saveHistorySlot()
            histori = HistorySlot(tanggal="", slot=slot_edit.slot, status="Lock")
            histori.save()
    elif perintah == "unlock" and tujuan == "server" and idslot != "":
        # write to database status UNLOCK
        slot = List.objects.get(pk=idslot)
        if slot.lock == True:
            slot.lock = False
            # Operasi saveSlot()
            slot.save()
            # Operasi saveHistorySlot()
            histori = HistorySlot(tanggal="", slot=slot.slot, status="Unlock")
            histori.save()
    elif perintah == "occupied" and tujuan == "server" and idslot != "":
        # write database status OCCUPIED
        slot = List.objects.get(pk=idslot)
        if slot.status == "no":
            slot.status = "yes"
            # Operasi saveSlot()
            slot.save()
            # Operasi saveHistorySlot()
            histori = HistorySlot(tanggal="", slot=slot.slot, status="Occupied")
            histori.save()
    elif perintah == "unoccupied" and tujuan == "server" and idslot != "":
        # write database status UNOCCUPIED
        slot = List.objects.get(pk=idslot)
        if slot.status == "yes":
            slot.status = "no"
            # Operasi saveSlot()
            slot.save()
            # Operasi saveHistorySlot()
            histori = HistorySlot(tanggal="", slot=slot.slot, status="Unoccupied")
            histori.save()
    else:
        print("perintah tidak diketahui")

# Create your views here.
# Fungsi home
# Deskripsi : Memuat laman awal sekaligus fungsi login ke web apps; load list slot parkir yang tersedia
# Input : request
# Output : render()
def home(request):
    loginstatus = None
    form = LoginForm()
    formtambahslot = SlotForm()
    # Operasi getListSlot()
    all_slots = List.objects.all
    if request.method == 'GET':
        if 'action' in request.GET:
            action = request.GET.get('action')
            if action == 'logout':
                if request.session.has_key('loginstatus'):
                    request.session.flush()
                return redirect('home')

        if 'loginstatus' in request.session:
            loginstatus = request.session['loginstatus']
            print(request.session.get_expiry_age())
            print(request.session.get_expiry_date())

    elif request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            # Operasi cekPassword()
            password = form.cleaned_data.get('password')
            password_confirmation = "123"
            if (password == password_confirmation):
                request.session['loginstatus'] = "login"
                return redirect('home')
            else:
                loginstatus = None

    return render(request, "home.html", {'all_slots': all_slots,'form': form, 'formtambahslot':formtambahslot, 'loginstatus':loginstatus})

# Fungsi edit
# Deskripsi : Memuat laman serta fungsi edit slot parkir
# Input : request, list_id
# Output : render()
def edit(request, list_id):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')
    if request.method == 'POST':
        # Operasi getSlot()
        slot = List.objects.get(pk=list_id)
        form = SlotForm(request.POST or None, instance=slot)

        if form.is_valid():
            # Operasi saveSlot()
            form.save()
            messages.success(request, ('Slot berhasil di edit'))
            return redirect('home')
    else:
        # Operasi getSlot()
        slot = List.objects.get(pk=list_id)
        return render(request, 'edit.html', {'slot': slot})

# Fungsi tambahslot
# Deskripsi : Memuat laman serta fungsi edit slot parkir
# Input : request, list_id
# Output : render()
def tambahslot(request):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')
    if request.method == 'POST':
        form = SlotForm(request.POST or None)
        if form.is_valid():
            slot = form.cleaned_data['slot']
            # Operasi getSlot()

            if not List.objects.filter(slot=slot).exists():
                # Operasi saveSlot()
                List.objects.create(
                    slot = slot,
                    status = "no",
                    lock = False
                )
                messages.success(request, ('Slot berhasil ditambahkan'))
                return redirect('home')
            else:
                messages.error(request, 'Slot gagal ditambahkan karena sudah ada dalam storage')
                return redirect('home')
        else:
            messages.error(request, 'Form tidak valid')
            return redirect('home')
    else:
        return render(request, 'home.html', {'slot': slot})

# Fungsi editAkun
# Deskripsi : Memuat laman edit akun serta fungsi edit akun
# Input : request, akun_id
# Output : render()

# Operasi editAkun()
def editakun(request, akun_id):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')
    if request.method == 'POST':
        # Operasi getAkun()
        akun = Akun.objects.get(pk=akun_id)
        form = EditAkunForm(request.POST or None, instance=akun)

        if form.is_valid():
            # Operasi saveAkun()
            form.save()
            messages.success(request, ('Akun berhasil di edit'))
            return redirect('manageusers')
    else:
        # Operasi getAkun()
        akun = Akun.objects.get(pk=akun_id)
        return render(request, 'manageusers.html', {'akun': akun})

# Fungsi booking
# Deskripsi : Memuat laman booking termasuk form booking; melakukan fungsi booking slot parkir
# Input : request
# Output : render()

# Operasi bookingSlot()
def booking(request):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')
    if request.method == 'POST':
        form = BookingForm(request.POST or None)
        if form.is_valid():
            # booktime = form.cleaned_data['booktime']
            bookfrom = form.cleaned_data['bookfrom']
            bookuntil = form.cleaned_data['bookuntil']
            slot = form.cleaned_data['slot']
            user = form.cleaned_data['user']
            # Operasi getSlot()
            slot_edit = List.objects.get(pk=slot.id)
            if slot_edit.lock == False:
                slot_edit.lock = True
                # Operasi saveSlot()
                slot_edit.save()
                # Operasi saveBooking()
                Booking.objects.create(
                    # booktime = booktime,
                    bookfrom = bookfrom,
                    bookuntil = bookuntil,
                    slot = slot,
                    user = user
                )
                # Operasi saveHistorySlot()
                histori = HistorySlot(tanggal="", slot=slot_edit.slot, status="Lock")
                histori.save()
                # Operasi saveHistoryBooking()
                historibooking = HistoryBooking(booktime="", username="admin", slot=slot_edit.slot, bookfrom=bookfrom, bookuntil=bookuntil)
                historibooking.save()
                messages.success(request, ('Slot parkir berhasil di booking'))
                publish.single("sps", "server_pi_lock_"+str(slot.id), hostname="192.168.1.73") # MQTT PUBLISH
                return redirect('home')
            else:
                messages.success(request, ('Slot parkir tidak bisa di booking'))
                return redirect('home')
        else:
            # messages.success(request, ('Gagal'))
            sweetify.error(request, "Gagal !", persistent=":(")
            return render(request, 'booking.html', {'form': form})
    else:
        form = BookingForm(request.POST or None)
        return render(request, 'booking.html', {'form': form})

# Fungsi history
# Deskripsi : Memuat laman history utama
# Input : request
# Output : render()
def history(request):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')

    return render(request, "history.html")

# Fungsi historyslot
# Deskripsi : Memuat laman history slot parkir
# Input : request
# Output : render()
def historyslot(request):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')

    # Operasi getListHistorySlot()
    all_history_slot = HistorySlot.objects.all
    return render(request, "historyslot.html", {'all_history_slot': all_history_slot})

# Fungsi historybooking
# Deskripsi : Memuat laman history booking
# Input : request
# Output : render()
def historybooking(request):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')

    # Operasi getListHistoryBooking()
    all_history_booking = HistoryBooking.objects.all
    return render(request, "historybooking.html", {'all_history_booking': all_history_booking})

# Fungsi historyoccupied
# Deskripsi : Memuat laman history occupied
# Input : request
# Output : render()
def historyoccupied(request):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')

    # Operasi getListHistoryOccupied()
    all_history_occupied = HistoryOccupied.objects.all
    return render(request, "historyoccupied.html", {'all_history_occupied': all_history_occupied})

# Fungsi manageusers
# Deskripsi : Memuat laman manage users
# Input : request
# Output : render()
def manageusers(request):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')

    # Operasi getListAkun()
    all_akun = Akun.objects.all
    return render(request, "manageusers.html", {'all_akun': all_akun})

# Fungsi delete
# Deskripsi : Menghapus slot parkir yang dipilih pada list slot parkir
# Input : request
# Output : redirect()
def delete(request, list_id):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')

    # Operasi getSlot()
    slot = List.objects.get(pk=list_id)
    # Operasi deleteSlot()
    slot.delete()
    messages.success(request, ('Slot di hapus'))
    return redirect ('home')

# Fungsi unlock
# Deskripsi : Melakukan fungsi unlock slot parkir
# Input : request, list_id
# Output : redirect()

# Operasi unlockSlot()
def unlock(request, list_id):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')

    # Operasi getSlot()
    slot = List.objects.get(pk=list_id)
    if slot.lock == True:
        slot.lock = False
        # Operasi saveSlot()
        slot.save()
        # Operasi saveHistorySlot()
        histori = HistorySlot(tanggal="", slot=slot.slot, status="Unlock")
        histori.save()
        if Booking.objects.filter(slot=list_id).exists():
            # Operasi deletebooking()
            booking = Booking.objects.get(slot=list_id)
            booking.delete()
        messages.success(request, ('Slot berhasil di unlock'))
        sweetify.success(request, "Slot berhasil di unlock", persistent=":)")
        publish.single("sps", "server_pi_unlock_"+str(list_id), hostname="192.168.1.73") # MQTT PUBLISH
        return redirect ('home')
    else:
        messages.success(request, ('Slot sudah dalam keadaan unlock'))
        return redirect ('home')

# Fungsi refreshbooking
# Deskripsi : Melakukan refresh halaman booking untuk menghapus jika terdapat booking yang melebihi jadwal
# Input : request
# Output : redirect()

# Operasi refreshBooking()
def refreshbooking(request):
    #cek lock/unlock
    timestamp_now = time.time()
    bookings = Booking.objects.all()
    for x in bookings:
        waktu = x.bookuntil
        timestamp = datetime.timestamp(waktu)
        if timestamp_now > timestamp:
            slotx = x.slot
            # Operasi getSlot()
            slot = List.objects.get(pk=slotx.id)
            slot.lock = False
            # Operasi saveSlot()
            slot.save()
            # Operasi saveHistorySlot()
            histori = HistorySlot(tanggal="", slot=slot.slot, status="Unlock")
            histori.save()
            # Operasi deleteBooking()
            x.delete()
    n = 0
    while n < 11 :
        time.sleep(1)
        n = n + 1
        if n == 10:
            print("refreshing booking table...")
            return redirect ('refreshbooking')

# Fungsi creatuser
# Deskripsi : Memuat laman pembuatan akun baru termasuk form pendaftaran akun baru; Fungsi pembuatan akun baru
# Input : request
# Output : render()

# Operasi createAkun()
def createuser(request):
    if 'loginstatus' in request.session:
        loginstatus = request.session['loginstatus']
    else:
        messages.success(request, ('Silahkan login terlebih dahulu!'))
        return redirect('home')
    if request.method == 'POST':
        form = AkunForm(request.POST or None)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            raw_password = form.cleaned_data.get('password')
            password_confirmation = form.cleaned_data.get('password_confirmation')
            nama = form.cleaned_data.get('nama')
            if (raw_password == password_confirmation):
                enc_password = hashlib.md5(raw_password.encode())
                # Operasi saveAkun()
                Akun.objects.create(
                    username = username,
                    password = enc_password.hexdigest(),
                    nama = nama
                )
                messages.success(request, ('Akun user baru telah ditambahkan'))
                return redirect('home')
            else:
                messages.success(request, ('Password konfirmasi tidak sesuai'))
                return render(request, 'createuser.html', {'form': form})
        else:
            messages.success(request, ('Gagal menyimpan akun user'))
            return render(request, 'createuser.html', {'form': form})
    else:
        form = AkunForm(request.POST or None)
        return render(request, 'createuser.html', {'form': form})
