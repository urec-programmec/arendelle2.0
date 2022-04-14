import os
import json

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
        newMap = Map(name=data['mapName'],
                     map=data['map'],
                     sizeX=data['sizeX'],
                     sizeY=data['sizeY'],
                     task_cell_count=data['taskCellCount'],
                     author=data['author'])
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
                'taskCellCount': map.task_cell_count,
                'author': user.name + ' ' + user.surname,
                'authorId': user.id,
                'datetime': map.datetime_created.strftime('%d.%m.%Y'),
            })
        return jsonify(response_object)


@app.route('/allInstitutionsText', methods=['GET'])
def allInstitutionsText():
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
        password = md5((data['password']).encode('cp1252')).hexdigest()
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


@app.route('/deleteTask', methods=['POST'])
def deleteTask():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        task = db.session.query(TaskContent).filter_by(id=data['id']).first()
        db.session.delete(task)
        db.session.commit()
        return jsonify(response_object)


@app.route('/renameTask', methods=['POST'])
def renameTask():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        task = db.session.query(TaskContent).filter_by(id=data['id']).first()
        task.name = data['newName']
        db.session.commit()
        return jsonify(response_object)


@app.route('/saveTask', methods=['POST'])
def saveTask():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        content = data['content'].encode('ascii')
        answer = data['answer']
        complexity = data['complexity']
        type_of_response = data['typeOfResponse']
        created_by = data['createdBy']
        name = data['name']

        newTask = TaskContent(content=content, answer=answer, complexity=complexity, type_of_response=type_of_response, created_by=created_by, name=name)
        db.session.add(newTask)
        db.session.commit()

        return jsonify(response_object)


@app.route('/allTasks', methods=['GET'])
def allTasks():
    response_object = {'status': 'success'}
    if request.method == 'GET':
        response_object['tasks'] = []
        for task in sorted(db.session.query(TaskContent).all(), key=lambda m: m.datetime_created, reverse=True):
            user = db.session.query(Users).filter_by(id=task.created_by).first()
            response_object['tasks'].append({
                'id': task.id,
                'name': task.name,
                'content': task.content.decode('ascii'),
                'answer': json.loads(task.answer),
                'complexity': task.complexity,
                'typeOfResponse': task.type_of_response,
                'author': user.name + ' ' + user.surname,
                'authorId': user.id,
                'datetime': task.datetime_created.strftime('%d.%m.%Y'),
            })
        return jsonify(response_object)


@app.route('/allTeamsText', methods=['GET'])
def allTeamsText():
    response_object = {'status': 'success'}
    if request.method == 'GET':
        response_object['teams'] = []
        for team in sorted(db.session.query(Team).all(), key=lambda m: m.name):
            # user = db.session.query(Users).filter_by(id=team.created_by).first()
            response_object['teams'].append({
                'value': team.id,
                'text': team.name,

                # 'id': team.id,
                # 'name': team.name,
                # 'institutionId': team.institution,
                # 'author': user.name + ' ' + user.surname,
                # 'authorId': user.id,
            })
        return jsonify(response_object)


if __name__ == '__main__':
    app.run(port=5050)


