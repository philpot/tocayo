from .models import Author, Desig, Freq, Gender, Idea, Lang, Meaning, Onto, Pronounce, Scope, ScopeType, Survey, Token, Utter

from django.db import connections
from django.core.exceptions import ObjectDoesNotExist
from django.db.utils import ConnectionDoesNotExist    
from tocayoapp import models

def setup_cursor():
    try:
        cursor = connections['bebe'].cursor()
        return cursor
    except ConnectionDoesNotExist:
        print("Bebe database is not configured")
        return None

def import_author():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, author FROM author"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        author = Author.objects.get_or_create(id=row[0], author=row[1])
    for author in Author.objects.all():
        author.save()

def import_gender():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, name, author FROM gender"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[2])
            continue
        else:
            gender = Gender.objects.get_or_create(id=row[0], name=row[1], author=author)
    for gender in Gender.objects.all():
        gender.save()

def import_scopeType():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, name, author FROM scopetype"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[2])
            continue
        else:
            scopeType = ScopeType.objects.get_or_create(id=row[0], name=row[1], author=author)
    for scopeType in ScopeType.objects.all():
        scopeType.save()

def import_lang():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, name, short, `long`, author FROM lang"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[4])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[4])
            continue
        else:
            lang = Lang.objects.get_or_create(id=row[0], name=row[1], short=row[2], long=row[3], author=author)
    for lang in Lang.objects.all():
        lang.save()

def import_utter():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, utter, author FROM utter"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[2])
            continue
        else:
            utter = Utter.objects.get_or_create(id=row[0], utter=row[1], author=author)
    for utter in Utter.objects.all():
        utter.save()

def import_token():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, token, author FROM token"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[2])
            continue
        else:
            token = Token.objects.get_or_create(id=row[0], token=row[1], author=author)
    for token in Token.objects.all():
        token.save()

def import_desig():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, tid, gender, uid, author from desig"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[4])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[4])
            continue
        try:
            token = Token.objects.get(id=row[1])
        except ObjectDoesNotExist:
            print("Token not found with id %s" % row[1])
            continue
        try:
            gender = Gender.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("Gender not found with id %s" % row[2])
            continue
        else:
            desig = Desig.objects.get_or_create(id=row[0], token=token, gender=gender, uid=row[3], author=author)
    for desig in Desig.objects.all():
        desig.save()

def import_scope():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, did, stid, lang, author from scope"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[4])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[4])
            continue
        try:
            scopeType = ScopeType.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("ScopeType not found with id %s" % row[2])
            continue
        try:
            desig = Desig.objects.get(id=row[1])
        except ObjectDoesNotExist:
            print("Desig not found with id %s" % row[1])
            continue
        try:
            lang = Lang.objects.get(id=row[3])
        except ObjectDoesNotExist:
            print("Lang not found with id %s" % row[3])
            continue
        else:
            scope = Scope.objects.get_or_create(id=row[0], desig=desig, scopeType=scopeType, lang=lang, author=author)
    for scope in Scope.objects.all():
        scope.save()

def import_pronounce():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, did, utter, author from pronounce"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[3])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[3])
            continue
        try:
            desig = Desig.objects.get(id=row[1])
        except ObjectDoesNotExist:
            print("Desig not found with id %s" % row[1])
            continue
        try:
            utter = Utter.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("Utter not found with id %s" % row[2])
            continue
        else:
            pronounce = Pronounce.objects.get_or_create(id=row[0], desig=desig, utter=utter, author=author)
    for pronounce in Pronounce.objects.all():
        pronounce.save()

def import_idea():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, idea, author FROM idea"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[2])
            continue
        else:
            idea = Idea.objects.get_or_create(id=row[0], idea=row[1], author=author)
    for idea in Idea.objects.all():
        idea.save()

def import_onto():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, child, parent, author FROM onto"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[3])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[3])
            continue
        try:
            child = Idea.objects.get(id=row[1])
        except ObjectDoesNotExist:
            print("Child idea not found with id %s" % row[1])
            continue
        try:
            parent = Idea.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("Parent idea not found with id %s" % row[2])
            continue
        else:
            onto = Onto.objects.get_or_create(id=row[0], child=child, parent=parent, author=author)
    for onto in Onto.objects.all():
        onto.save()

def import_meaning():
    cursor = setup_cursor()
    if cursor is None:
        return
    sql = """SELECT id, did, idea, author FROM meaning"""
    cursor.execute(sql)
    for row in cursor.fetchall():
        try:
            author = Author.objects.get(id=row[3])
        except ObjectDoesNotExist:
            print("Author not found with id %s" % row[3])
            continue
        try:
            desig = Desig.objects.get(id=row[1])
        except ObjectDoesNotExist:
            print("Desig not found with id %s" % row[1])
            continue
        try:
            idea = Idea.objects.get(id=row[2])
        except ObjectDoesNotExist:
            print("Idea not found with id %s" % row[2])
            continue
        else:
            meaning = Meaning.objects.get_or_create(id=row[0], desig=desig, idea=idea, author=author)
    for meaning in Meaning.objects.all():
        meaning.save()

def main():
    import_author()
    import_gender()
    import_lang()
    import_scopeType()
    import_utter()
    import_token()
    import_desig()
    import_scope()
    import_pronounce()
    import_idea()
    import_onto()
    import_meaning()

# if __name__=="__main__":
#     main()

main()
