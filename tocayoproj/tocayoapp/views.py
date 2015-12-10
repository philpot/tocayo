from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse
from django.template import RequestContext, loader
from .models import Desig

def index(request):
    return HttpResponse("Hello, world. You're at the tocayoproj/tocayoapp index.")

def detail(request, desig_id):
    return HttpResponse("You're looking at desig %s." % desig_id)

def detail(request, desig_id):
    try:
        d = Desig.objects.get(id=int(desig_id))
        report = "{} is pronounced {}".format(d, [str(x) for x in d.pronounce_set.all()])
        # freq_set', 'meaning_set', 'pronounce_set', 'scope_set'
    except:
        report = "%r" % desig_id
    return HttpResponse("You're looking at desig %s." % (report))


def detail(request, desig_id):
    try:
        desig = Desig.objects.get(id=int(desig_id))
        meaning_set = desig.meaning_set.all()
        template = loader.get_template('tocayoapp/index.html')
        context = RequestContext(request, {'desig': desig,
                                           'meaning_set': meaning_set})
        return HttpResponse(template.render(context))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
