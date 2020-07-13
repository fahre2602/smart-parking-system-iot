from django import forms
from .models import List
from .models import Booking
from .models import Akun
from tempus_dominus.widgets import DatePicker, TimePicker, DateTimePicker
import datetime

now = datetime.datetime.now()
class SlotForm(forms.ModelForm):
    class Meta:
        model = List
        fields = ["slot"]

    def __init__(self, *args, **kwargs):
        super(SlotForm, self).__init__(*args, **kwargs)

        # you can iterate all fields here
        for fname, f in self.fields.items():
            f.widget.attrs['class'] = 'form-control'

class BookingForm(forms.ModelForm):
    # booktime = forms.DateTimeField(widget=forms.HiddenInput())
    bookfrom =  forms.DateTimeField(
        widget=DateTimePicker(
            options={
                'format': "YYYY-MM-DD HH:mm:ss", #'%Y-%m-%d %H:%M:%S'
                'useCurrent': True,
                'collapse': True,
            },
            attrs={
                'append': 'fa fa-calendar',
                'icon_toggle': True,
            }
        ),
    )
    bookuntil =  forms.DateTimeField(
        widget=DateTimePicker(
            options={
                'format': "YYYY-MM-DD HH:mm:ss", #'%Y-%m-%d %H:%M:%S'
                'useCurrent': True,
                'collapse': True,
            },
            attrs={
                'append': 'fa fa-calendar',
                'icon_toggle': True,
            }
        ),
    )
    class Meta:
        model = Booking
        fields = ["user", "slot"]
    # slot = forms.CharField(required=True)

class AkunForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    password_confirmation = forms.CharField(widget=forms.PasswordInput)
    class Meta:
        model = Akun
        fields = ["username", "nama"]

    def __init__(self, *args, **kwargs):
        super(AkunForm, self).__init__(*args, **kwargs)

        # you can iterate all fields here
        for fname, f in self.fields.items():
            f.widget.attrs['class'] = 'form-control'

class EditAkunForm(forms.ModelForm):
    nama = forms.CharField()
    class Meta:
        model = Akun
        fields = ["nama"]

class LoginForm(forms.Form):
    password = forms.CharField(widget=forms.PasswordInput)
