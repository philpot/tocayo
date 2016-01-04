from collections import defaultdict
from tocayoapp.models import *
from djangoutil import *
import sys

def choose_core(l):
    def make_key(d):
        return ({"U": 0,
                 "M": 1,
                 "F": 2}[d.gender.name],
                len(d.token.name),
                d.token.name)
    s = sorted(l, key=lambda d: make_key(d))
    return s[0]

def find_possible_related(file=sys.stdout):
    d = defaultdict(list)
    for i in Idea.objects.all():
        for m in i.meaning_set.all():
            d[i].append(m.desig)
    for (k,v) in d.items():
        d[k] = sorted(list(set(v)))

    for (k,v) in d.items():
        core = choose_core(v[:])
        print("", file=file)
        print("# {}".format(core),
              file=file)
        print("# {}".format(k),
              file=file)
        print("core = {}".format(core.mini()),
              file=file)
        for x in v:
            print("maybeAddRelation('{}', core, {})".format("cognateOf", x.mini()),
                  file=file)
    return d

def find_possible_related_to_file(filename):
    with open(filename, 'w') as f:
        find_possible_related(file=f)


