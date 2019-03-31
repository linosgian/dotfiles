import urllib.request
import json
import string

r = urllib.request.urlopen("https://now-dot-playing-dot-radiojarcom.appspot.com/api/stations/pepper/now_playing/")
r = json.loads(r.read().decode("utf-8"))
if r["artist"] and r["title"]:
    output = string.capwords("{0} - {1}".format(r["artist"], r["title"]))
    # Fix Daydreaming (frank Sinatra) case
    try:
        i = output.index('(')
        output = list(output)
        output[i+1] = output[i+1].upper()
        output = "".join(output)
        output = (output[:40] + '...') if len(output) > 40 else output
    except ValueError:
        pass
    print("%{{T5}}{0}%{{T-}}".format(output))
