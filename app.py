import os
import uuid

from flask import Flask, render_template, request, redirect, session, url_for, flash, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

from db.db import *

app = Flask(__name__, static_url_path='')
SECRET_KEY = os.urandom(32)
app.config['SECRET_KEY'] = SECRET_KEY
app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
CORS(app)

# mapCount = 100
# mapColors = {0:"red", 1:"wheat"}

# @app.route('/mapSettings', methods=['GET'])
# def mapSettings():
#     response_object = {'status': 'success'}
#     response_object['mapCount'] = mapCount
#     response_object['mapColors'] = mapColors
#     return jsonify(response_object)













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




# @app.route('/', methods=['GET', 'POST'])
# def base():
#     # print([str(i.id) + ' ' + i.name for i in db.query(UserRole).all()])
#     # print([i.nickname for i in db.query(Users).all()])
#     return render_template('base.html')
#
# @app.route('/bounds')
# def bounds():
#     return render_template('bounds.html')
#
#
# @app.route('/oop')
# def oop():
#     return render_template('oop.html')
#
#
# @app.route('/mapcreator')
# def mapcreator():
#     return render_template('mapcreator.html')

if __name__ == '__main__':
    app.run()


