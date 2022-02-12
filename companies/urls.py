from django.urls.conf import path

from companies.views import CompanyDetailView

urlpatterns = [
    path("", CompanyDetailView.as_view(), name="company-detail"),
    path("/<int:pk>", CompanyDetailView.as_view(), name="company-detail")
]