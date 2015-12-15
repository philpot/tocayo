from django.db import models

# Create your models here.

class Author(models.Model):
    name = models.CharField(max_length=127, unique=True)
    def __str__(self):
        return self.name

class Gender(models.Model):
    name = models.CharField(max_length=3, unique=True)
    description = models.CharField(max_length=15)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return self.description

class Token(models.Model):
    name = models.CharField(max_length=31, unique=True)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return self.name

class Desig(models.Model):
    token = models.ForeignKey(Token, null=True, on_delete=models.SET_NULL)
    gender = models.ForeignKey(Gender, null=True, on_delete=models.SET_NULL)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    uid = models.IntegerField(default=1)
    def __str__(self):
        return str(self.token) + " (" + str(self.gender) + ")"

class Lang(models.Model):
    name = models.CharField(max_length=47, unique=True)
    short = models.CharField(max_length=2, unique=True)
    long = models.CharField(max_length=3, unique=True)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return self.long

class ScopeType(models.Model):
    name = models.CharField(max_length=31, unique=True)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return self.name

class Scope(models.Model):
    desig = models.ForeignKey(Desig, null=True, on_delete=models.SET_NULL)
    scopeType = models.ForeignKey(ScopeType, null=True, on_delete=models.SET_NULL)
    lang = models.ForeignKey(Lang, null=True, on_delete=models.SET_NULL)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return str(self.desig) + ": " + str(self.scopeType) + "=" + str(self.lang)

class Utter(models.Model):
    name = models.CharField(max_length=47, unique=True)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return self.name

class Pronounce(models.Model):
    desig = models.ForeignKey(Desig, null=True, on_delete=models.SET_NULL)
    utter = models.ForeignKey(Utter, null=True, on_delete=models.SET_NULL)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return str(self.desig) + str(self.utter)

class Survey(models.Model):
    name = models.CharField(max_length=47)
    year = models.IntegerField(default=0)
    gender = models.ForeignKey(Gender, null=True, on_delete=models.SET_NULL)
    basis = models.IntegerField(default=0)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return self.name

class Freq(models.Model):
    desig = models.ForeignKey(Desig, null=True, on_delete=models.SET_NULL)
    survey = models.ForeignKey(Survey, null=True, on_delete=models.SET_NULL)
    count = models.IntegerField(default=0)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return str(self.desig) + " " + str(self.survey) + " " + str(self.count)

class Idea(models.Model):
    name = models.CharField(max_length=47, unique=True)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return self.name

class Meaning(models.Model):
    desig = models.ForeignKey(Desig, null=True, on_delete=models.SET_NULL)
    idea = models.ForeignKey(Idea, null=True, on_delete=models.SET_NULL)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return str(self.desig) + " " + str(self.idea)

class Onto(models.Model):
    child = models.ForeignKey(Idea, null=True, on_delete=models.SET_NULL, related_name='onto_child_set')
    parent = models.ForeignKey(Idea, null=True, on_delete=models.SET_NULL, related_name='onto_parent_set')
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return str(self.child) + "<<--" + str(self.parent)

class RelType(models.Model):
    name = models.CharField(max_length=31, unique=True)
    author = models.ForeignKey(Author, null=True, on_delete=models.SET_NULL)
    def __str__(self):
        return self.name

class Rel(models.Model):
    relType = models.ForeignKey(RelType, null=True, on_delete=models.SET_NULL)    
    core = models.ForeignKey(Desig, null=True, on_delete=models.SET_NULL, related_name='related_core_set')
    satellite = models.ForeignKey(Desig, null=True, on_delete=models.SET_NULL, related_name='related_satellite_set')
    def __str__(self):
        return "{}({}, {})".format(self.relType, self.core, self.satellite)
