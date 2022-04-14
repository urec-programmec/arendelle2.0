from sqlalchemy import Column, BigInteger, String, Integer, DATETIME, ForeignKey, LargeBinary, create_engine, JSON
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

SQLALCHEMY_DATABASE_URI = 'postgresql+psycopg2://postgres:admin@localhost/arendelle2.0'
engine = create_engine(SQLALCHEMY_DATABASE_URI)
Session = sessionmaker(bind=engine)
db = Session()
Base = declarative_base()

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
    name = Column(String(256), nullable=False)
    map = Column(JSON, nullable=False)
    sizeX = Column(Integer, nullable=False)
    sizeY = Column(Integer, nullable=False)
    task_cell_count = Column(Integer, nullable=False)
    author = Column(BigInteger, nullable=False)
    datetime_created = Column(DATETIME, nullable=False)


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
    name = Column(String(50), primary_key=False)
    answer = Column(JSON, nullable=False)
    complexity = Column(Integer, nullable=False)
    type_of_response = Column(BigInteger, ForeignKey('type_of_response.id'))
    created_by = Column(BigInteger, ForeignKey('users.id'))
    datetime_created = Column(DATETIME, nullable=False)


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
    # team_status = Column(BigInteger, ForeignKey('team_status.id'))
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
    email = Column(String(50), nullable=False)
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
