from django.urls import path
from . import views
from django.contrib.staticfiles.urls import staticfiles_urlpatterns
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', views.index, name = 'index'),
    path('home/', views.home, name = 'home'),
    path('core/', views.core, name = 'core'),
    path('devices/', views.devices, name = 'devices'),
    path('login/', views.login, name = 'login'),
    path('about1/', views.about1, name = 'about1'),
    path('about2/', views.about2, name = 'about2'),
    path('contact1/', views.contact1, name = 'contact1'),
    path('contact2/', views.contact2, name = 'contact2'),
    path('signup/', views.signup, name = 'signup'),
    path('UnderReview/', views.UnderRiview, name = 'UnderRiview'),
    path('bus/', views.bus, name = 'bus'),
    path('finalize/', views.finalize, name = 'finalize'),
    path('json_return/', views.json_return, name = 'json_return'),
    
]

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)