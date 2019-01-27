import urllib.request
import json
import string

r = urllib.request.urlopen("https://now-dot-playing-dot-radiojarcom.appspot.com/api/stations/pepper/now_playing/")
r = json.loads(r.read().decode("utf-8"))
if r["artist"] and r["title"]:
    output = string.capwords("{0} - {1}".format(r["artist"], r["title"]))
    print("%{{T5}}{0}%{{T-}}".format(output))
