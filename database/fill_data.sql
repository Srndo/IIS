/**************
 * Main tables
 **************/
INSERT INTO "canteen" ("id", "name", "address", "description", "img_src") VALUES
    ('0', 'Klub cestovatelů', 'Veleslavínova 183/14, 612 00 Brno', 'Oriental dishes from the whole Asia. Discover the taste of adventure with the Klub cestovatelů restaurant.', 'https://i.imgur.com/W2NhNwR.jpg'),
    ('1', 'Pizzeria Mozzarella', 'Kolejní 2905/2, 612 00 Brno-Královo Pole', 'Order some genuine italian pizza from Pizzeria Mozzarella.', 'https://i.imgur.com/mjy5rt7.jpg'),
    ('2', 'Everest', 'Veveří 61, 602 00 Brno-střed', 'Oriental dishes specially from the Nepal province are available in restaurant Everest.', 'https://i.imgur.com/qhNgPj8.jpg'),
    ('3', 'Pivní stáj', 'Veveří 38, 602 00 Brno-střed', 'The best burgers in South Moravian Region with great prices are available at Pivní stáj.', 'https://i.imgur.com/RX8fTFm.jpg'),
    ('4', 'Borgeska', 'Palackého tř. 285/47, 612 00 Brno-Královo Pole', 'Traditional czech dishes, menu and desserts from Borgeska restaurant.', 'https://i.imgur.com/42oGtPp.jpg'),
    ('5', 'U 3 opic', 'Palackého tř. 200/77, 612 00 Brno-Královo Pole', 'Traditional czech dishes directly to your home can be ordered from restaurant U 3 opic.', 'https://i.imgur.com/gSMIT7u.jpg');

INSERT INTO "food" ("id", "name", "type", "description", "allergens", "price", "id_canteen", "active") VALUES
    ('0', 'Veg Madras, Tomato soup', 'Lunch', 'Cooked vegetables with spicy sauce with naan.', '5, 6', '4.20', '0', '1'),
    ('1', 'Steak tartare, Vegetable soup', 'Lunch', 'Grind beef with spices.', '2, 4, 7', '3.80', '5', '1'),
    ('2', 'Hot wings, Mushroom soup', 'Lunch', 'Chicken wings with cheddar and cream mushroom soup.', '7, 9', '3.50', '5', '1'),
    ('3', 'Cordon bleu, Potato soup', 'Lunch', 'Chicken meat with ham and cheese and potato soup with cream.', '4, 8', '3.80', '5', '1'),
    ('4', 'Pulled beef hamburger with chips, Vegetable soup', 'Lunch', 'Home-made hamburger with honey dressing with vegetable soup.', '4, 9', '3.50', '4', '1'),
    ('5', 'Marinated salmon steak with ratatouille, Indian rice soup', 'Lunch', 'Salmon steak fried in butter with and Indian rice soup.', '9', '3.75', '0', '1'),
    ('6', 'Green Tikka, Garlic soup', 'Lunch', 'Very spicy chicken nuggets with strong garlic soup.', '7, 9', '3.75', '3', '1'),
    ('7', 'Pizza Grande pepperoni, french fries with tartar sauce', 'Lunch', 'Pizza with salami, mozzarella and tomato base.', '7, 6', '4.00', '1', '1'),
    ('8', 'Pizza Hawaii, french fries with honey sauce', 'Lunch', 'Pizza with pineapple, ham, mozzarella and tomato base.', '7, 6', '4.05', '1', '1'),
    ('9', 'Lamb Fal, Been soup', 'Lunch', 'Lamb nuggets with curry and been soup.', '7, 6', '4.05', '2', '1'),
    ('10', 'Texas hamburger with chips, Potato soup', 'Lunch', 'Beef hamburger with barbecue sauce and cheddar.', '5, 6', '4.70', '3', '1'),
    ('11', 'Panner Pakora, Dal Soup', 'Lunch', 'Fried indian cheese with gramflour combinated with Idian lentils soup.', '3, 7', '4.15', '2', '1'),
    ('12', 'Pizza Margherita, Tomato soup with cream', 'Lunch', 'Pizza with tomato sugo and mozzarella combined with tomato soup.', '5, 7', '4.90', '1', '1'),
    ('13', 'Kofola', 'Drink', 'Carbonated soft drink in 0.5 l bottle.', ' ', '1.00', '0', '1'),
    ('14', 'Strawberry Lemonade', 'Drink', 'Home-made refreshing combination of fresh strawberries, lemon juice and sugar.', '5', '1.70', '1', '1'),
    ('15', 'Lemon water', 'Drink', 'Water with sliced lemon pieces.', '5', '1.00', '3', '1'),
    ('16', 'Pepsi', 'Drink', 'Carbonated soft drink in 0.5 l bottle.', '7', '1.30', '4', '1'),
    ('17', 'Chickpeas soup', 'Soup', 'Legumes soup with potatoes and carrot.', '7, 9', '1.10', '0', '1'),
    ('18', 'Strong beef broth', 'Soup', 'Beef broth with vermicelli and root vegetables.', '7, 9', '1.20', '3', '1'),
    ('19', 'Potato soup', 'Soup', 'Home-made potato soup with boletus mushrooms and fresh marjoram.', '6, 9', '1.25', '4', '1'),
    ('20', 'Cabbage soup', 'Soup', 'Cabbage soup with chicken stock and fresh vegetables.', '6, 9', '1.30', '5', '1'),
    ('21', 'Pork chop', 'Meat', 'Juicy honey garlic pork chop with caramelised edges.', '5, 7', '5.15', '1', '1'),
    ('22', 'Schnitzels on a board', 'Meat', 'Traditional schnitzels served with spicy cheese and garlic sauce.', '2, 8', '5.40', '5', '1'),
    ('23', 'Flank steak', 'Meat', 'Steak with roasted green beans and bacon.', '2, 8', '4.80', '3', '1'),
    ('24', 'Marinated salmon', 'Meat', 'Marinated salmon steak in lime juice with herbs.', '4, 8', '5.50', '2', '1'),
    ('25', 'Jasmine rice', 'Side dish', 'Moist and soft Thailand rice.', ' ', '1.90', '1', '1'),
    ('26', 'Mashed potatoes with onion and bacon', 'Side dish', 'Potatoes bought from a local farmer with fresh onion and bacon.', '1', '1.80', '4', '1'),
    ('27', 'French fries', 'Side dish', 'Fries baked in oven.', '3', '1.50', '1', '1'),
    ('28', 'Egg Fried Rice', 'Side dish', 'Indian rice fried with eggs.', '3', '1.50', '2', '1'),
    ('29', 'Greek salad', 'Salad', 'Fresh and colorful greek salad.', '7', '3.80', '2', '1'),
    ('30', 'Caesar salad', 'Salad', 'Salad with chicken slices and toasted baguette.', '7', '3.95', '3', '1'),
    ('31', 'Chicken salad', 'Salad', 'Salad with roasted chicken pieces and mix of lettuce salads.', '9', '3.80', '3', '1'),
    ('32', 'Cheese salad', 'Salad', 'Salad with grilled goat cheese and honey dressing.', '9', '4.20', '5', '1');

