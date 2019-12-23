import traceback
import datetime
import time
import os
from flask import Flask, render_template, request, redirect, session, g, abort
from werkzeug.exceptions import HTTPException
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
user_counter = 0


########################################
# Database classes definitions
########################################

class Canteen(db.Model):
    id = db.Column('id', db.Integer, primary_key=True)
    name = db.Column('name', db.String(256), nullable=False)
    address = db.Column('address', db.String(256), nullable=False)
    description = db.Column('description', db.String(4096), nullable=False)
    img_src = db.Column('img_src', db.String(256), nullable=False)


class Food(db.Model):
    id = db.Column('id', db.INTEGER,  primary_key=True)
    name = db.Column('name', db.String(256), nullable=False)
    type = db.Column('type', db.String(64), nullable=False)
    description = db.Column('description', db.String(1024), nullable=False)
    allergens = db.Column('allergens', db.String(64), nullable=False)
    price = db.Column('price', db.Float, nullable=False)
    id_canteen = db.Column('id_canteen', db.Integer, nullable=False)
    active = db.Column('active', db.Integer, nullable=False)


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


class FoodInOrder(db.Model):
    id_food = db.Column('id_food', db.Integer, primary_key=True, autoincrement=False)
    id_order = db.Column('id_order', db.Integer, primary_key=True, autoincrement=False)
    qty = db.Column('qty', db.Integer, nullable=False)


class FoodInCart(db.Model):
    id_user = db.Column('id_user', db.Integer, primary_key=True, autoincrement=False)
    id_food = db.Column('id_food', db.Integer, primary_key=True, autoincrement=False)
    qty = db.Column('qty', db.Integer, nullable=False)


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
    global user_counter
    g.user = None
    g.operator = False
    g.driver = False
    g.admin = False
    user_id = session.get('user_id')
    if user_id is not None:
        if user_id >= 0:
            user = User.query.filter(User.id == user_id).first()
            if user is None:  # Serious server error or data manipulation
                session.clear()
                abort(500)
            g.user = user.email
            g.user_id = user.id

            driver = Driver.query.filter(Driver.id == user.id).first()
            operator = Operator.query.filter(Operator.id == user.id).first()
            admin = Admin.query.filter(Admin.id == user.id).first()

            if driver is not None:
                g.driver = True
            elif operator is not None:
                g.operator = True
            elif admin is not None:
                g.admin = True
        else:  # Unregistered user
            g.user_id = user_id
    else:  # user_id is None
        session['user_id'] = -1 - user_counter
        user_counter += 1


@app.errorhandler(Exception)
def exception_handler(e):
    if isinstance(e, HTTPException):
        print(f"{e.code} {e.name}: {e.description}")
        return render_template("error.html", code=e.code, name=e.name, desc=e.description), e.code
    else:
        print(traceback.format_exc())
        return render_template("error.html", code=500), 500


def get_cart_info(user_id):
    entries = FoodInCart.query.filter_by(id_user=user_id).all()
    result = []
    total = 0
    for entry in entries:
        food = Food.query.filter(Food.id == entry.id_food).first()
        result.append((food, entry))
        total += food.price * entry.qty
    return result, total


def get_all_orders_info():
    driver_list = User.query.join(Driver, User.id == Driver.id).all()
    result = []
    orders = Order.query.all()
    for order in orders:
        entries = FoodInOrder.query.filter_by(id_order=order.id).all()
        price = 0
        for entry in entries:
            food = Food.query.filter(Food.id == entry.id_food).first()
            price += food.price * entry.qty
        user = User.query.filter_by(id=order.id_user).first()
        driver = User.query.filter_by(id=order.id_driver).first()
        result.append((order, user, price, driver))
    result.reverse()
    return result, driver_list


def get_profile_info():
    if g.driver:
        role = "Driver"
    elif g.operator:
        role = "Operator"
    elif g.admin:
        role = "Administrator"
    else:
        role = "Customer"
    user = User.query.filter(User.id == g.user_id).first()
    orders = Order.query.filter_by(id_user=g.user_id).all()
    result = []
    for order in orders:
        entries = FoodInOrder.query.filter_by(id_order=order.id).all()
        price = 0
        for entry in entries:
            food = Food.query.filter(Food.id == entry.id_food).first()
            price += food.price * entry.qty
        result.append((order, price))
    return user, role, result


def get_order_info(order_id):
    result = []
    entries = FoodInOrder.query.filter_by(id_order=order_id).all()
    price = 0
    for entry in entries:
        food = Food.query.filter(Food.id == entry.id_food).first()
        price += food.price * entry.qty
        result.append((food, entry))
    return result, price


def int_to_time(timestamp):
    date = datetime.datetime.fromtimestamp(timestamp)
    return date.strftime("%Y-%m-%d %H:%M:%S %z %Z")


