import requests
from time import sleep
from datetime import datetime

URL = 'http://localhost:5050/checkState'
location = 'Kostroma'
PARAMS = {'address': location}

while True:
    try:
        requests.get(url=URL, params=PARAMS)
        print('check ' + str(datetime.utcnow()))
        sleep(2)
    except Exception as e:
        print(e)
        sleep(10)

