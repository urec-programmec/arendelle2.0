import os
import json
from random import random
from hashlib import md5
from datetime import datetime, timedelta
import pytz

from flask import Flask, render_template, request, redirect, session, url_for, flash, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

from db.db import *

app = Flask(__name__, static_url_path='')
SECRET_KEY = os.urandom(32)
app.config['SECRET_KEY'] = SECRET_KEY
app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
CORS(app)

@app.route('/getDndMap', methods=['GET'])
def getDndMap():
    response_object = {'status': 'success'}
    if request.method == 'GET':
        dnd = db.session.query(Dnd).filter_by(id=1).first()
        response_object['data'] = {
                'rooms': dnd.rooms,
                'lines': dnd.lines,
                'items': dnd.items,
            }
        return jsonify(response_object)


@app.route('/saveDndMap', methods=['GET', 'POST'])
def saveDndMap():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        dnd = db.session.query(Dnd).filter_by(id=1).first()
        if dnd != None:
            dnd.rooms=data['rooms']
            dnd.lines=data['lines']
            dnd.items=data['items']
        else:
            newDnd = Dnd(rooms=data['rooms'],
                     lines=data['lines'],
                     items=data['items'])
            db.session.add(newDnd)
        db.session.commit()
        return jsonify(response_object)

if __name__ == '__main__':
    app.run(port=5050)