app.jinja_env.globals.update(int_to_time=int_to_time)


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
        email = request.form['email']
        password = request.form['password']
        name = request.form['name']
        surname = request.form['surname']
        address = request.form['address']
        postcode = request.form['postcode']
        city = request.form['city']
        phone = request.form['phone']
        new_user = User(
            email=email,
            password="",
            name=name,
            surname=surname,
            address=address,
            postcode=postcode,
            city=city,
            phone=phone
            )
        if None in (email, password, name, surname, address, postcode, city, phone):
            return render_template("register.html", user=new_user, error="Please fill in all required fields."), 400
        if User.query.filter(User.email == email).first() is not None:
            return render_template("register.html", user=new_user, error=f"Email {email} is already registered."), 400
        new_user.password = sha256_crypt.encrypt(password)
        db.session.add(new_user)
        db.session.commit()
        return redirect("/login")
    return render_template('register.html')


@app.route('/login', methods=['POST', 'GET'])
def login():
    if g.user:
        return redirect("/")
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        if None in (email, password):
            return render_template("login.html", email=email, error="Please fill in all required fields."), 400
        user = User.query.filter(User.email == email).first()
        if user is None or not sha256_crypt.verify(password, user.password):
            return render_template("login.html", email=email, error="Wrong email or password."), 400
        session.clear()
        session["user_id"] = user.id
        return redirect("/")
    return render_template("login.html")


@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')


@app.route('/canteen/<int:canteen_id>')
def show_canteen(canteen_id):
    canteen = Canteen.query.filter(Canteen.id == canteen_id).first()
    if canteen is None:
        abort(404)
    foods = Food.query.filter_by(id_canteen=canteen_id).all()
    permanent_foods = [food for food in foods if food.type != 'Lunch']
    daily_foods = [food for food in foods if food.type == 'Lunch']
    return render_template(
        'canteen.html',
        canteen=canteen,
        daily_foods=daily_foods,
        permanent_foods=permanent_foods)


@app.route('/add-to-cart', methods=['POST'])
def add_to_cart():
    food_id = int(request.form['food_id'])
    food = Food.query.filter(Food.id == food_id).first()
    if food is None:
        abort(400)
    item = (FoodInCart.query
            .filter(FoodInCart.id_user == g.user_id)
            .filter(FoodInCart.id_food == food_id)
            .first())
    if item:
        item.qty += 1
    else:
        new_item = FoodInCart(
            id_user=g.user_id,
            id_food=food_id,
            qty=1
        )
        db.session.add(new_item)
    db.session.commit()
    return redirect(request.form['redirect'])


@app.route('/remove-from-cart', methods=['POST'])
def remove_from_cart():
    food_id = int(request.form['food_id'])
    food = Food.query.filter(Food.id == food_id).first()
    if food is None:
        abort(400)
    item = (FoodInCart.query
            .filter(FoodInCart.id_user == g.user_id)
            .filter(FoodInCart.id_food == food_id)
            .first())
    if not item:
        abort(400)
    db.session.delete(item)
    db.session.commit()
    return redirect('/shopping-cart')


@app.route('/update-cart', methods=['POST'])
def update_cart():
    for food_id, qty in request.form.items():
        qty = int(qty)
        food = Food.query.filter_by(id=food_id).first()
        if food is None:
            abort(400)
        item = FoodInCart.query.filter_by(id_food=food_id).filter_by(id_user=g.user_id).first()
        if item is None:
            abort(400)
        if qty == 0:
            db.session.delete(item)
        elif qty > 0:
            item.qty = qty
    db.session.commit()
    return redirect('/shopping-cart')


@app.route('/shopping-cart')
def show_cart():
    items, total = get_cart_info(g.user_id)
    return render_template('shopping_cart.html', items=items, total=total)


@app.route('/checkout', methods=['POST', 'GET'])
def checkout():
    items, total = get_cart_info(g.user_id)
    if not items or total <= 0:
        abort(400)
    if request.method == 'GET':
        if g.user:
            user = User.query.filter_by(id=g.user_id).first()
            return render_template('checkout.html', items=items, total=total, user=user)
        else:
            return render_template('checkout.html', items=items, total=total)
    email = request.form['email']
    phone = request.form['phone']
    name = request.form['name']
    surname = request.form['surname']
    address = request.form['address']
    postcode = request.form['postcode']
    city = request.form['city']
    if None in (email, phone, name, surname, address, postcode, city):
        abort(400)
    if g.user_id < 0:
        id_user = None
    else:
        id_user = g.user_id
    new_order = Order(
        status="Created",
        order_time=time.time(),
        name=name,
        surname=surname,
        address=address,
        postcode=postcode,
        city=city,
        phone=phone,
        email=email,
        id_user=id_user,
        id_driver=None
    )
    db.session.add(new_order)
    db.session.commit()
    for food, item in items:
        new_food_in_order = FoodInOrder(
            id_food=food.id,
            id_order=new_order.id,
            qty=item.qty
        )
        db.session.add(new_food_in_order)
    FoodInCart.query.filter_by(id_user=g.user_id).delete()
    db.session.commit()
    return redirect("/")


