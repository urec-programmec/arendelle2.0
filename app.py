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


@app.route('/checkState', methods=['GET'])
def checkState():
    response_object = {'status': 'success'}
    if request.method == 'GET':
        utc = pytz.UTC
        for ch in db.session.query(Championship).all():
            if ch.championship_status == 1 and ch.datetime_start.replace(tzinfo=utc) < datetime.now().replace(tzinfo=utc):
                ch.championship_status = 2

            delta = timedelta(milliseconds=ch.time_long)
            if ch.championship_status == 2 and (ch.datetime_start + delta).replace(tzinfo=utc) < datetime.now().replace(tzinfo=utc):
                ch.championship_status = 3

        db.session.commit()
        return jsonify(response_object)


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
        try:
            task = db.session.query(TaskContent).filter_by(id=data['id']).first()
            for taskTag in db.session.query(TaskTags).all():
                if taskTag.task == task.id:
                    db.session.delete(taskTag)
            db.session.flush()

            db.session.delete(task)
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            raise e
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


@app.route('/saveTag', methods=['POST'])
def saveTag():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        tag = data['tag']
        newTag = Tags(name=tag)
        db.session.add(newTag)
        db.session.commit()

        return jsonify(response_object)


@app.route('/allTags', methods=['GET'])
def allTags():
    response_object = {'status': 'success'}
    if request.method == 'GET':
        response_object['tags'] = []
        for tag in sorted(db.session.query(Tags).all(), key=lambda m: m.name):
            response_object['tags'].append({
                'value': tag.id,
                'text': tag.name,
            })

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
        tags = [i['value'] for i in json.loads(data['tags'])]

        newTask = TaskContent(content=content, answer=answer, complexity=complexity, type_of_response=type_of_response, created_by=created_by, name=name)
        db.session.add(newTask)
        db.session.flush()

        for tag in tags:
            newTag = TaskTags(task=newTask.id, tag=tag)
            db.session.add(newTag)

        db.session.commit()

        return jsonify(response_object)


@app.route('/allTasks', methods=['GET'])
def allTasks():
    response_object = {'status': 'success'}
    if request.method == 'GET':
        response_object['tasks'] = []
        for task in sorted(db.session.query(TaskContent).all(), key=lambda m: m.datetime_created, reverse=True):
            user = db.session.query(Users).filter_by(id=task.created_by).first()
            tags = [db.session.query(Tags).filter_by(id=i.tag).first().name for i in db.session.query(TaskTags).filter_by(task=task.id).all()]
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
                'tags': tags,
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



@app.route('/saveChampionship', methods=['POST'])
def saveChampionship():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()

        id = data['id']
        name = data['name']
        stage = data['stage']
        date = data['date']
        time = data['time']
        level = data['level']
        institutions = data['institutions']
        teams = data['teams']
        tasks = data['tasks']
        task_count = data['taskCount']
        task_cell_count = data['taskCellCount']
        map_content = data['map']
        map_id = data['mapId']
        created_by = data['author']

        championship = db.session.query(Championship).filter_by(id=id).first()
        if championship != None:
            color = championship.color
            deleteChampionshipMethod(id)
        else:
            color = 'hsla(' + str(random() * 100 + 170) + ', 50%, 50%, 1)' if random() < 0.9 else 'hsla(' + str(
                random() * 30) + ', 50%, 50%, 1)'

        try:
            # 0. championship
            championship = Championship(name=name,
                                        stage=stage,
                                        level=level,
                                        color=color,
                                        max_team_count=100,
                                        max_institution_team_count=100,
                                        datetime_start=date,
                                        time_long=time,
                                        created_by=created_by,
                                        championship_status=1)
            db.session.add(championship)
            db.session.flush()

            # 1. new map
            newMap = MapPlatform(map=map_id,
                                 map_content=map_content,
                                 task_count=task_count,
                                 task_cell_count=task_cell_count)
            db.session.add(newMap)
            db.session.flush()

            # 2. all teams from team and institutions
            allTeams = []
            for team in db.session.query(Team).all():
                if team.id in teams or team.institution in institutions:
                    allTeams.append(team)

            # 3. platforms
            for team in allTeams:
                # 3.1 platform
                color = 'hsla(' + str(random() * 100 + 170) + ', 50%, 50%, 1)' if random() < 0.9 else 'hsla(' + str(random() * 30) + ', 50%, 50%, 1)'
                platform = Platform(color=color,
                                    map=newMap.id,
                                    created_by=created_by,
                                    platform_status=2)
                db.session.add(platform)
                db.session.flush()

                # 3.2 tasks
                for taskId in tasks:
                    task = Task(platform=platform.id,
                                task_type=1,
                                task_content=taskId,
                                task_status=1,
                                count_solved=0,
                                created_by=created_by)
                    db.session.add(task)
                    db.session.flush()

                # 3.3 team to championship on platform
                tcp = TeamChampionshipPlatform(team=team.id, championship=championship.id, platform=platform.id)
                db.session.add(tcp)
                db.session.flush()

            for institution in institutions:
                ci = ChampionshipInstitution(championship=championship.id, institution=institution)
                db.session.add(ci)

            db.session.commit()
        except Exception as e:
            db.session.rollback()
            raise e

        return jsonify(response_object)


