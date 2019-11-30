from flask import Flask, render_template, url_for, request, redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

app = Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///iis.db'
db = SQLAlchemy(app)


class Uzivatel(db.Model):
	id = db.Column('id', db.String(10), primary_key = True)
	meno = db.Column('meno', db.String(20), nullable = False)
	priezvisko = db.Column('priezvisko', db.String(20), nullable = False)
	adresa = db.Column('adresa', db.String(20), nullable = False)
	cislo = db.Column('tel_cislo', db.String(13), nullable = False)
	email = db.Column('email', db.String(100), nullable = False)
	heslo = db.Column('heslo', db.String(20), nullable = False)

	def __repr__(self):
		return '<Uzivatel %r>' % self.id 

class Operator(db.Model):
	sluzobny_tel = db.Column('sluzobny_tel', db.String(13), nullable = False)
	id = db.Column('id', db.String(10), primary_key = True)	

	def __repr__(self):
		return '<Operator %r>' % self.id 


class Ridic(db.Model):
	spz = db.Column('spz', db.String(10), nullable = False)
	id = db.Column('id', db.String(10), primary_key = True)

	def __repr__(self):
		return '<Ridic %r>' % self.id 


class Admin(db.Model):
	id_ntb = db.Column('id_ntb', db.String(10), nullable = False)
	id = db.Column('id', db.String(10), primary_key = True)

	def __repr__(self):
		return '<Admin %r>' % self.id 


class Stravnik(db.Model):
	cislo_karty = db.Column('cislo_karty', db.Integer, nullable = False)
	id = db.Column('id', db.String(10), primary_key = True)

	def __repr__(self):
		return '<Stravnik %r>' % self.id 


class Plan_ridice(db.Model):
	id_planu = db.Column('id_planu', db.String(10), primary_key = True)
	region = db.Column('region', db.String(10), nullable = False)
	id_operatora = db.Column('id_operatora', db.String(10), nullable = False)
	id_ridica = db.Column('id_ridica', db.String(10), nullable = False)

	def __repr__(self):
		return '<Plan_ridice %r>' % self.id_planu


class Objednavka(db.Model):
	id = db.Column('id', db.String(10), primary_key = True)
	cena_celkom = db.Column('cena_celkom', db.Integer, nullable = False)
	stav = db.Column('stav', db.String(10), nullable = False)
	cas_objednania = db.Column('cas_objednania', db.DateTime, nullable = False)
	cas_dorucenia = db.Column('cas_dorucenia', db.DateTime, nullable = False)
	id_operatora = db.Column('id_operatora', db.String(10))
	id_stravnika = db.Column('id_stravnika', db.String(10))
	id_plan_ridice = db.Column('id_plan_ridice', db.String(10))
	
	# make own function for getting operator and 'stravnik'
	# order table have only id's of them

	def __repr__(self):
		return '<Objednavka %r>' % self.id 


class Jidlo(db.Model):
	id = db.Column('id', db.String(5), primary_key = True)
	nazov = db.Column('nazov', db.String(20), nullable = False)
	typ = db.Column('typ', db.String(20), nullable = False)
	popis = db.Column('popis', db.String(100), nullable = True)
	alergeny = db.Column('alergeny', db.String(20), nullable = True)
	cena = db.Column('cena', db.Integer, nullable = False)
	id_objednavky = db.Column('id_objednavky', db.String(10), nullable = True)
	id_operator = db.Column('id_operator', db.String(10), nullable = True)

	def __repr__(self):
		return '<Jidlo %r>' % self.id 


class Provozna(db.Model):
	id = db.Column('id', db.Integer, primary_key = True)	
	nazov = db.Column('nazov', db.String(100), nullable = False)
	adresa = db.Column('adresa', db.String(100), nullable = False)
	uzavierka = db.Column('uzavierka', db.DateTime, nullable = False)
	#menu = db.relationship("Denni_menu", backref = 'menu_ma_provozna')
	#nabidka = db.relationship("Trvala_nabidka", backref = 'nabidku_ma_provozna')
	#id_operatora = db.Column(db.String(10), db.ForeignKey("provozna.id")) 
	id_operatora = db.Column('id_operatora', db.String(10), nullable = True) 

	def __repr__(self):
		return '<Provozna %r>' % self.id 


class Trvala_nabidka(db.Model):
	id = db.Column('id', db.String(5), primary_key = True)
	platnost_od = db.Column('platnost_od', db.DateTime, nullable = False)
	platnost_do = db.Column('platnost_do', db.DateTime, nullable = False)
	#v_provozne = db.Column(db.Integer, db.ForeignKey('provozna.id'))
	id_provozny = db.Column('id_provozny', db.Integer, nullable = False)

	def __repr__(self):
		return '<Trvala_nabidka %r>' % self.id 


class Denni_menu(db.Model):
	id = db.Column('id', db.String(5), primary_key = True)
	datum = db.Column('datum', db.DateTime, nullable = False)
	#v_provozne = db.Column(db.Integer, db.ForeignKey('provozna.id'))
	id_provozny = db.Column('id_provozny', db.Integer, nullable = False)

	def __repr__(self):
		return '<Denni_menu %r>' % self.id 


@app.route('/')
def index():
	users = Uzivatel.query.order_by(Uzivatel.id).all()
	return render_template('index.html', users=users)

@app.route('/showSignUp', methods=['POST', 'GET'])
def index():
	if request.method == 'POST':
		user_name = request.form['meno']
		user_email = request.form['email']
		user_password = request.form['heslo']

		new_user = Uzivatel(meno=user_name, priezvisko="Test", adresa="", cislo="", email=user_email, heslo=user_password)
		try:
			db.session.add(new_user)
			db.session.commit()
			return redirect('/')
		except Exception as e:
			return 'There was a issue with adding your task.'


if __name__ == "__main__":
	app.run(debug=True)
