from django.urls import include, path
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
router.register(r'getSlots', views.ListViewSet)

urlpatterns = [
    path('', views.home, name="home"),
    path('', include(router.urls)),
    path('delete/<list_id>', views.delete, name="delete"),
    path('edit/<list_id>', views.edit, name="edit"),
    path('editakun/<akun_id>', views.editakun, name="editakun"),
    path('history', views.history, name="history"),
    path('historyslot', views.historyslot, name="historyslot"),
    path('historybooking', views.historybooking, name="historybooking"),
    path('historyoccupied', views.historyoccupied, name="historyoccupied"),
    path('manageusers', views.manageusers, name="manageusers"),
    path('booking', views.booking, name="booking"),
    path('unlock/<list_id>', views.unlock, name="unlock"),
    path('refreshbooking', views.refreshbooking, name="refreshbooking"),
    path('createuser', views.createuser, name="createuser"),
    path('tambahslot', views.tambahslot, name="tambahslot"),
]
