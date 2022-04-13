from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path("", include("pages.urls")),
    path("soc/", include("soc.urls")),
    path("components/", include("components.urls")),
    path("verification/", include("verification.urls"))
]