@app.route('/deleteChampionship', methods=['POST'])
def deleteChampionship():
    response_object = {'status': 'success'}
    if request.method == 'POST':
        data = request.get_json()
        deleteChampionshipMethod(data['id'])
        return jsonify(response_object)


def deleteChampionshipMethod(id):
    try:
        # 0. championship
        championship = db.session.query(Championship).filter_by(id=id).first()
        allTeamPlatforms = db.session.query(TeamChampionshipPlatform).filter_by(championship=id).all()
        allInstitutions = db.session.query(ChampionshipInstitution).filter_by(championship=id).all()

        platformIds = [i.platform for i in allTeamPlatforms]
        allTasks = [i for i in db.session.query(Task).all() if i.platform in platformIds]
        allPlatform = [i for i in db.session.query(Platform).all() if i.id in platformIds]
        mapPlatform = db.session.query(MapPlatform).filter_by(id=allPlatform[0].map).first()

        for i in allTeamPlatforms:
            db.session.delete(i)
        db.session.flush()

        for i in allTasks:
            db.session.delete(i)
        db.session.flush()

        for i in allPlatform:
            db.session.delete(i)
        db.session.flush()

        db.session.delete(mapPlatform)
        db.session.flush()

        for i in allInstitutions:
            db.session.delete(i)
        db.session.flush()

        db.session.delete(championship)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        raise e