INSERT INTO "order" ("id", "status", "order_time", "name", "surname", "address", "postcode", "city", "phone", "email", "id_user", "id_driver") VALUES
    ('0', 'Created', '20', 'Julia', 'Čermáková', 'Technická 1', '612 00', 'Brno-Královo pole', '+420 778 695 444', 'Julia.Cermakova@gmail.com', '3', NULL),
    ('1', 'Confirmed', '19', 'Julia', 'Čermáková', 'Technická 1', '612 00', 'Brno-Královo pole', '+420 778 695 444', 'Julia.Cermakova@gmail.com', '3', NULL),
    ('2', 'Confirmed', '18', 'Julia', 'Čermáková', 'Technická 1', '612 00', 'Brno-Královo pole', '+420 778 695 444', 'Julia.Cermakova@gmail.com', '3', '2'),
    ('3', 'En route', '17', 'Julia', 'Čermáková', 'Technická 1', '612 00', 'Brno-Královo pole', '+420 778 695 444', 'Julia.Cermakova@gmail.com', '3', '2'),
    ('4', 'Delivered', '16', 'Julia', 'Čermáková', 'Technická 1', '612 00', 'Brno-Královo pole', '+420 778 695 444', 'Julia.Cermakova@gmail.com', '3', '2'),
    ('5', 'Canceled', '15', 'Julia', 'Čermáková', 'Technická 1', '612 00', 'Brno-Královo pole', '+420 778 695 444', 'Julia.Cermakova@gmail.com', '3', NULL);


/************
 * Relations
 ************/
INSERT INTO food_in_order ("id_food", "id_order", "qty") VALUES
    ('0', '0', '1'),
    ('1', '0', '1'),
    ('2', '1', '2'),
    ('3', '2', '4'),
    ('4', '3', '1'),
    ('5', '4', '10'),
    ('6', '5', '1');


/**************
 * Usage roles
 **************/
INSERT INTO "user" ("id", "email", "password", "name", "surname", "address", "postcode", "city", "phone") VALUES
    ('0', 'admin@admin.com', '$5$rounds=535000$j5W2T2N2MrQLbrDU$rDX0Ht1e98BKpl4Lcimo5KUipz63Ml.XSaTj3rMCJE1', 'Leopold', 'Halaj', 'Záhřebská 97', '616 00', 'Brno-Žabovřesky', '+421 908 013 019'), /* password: admin */
    ('1', 'operator@operator.com', '$5$rounds=535000$Fwi7.92RJQj.Wqs0$4kq10RO7vEV3dldJHoOJ/qowpiT7W3t0fuPTScimx6D', 'Izabela', 'Sokolová', 'Vodova 61', '612 00', 'Brno-Královo pole', '+420 786 666 954'), /* password: operator */
    ('2', 'Andrej.Dolnik@gmail.com', '$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2', 'Andrej', 'Dolník', 'Reisigova 319', '612 00', 'Brno-Královo pole', '+421 958 658 489'),  /* password: asdfasdf */
    ('3', 'Julia.Cermakova@gmail.com', '$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2', 'Julia', 'Čermáková', 'Technická 1', '612 00', 'Brno-Královo pole', '+420 778 695 444'),  /* password: asdfasdf */
    ('4', 'david.silber@gmail.com', '$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2', 'David', 'Silber', 'Gorkého 42', '602 00', 'Brno-střed', '+421 569 863 457'),  /* password: asdfasdf */
    ('5', 'andrea.villova@gmail.com', '$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2', 'Andrea', 'Villová', 'Botanická 77', '602 00', 'Brno-střed', '+420 968 569 832');  /* password: asdfasdf */

INSERT INTO "driver" ("id") VALUES
    ('2');

INSERT INTO "operator" ("id") VALUES
    ('1');

INSERT INTO "admin" ("id") VALUES
    ('0'),
    ('4');
