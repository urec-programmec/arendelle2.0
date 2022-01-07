import datetime
import random
import pytz

from sqlalchemy import *
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from hashlib import md5

engine = create_engine("postgresql+psycopg2://postgres:admin@localhost/oop-db")
Session = sessionmaker(bind=engine)
session = Session()
Base = declarative_base()
ist = pytz.timezone('UTC')

class Championship(Base):
    __tablename__ = 'championship'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), nullable=False)
    stage = Column(String(100), nullable=False)
    max_team_count = Column(Integer, nullable=True)
    max_institution_team_count = Column(Integer, nullable=True)
    datetime_start = Column(DATETIME, nullable=False)
    datetime_end = Column(DATETIME, nullable=False)
    created_by = Column(BigInteger, ForeignKey('users.id'))
    championship_status = Column(BigInteger, ForeignKey('championship_status.id'))


class ChampionshipStatus(Base):
    __tablename__ = 'championship_status'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class ChampionshipInstitution(Base):
    __tablename__ = 'championship_institution'
    championship = Column(BigInteger, ForeignKey('championship.id'), primary_key=True)
    institution = Column(BigInteger, ForeignKey('institution.id'), primary_key=True)


class Institution(Base):
    __tablename__ = 'institution'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(200), nullable=False)
    sity = Column(BigInteger, ForeignKey('sity.id'))
    institution_status = Column(BigInteger, ForeignKey('institution_status.id'))
    institution_type = Column(BigInteger, ForeignKey('institution_type.id'))
    created_by = Column(BigInteger, ForeignKey('users.id'))


class InstitutionStatus(Base):
    __tablename__ = 'institution_status'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class InstitutionType(Base):
    __tablename__ = 'institution_type'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class Map(Base):
    __tablename__ = 'map'
    id = Column(BigInteger, primary_key=True)
    graph = Column(LargeBinary(length=(2**24)-1), nullable=False)
    picture = Column(LargeBinary(length=(2**24)-1), nullable=False)


class Notification(Base):
    __tablename__ = 'notification'
    id = Column(BigInteger, primary_key=True)
    message = Column(String(256), nullable=True)
    notification_type = Column(BigInteger, ForeignKey('notification_type.id'))
    notification_status = Column(BigInteger, ForeignKey('notification_status.id'))
    from_ = Column(BigInteger, ForeignKey('users.id'), name='from')
    to_ = Column(BigInteger, ForeignKey('users.id'), name='to')
    institution = Column(BigInteger, ForeignKey('institution.id'), nullable=True)
    team = Column(BigInteger, ForeignKey('team.id'), nullable=True)


class NotificationStatus(Base):
    __tablename__ = 'notification_status'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class NotificationType(Base):
    __tablename__ = 'notification_type'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class Platform(Base):
    __tablename__ = 'platform'
    id = Column(BigInteger, primary_key=True)
    color = Column(String(30), nullable=False)
    task_count = Column(Integer, nullable=False)
    additional_task_count = Column(Integer, nullable=False)
    map = Column(BigInteger, ForeignKey('map.id'))
    created_by = Column(BigInteger, ForeignKey('users.id'))
    platform_status = Column(BigInteger, ForeignKey('platform_status.id'))


class PlatformStatus(Base):
    __tablename__ = 'platform_status'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class Sity(Base):
    __tablename__ = 'sity'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)
    queries_count = Column(BigInteger, primary_key=False)


class Task(Base):
    __tablename__ = 'task'
    id = Column(BigInteger, primary_key=True)
    time_for_answer = Column(Integer, nullable=True)
    time_found = Column(DATETIME, nullable=True)
    time_solved = Column(DATETIME, nullable=True)
    platform = Column(BigInteger, ForeignKey('platform.id'))
    task_type = Column(BigInteger, ForeignKey('task_type.id'))
    task_content = Column(BigInteger, ForeignKey('task_content.id'))
    task_status = Column(BigInteger, ForeignKey('task_status.id'))
    find_by = Column(BigInteger, ForeignKey('users.id'))
    created_by = Column(BigInteger, ForeignKey('users.id'))


class TaskContent(Base):
    __tablename__ = 'task_content'
    id = Column(BigInteger, primary_key=True)
    content = Column(LargeBinary(length=(2**24)-1), nullable=False)
    answer = Column(String(500), nullable=False)
    type_of_response = Column(BigInteger, ForeignKey('type_of_response.id'))
    created_by = Column(BigInteger, ForeignKey('users.id'))


