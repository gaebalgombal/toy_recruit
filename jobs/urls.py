from django.urls.conf import path

from rest_framework.routers import DefaultRouter

from .views import JobDetailView


router = DefaultRouter(trailing_slash=False)
router.register(r"/detail", JobDetailView, basename="job-detial ")


urlpatterns = [
    # path('/test', test, name="test"),
    path("", JobDetailView.as_view(), name="job-detail"),
    path("/<int:pk>", JobDetailView.as_view(), name="job-detail")
]