@app.route('/profile')
def show_profile():
    if not g.user:
        return redirect('/login')
    user, role, items = get_profile_info()
    return render_template('profile.html', user=user, role=role, orders=items)


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
        if id == g.user_id:
            return render_template('error.html', name="Edit error", desc="You cannot delete yourself!")
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
            new_canteen = Canteen(name=name, address=address, description=description, img_src='https://via.placeholder.com/150')
            db.session.add(new_canteen)
            db.session.commit()
            return render_template('all_done.html', desc="New canteen added.")
        else:
            operators = User.query.filter(User.id == Operator.id).all()
            return render_template('add_canteen.html', operators=operators)
    return redirect('/login')


@app.route('/edit_canteen_picture/<int:id_canteen>', methods=['POST', 'GET'])
def edit_canteen_picture(id_canteen):
    if g.operator or g.admin:
        canteen = Canteen.query.filter(Canteen.id == id_canteen).first()
        if request.method == 'POST':
            file = request.form['source']
            canteen.img_src = file
            db.session.commit()
            return render_template('edit_canteen_picture.html', canteen=canteen)
        else:
            return render_template('edit_canteen_picture.html', canteen=canteen)


@app.route('/manage_canteen')
def manage_canteen():
    if g.operator or g.admin:
        canteens = Canteen.query.all()
        return render_template('manage_canteen.html', canteens=canteens)
    else:
        return redirect('/login')


@app.route('/manage_orders')
def manage_orders():
    if not g.user:
        return redirect('/login')
    if not g.operator or g.admin:
        abort(401)
    items, driver_list = get_all_orders_info()
    return render_template('manage_orders.html', items=items, driver_list=driver_list)


@app.route('/update-order', methods=['POST'])
def update_order():
    if not g.user:
        return redirect('/login')
    if not g.operator or g.admin:
        abort(401)
    try:
        order_id = int(request.form['order_id'])
        order = Order.query.filter_by(id=order_id).first()
    except KeyError:
        abort(400)
    try:
        driver_id = int(request.form['driver_id'])
        if driver_id >= 0:
            order.id_driver = driver_id
        else:
            order.id_driver = None
    except KeyError:
        pass
    try:
        status = request.form['status']
        if status not in ("Created", "Confirmed", "En route", "Delivered", "Canceled"):
            abort(400)
        order.status = status
    except KeyError:
        pass
    try:
        email = request.form['email']
        phone = request.form['phone']
        name = request.form['name']
        surname = request.form['surname']
        address = request.form['address']
        postcode = request.form['postcode']
        city = request.form['city']
        if None in (email, phone, name, surname, address, postcode, city):
            abort(400)
        order = Order.query.filter_by(id=order_id).first()
        order.email = email
        order.phone = phone
        order.name = name
        order.surname = surname
        order.address = address
        order.postcode = postcode
        order.city = city
    except KeyError:
        abort(400)
    db.session.commit()
    return redirect('/manage_orders')


@app.route('/view-order')
def show_order():
    if not g.user:
        return redirect('/login')
    order_id = int(request.args.get('id'))
    if not g.operator and not g.admin:
        order = Order.query.filter_by(id_user=g.user_id).filter_by(id=order_id).first()
        if order is None:
            abort(401)
    items, price = get_order_info(order_id)
    if not items or price <= 0:
        abort(400)
    edit = request.args.get('edit') is not None
    order = Order.query.filter_by(id=order_id).first()
    if g.operator or g.admin:
        return render_template('view-order.html', order_id=order_id, items=items, total=price, order=order, edit=edit, locked=False)
    else:
        return render_template('view-order.html', order_id=order_id, items=items, total=price, order=order, edit=edit, locked=True)


@app.route('/add_item', methods=['POST', 'GET'])
def add_item():
    if g.operator or g.admin:
        if request.method == 'POST':
            name = request.form['name']
            type = request.form['type']
            description = request.form['description']
            alergens = request.form['alergens']
            price = float(request.form['price'])
            
            new_item = Food(name=name, type=type, description=description, allergens=alergens, price=price)
            db.session.add(new_item)
            db.session.commit()
            
            return render_template('all_done.html', desc="New item aded")
            
        else:
            return render_template('add_item.html')
        
    return redirect('/login')


@app.route('/manage_items', methods=['GET', 'POST'])
def manage_items():
    if g.operator or g.admin:
        items = Food.query.all()
        return render_template('manage_items.html', items=items)
    else:
        return redirect('/login')


@app.route('/remove_canteen/<int:canteen_id>')
def remove_canteen(canteen_id):
    if g.operator or g.admin:
        canteen = Canteen.query.filter(Canteen.id == canteen_id).first()
        db.session.delete(canteen)
        db.session.commit()
        
        return render_template('all_done.html', desc="Canteen removed")
        
    return redirect('/login')


@app.route('/remove_item/<int:id>')
def remove_item(id):
    if g.operator or g.admin:
        item = Food.query.filter(Food.id == id).first()
        db.session.delete(item)
        db.session.commit()

        return render_template('all_done.html', desc="Item removed")

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