class TypeOfResponse(Base):
    __tablename__ = 'type_of_response'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class TaskStatus(Base):
    __tablename__ = 'task_status'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class TaskType(Base):
    __tablename__ = 'task_type'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class Team(Base):
    __tablename__ = 'team'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), nullable=False)
    team_status = Column(BigInteger, ForeignKey('team_status.id'))
    institution = Column(BigInteger, ForeignKey('institution.id'))
    created_by = Column(BigInteger, ForeignKey('users.id'))


class TeamStatus(Base):
    __tablename__ = 'team_status'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


class TeamTaskUser(Base):
    __tablename__ = 'team_task_user'
    team = Column(BigInteger, ForeignKey('team.id'), primary_key=True)
    task = Column(BigInteger, ForeignKey('task.id'), primary_key=True)
    user = Column(BigInteger, ForeignKey('users.id'), primary_key=True)


class TeamChampionshipPlatform(Base):
    __tablename__ = 'team_championship_platform'
    id = Column(BigInteger, primary_key=True)
    team = Column(BigInteger, ForeignKey('team.id'), primary_key=True)
    championship = Column(BigInteger, ForeignKey('championship.id'), primary_key=True)
    platform = Column(BigInteger, ForeignKey('platform.id'), primary_key=True)


class Users(Base):
    __tablename__ = 'users'
    id = Column(BigInteger, primary_key=True)
    color = Column(String(30), nullable=False)
    nickname = Column(String(50), nullable=False)
    name = Column(String(80), nullable=False)
    surname = Column(String(80), nullable=False)
    password = Column(String(32), nullable=False)
    avatar = Column(LargeBinary(length=(2**24)-1), nullable=True)
    user_role = Column(BigInteger, ForeignKey('user_role.id'))
    institution = Column(BigInteger, ForeignKey('institution.id'))
    team = Column(BigInteger, ForeignKey('team.id'), nullable=True)


class UserRole(Base):
    __tablename__ = 'user_role'
    id = Column(BigInteger, primary_key=True)
    name = Column(String(100), primary_key=False)


def main():
    solve(1)

    # inst = Institution(name='Nice place 1', sity=453, institution_status=1, institution_type=1, created_by=5)
    # session.add(inst)
    # session.commit()

    # for i in range(50):
    #     ttu = TeamTaskUser(team=16, task=random.randint(32, 36), user=random.randint(28, 31))
    #     session.add(ttu)
    #     session.commit()

    # for i in range(5, 9):
        # for j in range(1, 7):
        #     chi = ChampionshipInstitution(championship=i, institution=j)
        #     session.add(chi)

    # for j in range(10, 19):
    #     cht = ChampionshipTeam(championship=6, team=j)
    #     session.add(cht)
    #
    # session.commit()

    # for k in range(8):
    #     for i in range(5):
    #         task = Task(platform=k+1, task_type=1, task_content=random.randint(4, 103), task_status=1, created_by=5)
    #         session.add(task)
    # session.commit()

    # users = session.query(Users).all()
    # for i in range(len(users)):
    #     users[i].color = users[i].color + str(i)
    #
    # session.commit()

    # for i in range(100):
    #     with open('test.txt', 'rb') as file:
    #         admin_id = session.query(Users).filter_by(user_role=3).first().id
    #         content = TaskContent(content=file.read(), answer='answer', type_of_response=1, created_by=admin_id)
    #         session.add(content)
    #     with open('test.txt', 'w') as file:
    #         file.write(str(i))
    # session.commit()

    # noadmin1 = Users(color='color',
    #             nickname='user5n1',
    #             name='U',
    #             surname='5n1',
    #             password=md5(str('admin').encode('cp1252')).hexdigest(),
    #             institution=5,
    #             user_role=1)

def solve(max_cnt):
    try:
        solve_tasks(max_cnt, 20, 42, 43)
    except:
        print(":(")

    try:
        solve_tasks(max_cnt, 21, 44, 45)

    except:
        print(":(")

    try:
        solve_tasks(max_cnt, 23, 51, 55)
    except:
        print(":(")

def solve_tasks(max_try, team, user_min, user_max):
    if max_try <= 0:
        return
    try:
        for i in range(10):
            ttu = TeamTaskUser(team=team, task=random.randint(37, 51), user=random.randint(user_min, user_max))
            session.add(ttu)
            session.commit()
    except Exception:
        solve_tasks(max_try - 1, team, user_min, user_max)

if __name__ == '__main__':
    main()
