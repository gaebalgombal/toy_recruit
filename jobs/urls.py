from django.urls.conf import path

from .views import JobDetailView

urlpatterns = [
    # path('/test', test, name="test"),
    path("", JobDetailView.as_view(), name="job-detail"),
    path("/<int:pk>", JobDetailView.as_view(), name="job-detail")
]