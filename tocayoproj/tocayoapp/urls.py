from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    # ex: /tocayoapp/5/
    url(r'^desig/(?P<desig_id>[0-9]+)/$', views.detail, name='detail'),
    ]
