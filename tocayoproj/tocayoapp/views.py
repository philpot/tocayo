from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse
from django.template import RequestContext, loader
from .models import Author, Gender, Token, Desig, Lang, ScopeType, Scope, Utter, Pronounce, Survey, Freq, Idea, Meaning, Onto


def index(request):
    return HttpResponse("Hello, world. You're at the tocayoproj/tocayoapp index.")

# def detail(request, desig_id):
#     return HttpResponse("You're looking at desig %s." % desig_id)

# def detail(request, desig_id):
#     try:
#         d = Desig.objects.get(id=int(desig_id))
#         report = "{} is pronounced {}".format(d, [str(x) for x in d.pronounce_set.all()])
#         # freq_set', 'meaning_set', 'pronounce_set', 'scope_set'
#     except:
#         report = "%r" % desig_id
#     return HttpResponse("You're looking at desig %s." % (report))

def author(request, author_id):
    try:
        author = Author.objects.get(id=int(author_id))
        params = {'author': author}
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))

def gender(request, gender_id):
    try:
        gender = Gender.objects.get(id=int(gender_id))
        desig_set = gender.desig_set.all()[0:10]
        survey_set = gender.survey_set.all()
        template = loader.get_template('tocayoapp/gender.html')
        params = {'gender': gender,
                  'desig_set': desig_set,
                  'survey_set': survey_set}
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))

def desig(request, desig_id):
    try:
        desig = Desig.objects.get(id=int(desig_id))
        meaning_set = desig.meaning_set.all()
        scope_set = desig.scope_set.all()
        pronounce_set = desig.pronounce_set.all()
        template = loader.get_template('tocayoapp/desig.html')
        params = {'desig': desig,
                  'meaning_set': meaning_set,
                  'scope_set': scope_set,
                  'pronounce_set': pronounce_set
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))

def token(request, token_id):
    try:
        token = Token.objects.get(id=int(token_id))
        desig_set = token.desig_set.all()
        template = loader.get_template('tocayoapp/token.html')
        params = {'token': token,
                  'desig_set': desig_set
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def lang(request, lang_id):
    try:
        lang = Lang.objects.get(id=int(lang_id))
        scope_set = lang.scope_set.all()
        template = loader.get_template('tocayoapp/lang.html')
        params = {'lang': lang,
                  'scope_set': scope_set
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def scopeType(request, scopeType_id):
    try:
        scopeType = Scopetype.objects.get(id=int(scopeType_id))
        scope_set = scopeType.scope_set.all()
        template = loader.get_template('tocayoapp/scopetype.html')
        params = {'scopeType': scopeType,
                  'scope_set': scope_set
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def scope(request, scope_id):
    try:
        scope = Scope.objects.get(id=int(scope_id))
        template = loader.get_template('tocayoapp/scope.html')
        params = {'scope': scope
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def utter(request, utter_id):
    try:
        utter = Utter.objects.get(id=int(utter_id))
        pronounce_set = utter.pronounce_set.all()
        template = loader.get_template('tocayoapp/utter.html')
        params = {'utter': utter,
                  'pronounce_set': pronounce_set
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def pronounce(request, pronounce_id):
    try:
        pronounce = Pronounce.objects.get(id=int(pronounce_id))
        template = loader.get_template('tocayoapp/pronounce.html')
        params = {'pronounce': pronounce
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def survey(request, survey_id):
    try:
        survey = Survey.objects.get(id=int(survey_id))
        freq_set = survey.freq_set.all()
        template = loader.get_template('tocayoapp/survey.html')
        params = {'survey': survey,
                  'freq_set': freq_set
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def freq(request, freq_id):
    try:
        freq = Freq.objects.get(id=int(freq_id))
        template = loader.get_template('tocayoapp/freq.html')
        params = {'freq': freq
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def idea(request, idea_id):
    try:
        idea = Idea.objects.get(id=int(idea_id))
        meaning_set = idea.meaning_set.all()
        onto_child_set = idea.onto_child_set.all()
        onto_parent_set = idea.onto_parent_set.all()
        template = loader.get_template('tocayoapp/idea.html')
        params = {'idea': idea,
                  'meaning_set': meaning_set,
                  'onto_child_set': onto_child_set,
                  'onto_parent_set': onto_parent_set
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def meaning(request, meaning_id):
    try:
        meaning = Meaning.objects.get(id=int(meaning_id))
        template = loader.get_template('tocayoapp/meaning.html')
        params = {'meaning': meaning
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("Not implemented yet")

def onto(request, onto_id):
    try:
        onto = Onto.objects.get(id=int(onto_id))
        template = loader.get_template('tocayoapp/onto.html')
        params = {'onto': onto
                  }
        return HttpResponse(template.render(params, request))
    except Exception as e:
        return HttpResponse("Not found: {}".format(e))
    return HttpResponse("x Not implemented yet")
