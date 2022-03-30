import os
import uuid

from flask import Flask, render_template, request, redirect, session, url_for, flash, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

from hashlib import md5

from db.db import *

app = Flask(__name__, static_url_path='')
SECRET_KEY = os.urandom(32)
app.config['SECRET_KEY'] = SECRET_KEY
app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
CORS(app)


@app.route('/deleteMap', methods=['POST'])
def deleteMap():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        map = db.session.query(Map).filter_by(id=data['id']).first()
        db.session.delete(map)
        db.session.commit()
        return jsonify(response_object)


@app.route('/renameMap', methods=['POST'])
def renameMap():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        map = db.session.query(Map).filter_by(id=data['id']).first()
        map.name = data['newName']
        db.session.commit()
        return jsonify(response_object)


@app.route('/saveMap', methods=['POST'])
def saveMap():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        newMap = Map(name=data['mapName'], map=data['map'], sizeX=data['sizeX'], sizeY=data['sizeY'], author=data['author'])
        db.session.add(newMap)
        db.session.commit()
        return jsonify(response_object)


@app.route('/allMaps', methods=['GET'])
def allMaps():
    response_object = {'status': 'success'}
    if request.method == 'GET':
        response_object['maps'] = []
        for map in sorted(db.session.query(Map).all(), key=lambda m: m.datetime_created, reverse=True):
            user = db.session.query(Users).filter_by(id=map.author).first()
            response_object['maps'].append({
                'id': map.id,
                'name': map.name,
                'map': map.map,
                'sizeX': map.sizeX,
                'sizeY': map.sizeY,
                'author': user.name + ' ' + user.surname,
                'authorId': user.id,
                'datetime': map.datetime_created.strftime('%d.%m.%Y'),
            })
        return jsonify(response_object)


@app.route('/allInstitutions', methods=['GET'])
def allInstitutions():
    response_object = {'status': 'success'}
    if request.method == 'GET':
        response_object['institutions'] = []
        for institution in db.session.query(Institution).all():
            response_object['institutions'].append({
                'value': institution.id,
                'text': institution.name,
            })
        return jsonify(response_object)


@app.route('/checkEmail', methods=['POST'])
def checkEmail():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        email = request.get_json()['email']
        emails = db.session.query(Users).filter_by(email=email).all()
        response_object['isValid'] = len(emails) == 0
        return jsonify(response_object)


@app.route('/checkNickname', methods=['POST'])
def checkNickname():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        nickname = request.get_json()['nickname']
        nicknames = db.session.query(Users).filter_by(nickname=nickname).all()
        response_object['isValid'] = len(nicknames) == 0
        return jsonify(response_object)


@app.route('/checkSignUp', methods=['POST'])
def checkSignUp():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        email = request.get_json()['email']
        password = md5((request.get_json()['password']).encode('cp1252')).hexdigest()
        users = db.session.query(Users).filter_by(email=email, password=password).all()
        response_object['isValid'] = len(users) == 1
        response_object['user'] = {
         'id': users[0].id,
         'email': users[0].email,
         'color': users[0].color,
         'nickname': users[0].nickname,
         'name': users[0].name,
         'surname': users[0].surname,
         'role': users[0].user_role,
         # 'user_role': db.session.query(UserRole).filter_by(id=users[0].user_role).first().name,
         'institution': users[0].institution,
         'team': users[0].team,
        } if len(users) == 1 else {}
        return jsonify(response_object)


@app.route('/saveUser', methods=['POST'])
def saveUser():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        email = data['email']
        nickname = data['nickname']
        name = data['name']
        surname = data['surname']
        institutionId = data['institutionId']
        password = md5((request.get_json()['password']).encode('cp1252')).hexdigest()
        color = data['color']
        role = data['role']

        newUser = Users(email=email, nickname=nickname, name=name, surname=surname, institution=institutionId, password=password, color=color, user_role=role)
        db.session.add(newUser)
        db.session.commit()
        response_object['user'] = {
            'id': newUser.id,
            'email': newUser.email,
            'color': newUser.color,
            'nickname': newUser.nickname,
            'name': newUser.name,
            'surname': newUser.surname,
            'role': newUser.user_role,
            # 'user_role': db.session.query(UserRole).filter_by(id=newUser.user_role).first().name,
            'institution': newUser.institution,
            'team': newUser.team,
        }

        return jsonify(response_object)










BOOKS = [
    {
        'id': uuid.uuid4().hex,
        'title': 'On the Road',
        'author': 'Jack Kerouac',
        'read': True
    },
    {
        'id': uuid.uuid4().hex,
        'title': 'Harry Potter and the Philosopher\'s Stone',
        'author': 'J. K. Rowling',
        'read': False
    },
    {
        'id': uuid.uuid4().hex,
        'title': 'Green Eggs and Ham',
        'author': 'Dr. Seuss',
        'read': True
    }
]

@app.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify('pong!')

@app.route('/books', methods=['GET', 'POST'])
def all_books():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        post_data = request.get_json()
        BOOKS.append({
            'id': uuid.uuid4().hex,
            'title': post_data.get('title'),
            'author': post_data.get('author'),
            'read': post_data.get('read')
        })
        response_object['message'] = 'Book added!'
    else:
        response_object['books'] = BOOKS
    return jsonify(response_object)


@app.route('/books/<string:book_id>', methods=['PUT', 'DELETE'])
def single_book(book_id):
    response_object = {'status': 'success'}
    if request.method == 'PUT':
        post_data = request.get_json()
        remove_book(book_id)
        BOOKS.append({
            'id': uuid.uuid4().hex,
            'title': post_data.get('title'),
            'author': post_data.get('author'),
            'read': post_data.get('read')
        })
        response_object['message'] = 'Book updated!'
    if request.method == 'DELETE':
            remove_book(book_id)
            response_object['message'] = 'Book removed!'
    return jsonify(response_object)


def remove_book(book_id):
    for book in BOOKS:
        if book['id'] == book_id:
            BOOKS.remove(book)
            return True
    return False

if __name__ == '__main__':
    app.run(port=5050)


