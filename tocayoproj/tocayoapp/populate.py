from .models import Author, Desig, Freq, Gender, Idea, Lang, Meaning, Onto, Pronounce, Scope, ScopeType, Survey, Token, Utter

# Author.objects.get_or_create(id=1001, author="metadata2008")
# Author.objects.get_or_create(id=1002, author="import-from-ubirr-nmb-10/08")
# Author.objects.get_or_create(id=1003, author="new-in-ssa/boc-freq-data-10/08")
# Author.objects.get_or_create(id=1004, author="impbabynames2008")
# Author.objects.get_or_create(id=1005, author="philpot2009")
# Author.objects.get_or_create(id=1006, author="nmb2008incorp")
# Author.objects.get_or_create(id=1007, author="ssabocf")
# Author.objects.get_or_create(id=1008, author="ssabocm")
# Author.objects.get_or_create(id=1009, author="bo.2")
# Author.objects.get_or_create(id=1010, author="AGP2008")
# Author.objects.get_or_create(id=1011, author="bjjmm")
# Author.objects.get_or_create(id=1012, author="nmbimport2008")
# Author.objects.get_or_create(id=1013, author="AGP2004")
# Author.objects.get_or_create(id=1014, author="AGPredo2008")
# Author.objects.get_or_create(id=1016, author="hyeetch20090121")
# ## NB There may have been an empty Author in the past with id=1015: dropped
# ## still referenced
# for o in Author.objects.all():
#     o.save()

# Lang.objects.get_or_create(id=100, name="Romance", short="RM", long="RMC", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=111, name="Latin", short="LA", long="LAT", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=121, name="Italian", short="IT", long="ITA", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=131, name="French", short="FR", long="FRE", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=141, name="Spanish", short="ES", long="SPA", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=151, name="Portuguese", short="PT", long="POR", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=200, name="Germanic", short="GC", long="GMC", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=211, name="German", short="DE", long="GER", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=220, name="English (all)", short="EA", long="ENA", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=229, name="English", short="EN", long="ENG", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=231, name="Dutch", short="NL", long="DUT", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=240, name="Scandinavian", short="S1", long="SCN", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=241, name="Swedish", short="SV", long="SVE", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=242, name="Norwegian", short="NO", long="NOR", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=243, name="Danish", short="DA", long="DAN", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=300, name="Gaelic (all)", short="GA", long="GAE", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=311, name="Irish Gaelic", short="G1", long="IRI", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=321, name="Scots Gaelic/Scottish", short="88", long="SCO", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=331, name="Welsh", short="CY", long="WEL", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=400, name="Slavic", short="S2", long="SLV", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=411, name="Polish", short="PL", long="POL", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=421, name="Russian", short="RU", long="RUS", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=500, name="Ancient Central Europe and Near East", short="NE", long="ANE", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=510, name="Hellenic", short="HL", long="HLN", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=511, name="Greek", short="EL", long="GRE", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=520, name="Semitic", short="SM", long="SEM", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=521, name="Arabic", short="AR", long="ARA", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=522, name="Hebrew", short="HE", long="HEB", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=530, name="Altaic", short="AT", long="ALT", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=531, name="Turkish", short="TR", long="TUR", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=540, name="Indo-European", short="IE", long="INE", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=541, name="Armenian", short="HY", long="ARM", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=542, name="Hindi", short="HI", long="HIN", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=543, name="Persian/Farsi", short="FA", long="PER", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=550, name="Finno-Ugric", short="FU", long="FNU", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=551, name="Hungarian", short="HU", long="HUN", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=600, name="Americas/Pacific Islands", short="AP", long="API", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=610, name="American Indian", short="A3", long="AMI", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=621, name="Hawaiian", short="H1", long="HAW", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=640, name="Philippines", short="PH", long="PHL", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=641, name="Tagalog", short="TG", long="TGL", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=642, name="Ilocano", short="IL", long="ILO", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=643, name="BIBAK", short="BK", long="BBK", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=644, name="Boholano", short="BH", long="BHL", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=645, name="Cebuano", short="CB", long="CBN", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=646, name="Visayan", short="VS", long="VSN", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=647, name="Pangasinan", short="PS", long="PSN", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=648, name="Waray", short="WR", long="WRY", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=649, name="Kapampangan", short="KP", long="KPN", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=650, name="Bicol", short="BC", long="BCL", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=651, name="Dalida", short="DL", long="DLD", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=652, name="Maguindanao", short="MG", long="MGO", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=653, name="Kiniray-A", short="KA", long="KRJ", author=Author.objects.get(author="philpot2009"))
# Lang.objects.get_or_create(id=700, name="African and African-influenced", short="A1", long="AAI", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=711, name="Swahili", short="SW", long="SWA", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=729, name="African American", short="A2", long="AFA", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=800, name="East Asian", short="AS", long="EAS", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=811, name="Cambodian", short="KM", long="KHM", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=821, name="Chinese", short="ZH", long="CHI", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=831, name="Japanese", short="JA", long="JPN", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=841, name="Vietnamese", short="VI", long="VIE", author=Author.objects.get(author="impbabynames2008"))
# Lang.objects.get_or_create(id=900, name="Unclassified/Unknown", short="UU", long="UUU", author=Author.objects.get(author="impbabynames2008"))
# for l in Lang.objects.all():
#     l.save()


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
