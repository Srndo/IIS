from flask import Flask, render_template, url_for, request, redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:Nomis0409@localhost/iis'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
#db = mysqli_init();
#if (mysqli_real_connect(db, 'localhost', 'xsesta06', 'kejugu4e', 'xsesta06', 0, '/var/run/mysql/mysql.sock'))
#	pass
#else
#	die('cannot connect '.mysqli_connecterror())


class User(db.Model):
	id = db.Column('id', db.Unicode, primary_key = True)
	name = db.Column('meno', db.Unicode, nullable = False)
	priezvisko = db.Column('priezvisko', db.Unicode, nullable = False)
	adresa = db.Column('adresa', db.Unicode, nullable = False)
	phone = db.Column('tel_cislo', db.Unicode, nullable = False)
	email = db.Column('email', db.Unicode, nullable = False)
	password = db.Column('heslo', db.Unicode, nullable = False)


class Order(db.Model):
	id = db.Column('id', db.Integer, primary_key = True)
	price = db.Column('cena_celkom', db.Integer, nullable = False)
	state = db.Column('stav', db.Unicode, nullable = False)
	order_time = db.Column('cas_objednania', db.DateTime, nullable = False)
	arrive_time = db.Column('cas_dorucenia', db.DateTime, nullable = False)
	
	# make own function for getting operator and 'stravnik'
	# order table have only id's of them

@app.route('/')
def index():
	users = User.query.order_by(User.id).all()
	return render_template('users.html', users=users)

if __name__ == "__main__":
	app.run(debug=True)