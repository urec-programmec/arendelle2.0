from sqlalchemy import Column, BigInteger, String, Integer, DATETIME, ForeignKey, LargeBinary, create_engine, JSON, TIME
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:password@localhost:5432/dnd'
engine = create_engine(SQLALCHEMY_DATABASE_URI)
Session = sessionmaker(bind=engine)
db = Session()
Base = declarative_base()

class Dnd(Base):
    __tablename__ = 'map'
    id = Column(Integer, primary_key=True)
    rooms = Column(JSON, nullable=False)
    lines = Column(JSON, nullable=False)
    items = Column(JSON, nullable=False)
