from django.contrib import admin

# Register your models here.

from .models import Author, Gender, Token, Desig, Lang, ScopeType, Scope, Utter, Pronounce, Survey, Freq, Idea, Meaning, Onto

admin.site.register(Author)
admin.site.register(Gender)
admin.site.register(Token)
admin.site.register(Desig)
admin.site.register(Lang)
admin.site.register(ScopeType)
admin.site.register(Scope)
admin.site.register(Utter)
admin.site.register(Pronounce)
admin.site.register(Survey)
admin.site.register(Freq)
admin.site.register(Idea)
admin.site.register(Meaning)
admin.site.register(Onto)
