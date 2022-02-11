import os

from flask import Flask, render_template, request, redirect, session, url_for, flash, jsonify
from flask_sqlalchemy import SQLAlchemy

from db.db import *

app = Flask(__name__)
SECRET_KEY = os.urandom(32)
app.config['SECRET_KEY'] = SECRET_KEY
app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False



@app.route('/', methods=['GET', 'POST'])
def base():
    # print([str(i.id) + ' ' + i.name for i in db.query(UserRole).all()])
    # print([i.nickname for i in db.query(Users).all()])
    return render_template('base.html')


@app.route('/bounds')
def bounds():
    return render_template('bounds.html')


@app.route('/oop')
def oop():
    return render_template('oop.html')


if __name__ == '__main__':
    app.run()


