from sqlalchemy_utils.functions import database_exists, create_database, drop_database

url = 'postgresql+psycopg2://postgres:admin@localhost/arendelle2.0'

if database_exists(url):
    drop_database(url)
create_database(url)
