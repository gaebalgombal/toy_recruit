from django.urls.conf import path

from jobs.views import JobDetailView

urlpatterns = [
    path("", JobDetailView.as_view(), name="job-detail"),
    path("/<int:pk>", JobDetailView.as_view(), name="job-detail")
]