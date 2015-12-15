from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    # ex: /tocayoapp/5/
    url(r'^author/(?P<author_id>[0-9]+)/$', views.author, name='author'),
    url(r'^gender/(?P<gender_id>[0-9]+)/$', views.gender, name='gender'),
    url(r'^token/(?P<token_id>[0-9]+)/$', views.token, name='token'),
    url(r'^desig/(?P<desig_id>[0-9]+)/$', views.desig, name='desig'),
    url(r'^lang/(?P<lang_id>[0-9]+)/$', views.lang, name='lang'),
    url(r'^scopetype/(?P<scopetype_id>[0-9]+)/$', views.scopeType, name='scopetype'),
    url(r'^scope/(?P<scope_id>[0-9]+)/$', views.scope, name='scope'),
    url(r'^utter/(?P<utter_id>[0-9]+)/$', views.utter, name='utter'),
    url(r'^pronounce/(?P<pronounce_id>[0-9]+)/$', views.pronounce, name='pronounce'),
    url(r'^survey/(?P<survey_id>[0-9]+)/$', views.survey, name='survey'),
    url(r'^freq/(?P<freq_id>[0-9]+)/$', views.freq, name='freq'),
    url(r'^idea/(?P<idea_id>[0-9]+)/$', views.idea, name='idea'),
    url(r'^meaning/(?P<meaning_id>[0-9]+)/$', views.meaning, name='meaning'),
    url(r'^onto/(?P<onto_id>[0-9]+)/$', views.onto, name='onto'),
    ]