@app.route('/allChampionships', methods=['GET'])
def allChampionships():
    response_object = {'status': 'success'}
    if request.method == 'GET':
        response_object['championships'] = []
        for ch in db.session.query(Championship).all():
            allTeamPlatforms = db.session.query(TeamChampionshipPlatform).filter_by(championship=ch.id).all()
            platform = db.session.query(Platform).filter_by(id=allTeamPlatforms[0].platform).first()
            mapPlatform = db.session.query(MapPlatform).filter_by(id=platform.map).first()
            allTeamIds = [i.team for i in allTeamPlatforms]
            allInstitutionIds = [i.institution for i in db.session.query(ChampionshipInstitution).filter_by(championship=ch.id).all()]
            allTeams = [i for i in db.session.query(Team).all() if i.id in allTeamIds and not (i.institution in allInstitutionIds)]
            allInstitutions = [i for i in db.session.query(Institution).all() if i.id in allInstitutionIds]
            mapTemp = db.session.query(Map).filter_by(id=mapPlatform.map).first()
            mapCreator = db.session.query(Users).filter_by(id=mapTemp.author).first()
            mapJSON = {
                'id': mapTemp.id,
                'name': mapTemp.name,
                'map': mapTemp.map,
                'sizeX': mapTemp.sizeX,
                'sizeY': mapTemp.sizeY,
                'taskCellCount': mapTemp.task_cell_count,
                'author': mapCreator.name + ' ' + mapCreator.surname,
                'authorId': mapCreator.id,
                'datetime': mapTemp.datetime_created.strftime('%d.%m.%Y'),
            }
            allTasks = []
            for taskId in [i.task_content for i in db.session.query(Task).filter_by(platform=platform.id).all()]:
                task = db.session.query(TaskContent).filter_by(id=taskId).first()
                taskCreator = db.session.query(Users).filter_by(id=task.created_by).first()
                allTasks.append({
                    'id': task.id,
                    'name': task.name,
                    'content': task.content.decode('ascii'),
                    'answer': json.loads(task.answer),
                    'complexity': task.complexity,
                    'typeOfResponse': task.type_of_response,
                    'author': taskCreator.name + ' ' + taskCreator.surname,
                    'authorId': taskCreator.id,
                    'datetime': task.datetime_created.strftime('%d.%m.%Y'),
                })

            user = db.session.query(Users).filter_by(id=ch.created_by).first()
            response_object['championships'].append({
                'id': ch.id,
                'name': ch.name,
                'stage': ch.stage,
                'level': ch.level,
                'color': ch.color,
                'date': ch.datetime_start,
                'time': ch.time_long,
                'status': ch.championship_status,

                'taskCount': mapPlatform.task_count,
                'taskCellCount': mapPlatform.task_cell_count,
                'teams': [{'text': i.name, 'value': i.id} for i in allTeams],
                'institutions': [{'text': i.name, 'value': i.id} for i in allInstitutions],
                'map': mapJSON,
                'tasks': allTasks,

                'author': user.name + ' ' + user.surname,
                'authorId': user.id,
            })
        return jsonify(response_object)


@app.route('/getResults', methods=['POST'])
def getResults():
    global sorted
    response_object = {'status': 'success'}
    if request.method == 'POST':
        response_object['rows'] = []
        response_object['tasks'] = []
        id = request.get_json()['championship']
        for teamsCh in db.session.query(TeamChampionshipPlatform).filter_by(championship=id).all():
            team = db.session.query(Team).filter_by(id=teamsCh.team).first()
            institution = db.session.query(Institution).filter_by(id=team.institution).first()
            tasksPlatform = db.session.query(Task).filter_by(platform=teamsCh.platform).all()
            tasks = [db.session.query(TaskContent).filter_by(id=i.task_content).first() for i in tasksPlatform]

            tasks, tasksPlatform = zip(*sorted(zip(tasks, tasksPlatform), key=lambda m: m[0].complexity))

            letter = ord('A')

            if not response_object['tasks']:
                for task in tasks:
                    response_object['tasks'].append({
                        'id': task.id,
                        'name': task.name,
                        'letter': chr(letter),
                        'content': task.content.decode('ascii'),
                    })
                    letter += 1

            tasksTeam = []
            solves = 0
            for task in tasksPlatform:
                if task.count_solved == 0:
                    tasksTeam.append({'status': '', 'ok': False})
                elif task.task_status != 3:
                    tasksTeam.append({'status': '–' + str(task.count_solved), 'ok': False})
                elif task.task_status == 3 and task.count_solved == 1:
                    solves += 1
                    tasksTeam.append({'status': '+', 'ok': True})
                elif task.task_status == 3:
                    solves += 1
                    tasksTeam.append({'status': '+' + str(task.count_solved), 'ok': True})
                else:
                    tasksTeam.append({'status': '', 'ok': False})

            response_object['rows'].append({
                'teamName': team.name,
                'institution': institution.short_name,
                'solves': solves,
                'tasks': tasksTeam
            })
        return jsonify(response_object)


if __name__ == '__main__':
    app.run(port=5050)


