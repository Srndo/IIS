import traceback
import random
import os
from flask import Flask, render_template, request, redirect, session, g, abort
from werkzeug.exceptions import HTTPException
from datetime import datetime, timedelta
from flask_sqlalchemy import SQLAlchemy
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

class Canteen(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    name = db.Column('name', db.String(256), nullable=False)
    address = db.Column('address', db.String(256), nullable=False)
    description = db.Column('description', db.String(4096), nullable=False)
    img_src = db.Column('img_src', db.String(256), nullable=False)
    id_operator = db.Column('id_operator', db.Integer)
    id_daily = db.Column('id_daily', db.Integer)
    id_permanent = db.Column('id_permanent', db.Integer)


class DailyMenu(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)


class PermanentMenu(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)


class Food(db.Model):
    id = db.Column('id', db.INTEGER,  primary_key=True)
    name = db.Column('name', db.String(256), nullable=False)
    type = db.Column('type', db.String(64), nullable=False)
    description = db.Column('description', db.String(1024), nullable=False)
    allergens = db.Column('allergens', db.String(64), nullable=False)
    price = db.Column('price', db.Float, nullable=False)


class Order(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    status = db.Column('status', db.String(64), nullable=False)
    order_time = db.Column('order_time', db.Integer, nullable=False)
    name = db.Column('name', db.String(256), nullable=False)
    surname = db.Column('surname', db.String(256), nullable=False)
    address = db.Column('address', db.String(256), nullable=False)
    postcode = db.Column('postcode', db.String(64), nullable=False)
    city = db.Column('city', db.String(256), nullable=False)
    phone = db.Column('phone', db.String(64), nullable=False)
    email = db.Column('email', db.String(256), nullable=False)
    id_user = db.Column('id_user', db.Integer)
    id_driver = db.Column('id_driver', db.Integer)


class FoodInDaily(db.Model):
    id_food = db.Column('id_food', db.Integer, primary_key=True, autoincrement=False)
    id_daily = db.Column('id_daily', db.Integer, primary_key=True, autoincrement=False)


class FoodInPermanent(db.Model):
    id_food = db.Column('id_food', db.Integer, primary_key=True, autoincrement=False)
    id_permanent = db.Column('id_permanent', db.Integer, primary_key=True, autoincrement=False)


class FoodInOrder(db.Model):
    id_food = db.Column('id_food', db.Integer, primary_key=True, autoincrement=False)
    id_order = db.Column('id_order', db.Integer, primary_key=True, autoincrement=False)


class User(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    email = db.Column('email', db.String(256), nullable=False, unique=True)
    password = db.Column('password', db.Unicode, nullable=False)
    name = db.Column('name', db.String(256), nullable=False)
    surname = db.Column('surname', db.String(256), nullable=False)
    address = db.Column('address', db.String(256), nullable=False)
    postcode = db.Column('postcode', db.String(64), nullable=False)
    city = db.Column('city', db.String(256), nullable=False)
    phone = db.Column('phone', db.String(64), nullable=False)


class Driver(db.Model):
    id = db.Column('id', db.Integer, primary_key=True, autoincrement=False)


class Operator(db.Model):
    id = db.Column('id', db.Integer, primary_key=True, autoincrement=False)


class Admin(db.Model):
    id = db.Column('id', db.Integer, primary_key=True, autoincrement=False)


########################################
# Auxiliary methods and utilities
########################################

@app.before_request
def load_logged_in_user():
    g.user = None
    user_id = session.get('user_id')
    if user_id is not None:
        user = User.query.filter(User.id == user_id).first()
        if user is None:  # Serious server error or data manipulation
            session.clear()
            abort(500)
        g.user = user.email
        g.user_id = user.id

        driver = Driver.query.filter(Driver.id == user.id).first()
        if driver is None:
            g.driver = False
        else:
            g.driver = True

        operator = Operator.query.filter(Operator.id == user.id).first()
        if operator is None:
            g.operator = False
        else:
            g.operator = True
        
        admin = Admin.query.filter(Admin.id == user.id).first()
        if admin is None:
            g.admin = False
        else:
            g.admin = True


@app.errorhandler(Exception)
def exception_handler(e):
    if isinstance(e, HTTPException):
        print(e)
        return render_template("error.html", code=e.code, name=e.name, desc=e.description), e.code
    else:
        print(traceback.format_exc())
        return render_template("error.html", code=500), 500


########################################
# Website routes
########################################

@app.route('/')
def index():
    canteens = Canteen.query.order_by(Canteen.id).all()
    return render_template('index.html', items=canteens)


@app.route('/register', methods=['POST', 'GET'])
def register():
    if request.method == 'POST':
        name = request.form['name']
        surname = request.form['surname']
        address = request.form['address']
        tel = request.form['tel']
        user_email = request.form['email']
        user_password = request.form['password']
        role = request.form['role']

        error = None
        if user_email is None:
            error = "Username is required"
        elif user_password is None:
            error = "Password is required"
        elif User.query.filter(User.email == user_email).first() is not None:
            error = f"Email {user_email} is already registered."

        if error is None:
            encrypted = sha256_crypt.encrypt(user_password)
            new_user = User(
                # TODO!
                name=name,
                surname=surname,
                address=address,
                phone=tel,
                email=user_email,
                password=encrypted,
                )
            db.session.add(new_user)
            db.session.commit()

            new_user = User.query.order_by(User.id.desc()).first()
            print("ROLA JE:")
            print(role)
            if role == 'user':
                new_stravnik = Stravnik(cislo_karty='', id=new_user.id)
                db.session.add(new_stravnik)
            
            elif role == 'driver':
                new_driver = Driver(spz='', id=new_user.id)
                db.session.add(new_driver)
                print("HERE")

            db.session.commit()

            return render_template('all_done.html', desc="Succesfully registered")
        else:
            return render_template("error.html", name="Registration error", desc=error), 400
    return render_template('register.html')


@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        user_email = request.form['email']
        user_password = request.form['password']
        error = None
        if not user_email:
            error = "Username is required."
        elif not user_password:
            error = "Password is required."
        else:
            user = User.query.filter(User.email == user_email).first()
            if user is None or not sha256_crypt.verify(user_password, user.password):
                error = f"Wrong email or password."

        if error is None:
            session.clear()
            session["user_id"] = user.id
            return redirect("/")
        else:
            return render_template("error.html", name="Login error", desc=error), 400
    return render_template("login.html")


@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')


@app.route('/canteen/<int:canteen_id>')
def canteen_page(canteen_id):
    canteen = Canteen.query.filter(Canteen.id == canteen_id).first()
    if canteen is None:
        abort(404)

    permanent_foods = None
    permanent = PermanentMenu.query.filter(PermanentMenu.id_provozny == canteen_id).first()
    if permanent is not None:
        permanent_foods = (Food.query
                           .join(FoodInPermanent, FoodInPermanent.id_food == Food.id)
                           .join(PermanentMenu, permanent.id == FoodInPermanent.id_permanent)
                           .all())

    daily_foods = None
    daily = DailyMenu.query.filter(DailyMenu.id_provozny == canteen_id).first()
    if daily is not None:
        daily_foods = (Food.query
                       .join(FoodInDaily, FoodInDaily.id_food == Food.id)
                       .join(DailyMenu, daily.id == FoodInDaily.id_daily)
                       .all())

    return render_template(
        'canteen.html',
        canteen=canteen,
        daily_foods=daily_foods,
        permanent_foods=permanent_foods)


@app.route('/new_order/<int:id>', methods=['GET', 'POST'])
def new_order(id):
    if g.user:
        pocet_operatorov = Operator.query.count()
        operator = Operator.query.all()
        id_operatora = operator[random.randint(0, pocet_operatorov - 1)].id
        
        objednavka = Objednavka.query.order_by(Objednavka.id.desc()).first()
        id_objednavky = objednavka.id + 1
        
        cena_celkom = Food.query.filter(Food.id == id).first().cena
        
        
        id_stravnika = g.user_id
        
        
        new_order = Objednavka(id=id_objednavky, cena_celkom=cena_celkom, id_operatora=id_operatora, id_stravnika=id_stravnika, stav='Evidated')
        db.session.add(new_order)
        db.session.commit()
        return render_template('all_done.html', desc="Ordered")
    return render_template('error.html', desc="Only registered user can order")

@app.route('/orders')
def show_objednavky():
    if g.user:
        objednavky = Order.query.filter(Order.id_user == g.user_id).all()
        return render_template('orders.html', orders=objednavky)
    return redirect('/login')


@app.route('/profile')
def show_profile():
    if g.user:
        user = User.query.filter(User.id == g.user_id).first()
        return render_template('profile.html', user=user)
    return redirect('/login')


@app.route('/shopping-cart')
def show_shopping_cart():
    if g.user:
        return render_template('shopping_cart.html')
    return redirect('/login')


""""@app.route('/create_plan', methods=['POST', 'GET'])
def create_plan():
    if g.operator or g.admin:
        if request.method == 'POST':
            region = request.form['region']
            driver_name = request.form['name']
            driver_surname = request.form['surname']
            drivers = User.query.filter(User.name == driver_name and User.surname == driver_surname).all()
            for driver in drivers:
                selected_driver = Ridic.query.filter(Ridic.id == driver.id).first()
                if selected_driver is not None:
                    break
            new_plan = Plan_ridice(id_operatora=g.user_id, region=region, id_ridica=selected_driver.id)
            
            db.session.add(new_plan)
            db.session.commit()
            return render_template('all_done.html', desc="Plan created")
        else:
            return render_template('create_plan.html')
    return redirect('login')"""


@app.route('/driver_plan')
def show_plan():
    if g.driver:
        plans = Plan_ridice.query.filter(Plan_ridice.id_ridica == g.user_id).all()
        return render_template('driver_plan.html', plans=plans)


@app.route('/manage_users', methods=['POST', 'GET'])
def manage_users():
    if g.admin:
        users = User.query.all()
        #prepare for showing in different tables
        #customers = Stravnik.query.filter(User.id == Stravnik.id).all()
        #drivers = Ridic.query.filter(User.id == Ridic.id).all()
        #operators = Operator.query.filter(User.id == Operator.id).all()
        #admins = Admin.query.filter(User.id == Admin.id).all()
        if request.method == 'POST':
            pass
        else:
            #return render_template('manage_users.html', admins=admins, operators=operators, drivers=drivers, customers=customers)
            return render_template('manage_users.html', users=users)
    return redirect('/login')


@app.route('/edit_user/<int:id>', methods=['GET', 'POST'])
def edit_user(id):
    if str(g.user_id) == str(id) or g.admin:
        user = User.query.filter(User.id == id).first()
        role = None

        pom = Driver.query.filter(Driver.id == id).first()
        if pom is not None:
            role = 'Driver'

        pom = Operator.query.filter(Operator.id == id).first()
        if pom is not None:
            role = 'Operator'

        pom = Admin.query.filter(Admin.id == id).first()
        if pom is not None:
            role = 'Admin'

        if role is None:
            role = 'User'

        if request.method == 'POST':
            new_name = request.form['name']
            new_surname = request.form['surname']
            new_email = request.form['email']
            new_address = request.form['address']
            new_tel = request.form['tel']
            new_password = request.form['password']

            if new_name:
                user.name = new_name
            if new_surname:
                user.surname = new_surname
            if new_address:
                user.address = new_address
            if new_tel:
                user.phone = new_tel
            if new_email:
                user.email = new_email
            if new_password:
                user.password = sha256_crypt.encrypt(new_password)

            new_role = request.form['role']
            if new_role != role:
                delete = None
                if role == 'Driver':
                    delete = Driver.query.filter(Driver.id == id).first()
                if role == 'Operator':
                    delete = Operator.query.filter(Operator.id == id).first()
                if role == 'Admin':
                    delete = Admin.query.filter(Admin.id == id).first()
                    admin_count = Admin.query.count()
                    if admin_count == 1:
                        return render_template('error.html', name="Edit error", desc="There must be at least one admin!" )
                
                if delete is not None:
                    db.session.delete(delete)

                if new_role == 'driver':
                    new = Driver(id=id)
                if new_role == 'operator':
                    new = Operator(id=id)
                if new_role == 'admin':
                    new = Admin(id=id)

                if new_role != 'user':
                    db.session.add(new)
                db.session.commit()
            
            return render_template('all_done.html', desc="Informations change")

        else:
            return render_template('edit_user.html', user=user, role=role)
    return redirect('/login')

@app.route('/remove_user/<int:id>')
def remove_user(id):
    if g.admin:
        user = User.query.filter(User.id == id).first()
        db.session.delete(user)
        db.session.commit()

        return render_template('all_done.html', desc="User removed")
        
    return redirect('/login')

@app.route('/add_canteen', methods=['POST', 'GET'])
def add_canteen():
    if g.operator or g.admin:
        if request.method == 'POST':
            name = request.form['name']
            address = request.form['address']
            description = request.form['description']
            #deadline = request.form['deadline']
            id_operator = request.form['operator']

            operator = User.query.filter(User.id == id_operator).first()

            new_canteen = Canteen(name=name, address=address, description=description, id_operator=id_operator, img_src='https://via.placeholder.com/150')
            db.session.add(new_canteen)
            db.session.commit()

            return render_template('all_done.html', desc="New canteen aded")

        else:
            operators = User.query.filter(User.id == Operator.id).all()
            return render_template('add_canteen.html', operators=operators)

    return redirect('/login')

@app.route('/manage_canteen')
def manage_canteen():
    if g.operator or g.admin:
        canteens = Canteen.query.all()
        return render_template('manage_canteen.html', canteens=canteens)
    else:
        return redirect('/login')


@app.route('/manage_orders')
def manage_orders():
    if g.operator or g.admin:
        return render_template('manage_orders.html')
    else:
        return redirect('/login')



@app.route('/add_item', methods=['POST', 'GET'])
def add_item():
    if g.operator or g.admin:
        if request.method == 'POST':
            name = request.form['name']
            type = request.form['type']
            description = request.form['description']
            alergens = request.form['alergens']
            price = request.form['price']
            
            new_item = Food(nazov=name, typ=type, popis=description, alergeny=alergens, cena=price)
            db.session.add(new_item)
            db.session.commit()
            
            return render_template('all_done.html', desc="New item aded")
            
        else:
            return render_template('add_item.html')
        
    return redirect('/login')


@app.route('/remove_canteen/<int:canteen_id>')
def remove_canteen(canteen_id):
    if g.operator or g.admin:
        canteen = Canteen.query.filter(Canteen.id == canteen_id).first()
        db.session.delete(canteen)
        db.session.commit()
        
        return render_template('all_done.html', desc="Canteen removed")
        
    return redirect('/login')


@app.route('/remove_item', methods=['POST', 'GET'])
def remove_item():
    if g.operator or g.admin:
        if request.method == 'POST':
            name = request.form['name']
            item = Food.query.filter(Food.name == name).first()
            db.session.delete(item)
            db.session.commit()
            
            return render_template('all_done.html', desc="Item removed")
                
        else:
            return render_template('remove_item.html')
        
    return redirect('/login')


@app.route('/add')
def add():
    if g.operator or g.admin:
        return render_template('add.html')
    return redirect('/login')


@app.route('/remove')
def remove():
    if g.operator or g.admin:
        return render_template('remove.html')
    return redirect('/login')


########################################
# Main module guard
########################################

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='5000', debug=True)
