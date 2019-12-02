import traceback
import random
import re
import os
from flask import Flask, render_template, url_for, request, redirect, session, g
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, timedelta
from passlib.hash import sha256_crypt


########################################
# Configuration
########################################

app = Flask(__name__)
app.secret_key = os.urandom(24)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///iis.db'
db = SQLAlchemy(app)


########################################
# Database classes definitions
########################################

class Uzivatel(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    meno = db.Column('meno', db.String(20), nullable=False)
    priezvisko = db.Column('priezvisko', db.String(20), nullable=False)
    adresa = db.Column('adresa', db.String(20), nullable=False)
    cislo = db.Column('tel_cislo', db.String(13), nullable=False)
    email = db.Column('email', db.String(100), nullable=False)
    heslo = db.Column('heslo', db.Unicode, nullable=False)


class Operator(db.Model):
    sluzobny_tel = db.Column('sluzobny_tel', db.String(13), nullable=False)
    id = db.Column('id', db.String(10), primary_key=True)


class Ridic(db.Model):
    spz = db.Column('spz', db.String(10), nullable=False)
    id = db.Column('id', db.String(10), primary_key=True)


class Admin(db.Model):
    id_ntb = db.Column('id_ntb', db.String(10), nullable=False)
    id = db.Column('id', db.String(10), primary_key=True)


class Stravnik(db.Model):
    cislo_karty = db.Column('cislo_karty', db.Integer, nullable=False)
    id = db.Column('id', db.String(10), primary_key=True)


class Plan_ridice(db.Model):
    id_planu = db.Column('id_planu', db.Integer, primary_key=True)
    region = db.Column('region', db.String(10), nullable=False)
    id_operatora = db.Column('id_operatora', db.String(10),
                             nullable=False)
    id_ridica = db.Column('id_ridica', db.String(10), nullable=False)


class Objednavka(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    cena_celkom = db.Column('cena_celkom', db.Integer, nullable=False)
    stav = db.Column('stav', db.String(10), nullable=False, default='Evidovana')
    cas_objednania = db.Column('cas_objednania', db.String(16), nullable=False, default=datetime.now)
    cas_dorucenia = db.Column('cas_dorucenia', db.String(16), nullable=False, default=datetime.now() + timedelta(hours=1))
    id_operatora = db.Column('id_operatora', db.String(10))
    id_stravnika = db.Column('id_stravnika', db.String(10))
    id_plan_ridice = db.Column('id_plan_ridice', db.String(10))


class Jidlo(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    nazov = db.Column('nazov', db.String(20), nullable=False)
    typ = db.Column('typ', db.String(20), nullable=False)
    popis = db.Column('popis', db.String(100), nullable=True)
    alergeny = db.Column('alergeny', db.String(20), nullable=True)
    cena = db.Column('cena', db.Integer, nullable=False)
    id_objednavky = db.Column('id_objednavky', db.String(10), nullable=True)
    id_operator = db.Column('id_operator', db.String(10), nullable=True)


class Provozna(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    nazov = db.Column('nazov', db.String(100), nullable=False)
    adresa = db.Column('adresa', db.String(100), nullable=False)
    uzavierka = db.Column('uzavierka', db.DateTime, nullable=False)
    id_operatora = db.Column('id_operatora', db.String(10), nullable=True)


class Trvala_nabidka(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    platnost_od = db.Column('platnost_od', db.String(10), nullable=False)
    platnost_do = db.Column('platnost_do', db.String(10), nullable=False)
    id_provozny = db.Column('id_provozny', db.Integer, nullable=False)


class Denni_menu(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    datum = db.Column('datum', db.DateTime, nullable=False)
    id_provozny = db.Column('id_provozny', db.Integer, nullable=False)


########################################
# Auxiliary methods and utilities
########################################

@app.before_request
def before_request():
    g.user = None
    if 'user' in session:
        g.user = session['user']


@app.errorhandler(Exception)
def exception_handler(e):
    print(traceback.format_exc())
    if isinstance(e, HTTPException):
        return render_template("error.html", code=e.code, name=e.name, desc=e.description), e.code
    return render_template("error.html", code=500), 500


########################################
# Website routes
########################################

@app.route('/')
def index():
    canteens = Provozna.query.order_by(Provozna.id).all()
    print(canteens)
    return render_template('index.html', items=canteens)


@app.route('/showSignUp', methods=['POST', 'GET'])
def singup():
    if request.method == 'POST':
        user_name = request.form['meno']
        user_email = request.form['email']
        user_password = sha256_crypt.encrypt(request.form['heslo'])
        user_tel = request.form['cislo']

        regex = re.compile('^(\+\d{12}|\d{10})$')
        if regex.match(user_tel):
            pass
        else:
            return '<h2>Zadaj cislo v style:</h2><h3>+421999999999<br>090111222333</h3>'

        new_user = Uzivatel(
            meno=user_name,
            priezvisko='Test',
            adresa='',
            cislo=user_tel,
            email=user_email,
            heslo=user_password,
            )

        last_user = Uzivatel.query.order_by(Uzivatel.id.desc()).first()
        new_stravnik = Stravnik(cislo_karty='', id=last_user.id + 1)

        try:
            db.session.add(new_user)
            db.session.add(new_stravnik)
            db.session.commit()
            return redirect('/')
        except Exception as e:
            return 'There was a issue with adding your task.'
    else:

        return render_template('showSignUp.html')


@app.route('/logIn', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        session.pop('user', None)

        entred_password = request.form['heslo']
        entred_email = request.form['email']

        user = Uzivatel.query.filter(Uzivatel.email == entred_email).first()

        if sha256_crypt.verify(entred_password, user.heslo):
            session['user'] = user.id
            return redirect('/menu')

    return render_template('logIn.html')


@app.route('/logOut')
def logout():
    session.pop('user', None)
    return redirect('/')


@app.route('/trvalaNabidka')
def trvalanabidka():
    provozny = Provozna.query.order_by(Provozna.id).all()
    nabidky = Trvala_nabidka.query.order_by(Trvala_nabidka.id).all()
    for nabidka in nabidky:
        for nabidka2 in nabidky:
            if nabidka.id_provozny == nabidka2.id_provozny and nabidka.id != nabidka2.id:
                if nabidka.platnost_do > nabidka2.platnost_od:
                    return render_template('platnost_error.html', nabidka=nabidka, nabidka2=nabidka2)
    return render_template('provozny.html', provozny=provozny, nabidky=nabidky)


@app.route('/menu', methods=['GET', 'POST'])
def order():
    if g.user:
        if request.method == 'POST':
            pocet_operatorov = Operator.query.count()
            operator = Operator.query.all()
            id_operatora = operator[random.randint(0, pocet_operatorov - 1)].id
            cena_celkom = 1000
            objednavka = Objednavka.query.order_by(Objednavka.id.desc()).first()
            id_objednavky = objednavka.id + 1
            new_order = Objednavka(
                id=id_objednavky,
                cena_celkom=cena_celkom,
                id_operatora=id_operatora,
                id_stravnika=g.user)

            try:
                db.session.add(new_order)
                db.session.commit()
                return redirect('/objednavky')
            except Exception as e:
                print(e)
                return 'There was a issue with adding your order.'
        else:
            return 'Menu for' + str(g.user)
    else:
        return redirect('/logIn')


@app.route('/objednavky')
def show_objednavky():
    if g.user:
        objednavky = Objednavka.query.filter(Objednavka.id_stravnika == g.user).all()
        return render_template('objednavky.html', orders=objednavky)
    return redirect('/logIn')


########################################
# Main module guard
########################################

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='5000', debug=True)

