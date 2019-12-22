/**************
 * Main tables
 **************/
INSERT INTO "canteen" ("id", "name", "address", "description", "img_src", "id_daily", "id_permanent") VALUES
    ('0', 'Klub cestovatelů', 'Veleslavínova 183/14, 612 00 Brno', 'Oriental dishes from the whole Asia. Discover the taste of adventure with the Klub cestovatelů restaurant.', 'https://i.imgur.com/W2NhNwR.jpg', '0', '0'),
    ('1', 'Pizzeria Mozzarella', 'Kolejní 2905/2, 612 00 Brno-Královo Pole', 'Order some genuine italian pizza from Pizzeria Mozzarella.', 'https://i.imgur.com/mjy5rt7.jpg', '1', '1'),
    ('2', 'Everest', 'Veveří 61, 602 00 Brno-střed', 'Oriental dishes specially from the Nepal province are available in restaurant Everest.', 'https://i.imgur.com/qhNgPj8.jpg', '2', '2');

INSERT INTO "daily_menu" ("id") VALUES
    ('0'),
    ('1'),
    ('2');

INSERT INTO "permanent_menu" ("id") VALUES
    ('0'),
    ('1'),
    ('2');

INSERT INTO "food" ("id", "name", "type", "description", "allergens", "price") VALUES
    ('0', 'Veg Madras, Tomato soup', 'LUNCH', 'Cooked vegetables with spicy sauce with naan.', '5, 6', '4.20'),
    ('1', 'Steak tartare, Vegetable soup', 'LUNCH', 'Grind beef with spices.', '2, 4, 7', '3.80'),
    ('2', 'Kofola', 'Drink', 'Carbonated soft drink in 0.5 l bottle.', ' ', '1.00'),
    ('3', 'Chickpeas soup', 'Soup', 'Legumes soup with potatoes and carrot.', '7, 9', '1.10'),
    ('4', 'Pork chop', 'Meat', 'Juicy honey garlic pork chop with caramelised edges.', '5, 7', '5.15'),
    ('5', 'Jasmine rice', 'Side dish', 'Moist and soft Thailand rice.', ' ', '1.90'),
    ('6', 'Greek salad', 'Salad', 'Fresh and colorful greek salad.', '7', '3.80');

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
INSERT INTO food_in_daily ("id_food", "id_daily") VALUES
    ('0', '0'),
    ('0', '1'),
    ('1', '2'),
    ('1', '0');

INSERT INTO food_in_permanent ("id_food", "id_permanent") VALUES
    ('2', '0'),
    ('3', '0'),
    ('4', '1'),
    ('5', '1'),
    ('6', '2');

INSERT INTO food_in_order ("id_food", "id_order") VALUES
    ('0', '0'),
    ('1', '0'),
    ('2', '1'),
    ('3', '2'),
    ('4', '3'),
    ('5', '4'),
    ('6', '5');


/**************
 * Usage roles
 **************/
INSERT INTO "user" ("id", "email", "password", "name", "surname", "address", "postcode", "city", "phone") VALUES
    ('0', 'admin@admin.com', '$5$rounds=535000$j5W2T2N2MrQLbrDU$rDX0Ht1e98BKpl4Lcimo5KUipz63Ml.XSaTj3rMCJE1', 'Leopold', 'Halaj', 'Záhřebská 97', '616 00', 'Brno-Žabovřesky', '+421 908 013 019'), /* password: admin */
    ('1', 'operator@operator.com', '$5$rounds=535000$Fwi7.92RJQj.Wqs0$4kq10RO7vEV3dldJHoOJ/qowpiT7W3t0fuPTScimx6D', 'Izabela', 'Sokolová', 'Vodova 61', '612 00', 'Brno-Královo pole', '+420 786 666 954'), /* password: operator */
    ('2', 'Andrej.Dolnik@gmail.com', '$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2', 'Andrej', 'Dolník', 'Reisigova 319', '612 00', 'Brno-Královo pole', '+421 958 658 489'),  /* password: asdfasdf */
    ('3', 'Julia.Cermakova@gmail.com', '$5$rounds=535000$fclrBT5bsouAbcjB$ielqqoZFgC7SP2v.ez7YlS1QE28IfjMavXLhc70FkY2', 'Julia', 'Čermáková', 'Technická 1', '612 00', 'Brno-Královo pole', '+420 778 695 444');  /* password: asdfasdf */

INSERT INTO "driver" ("id") VALUES
    ('2');

INSERT INTO "operator" ("id") VALUES
    ('1');

INSERT INTO "admin" ("id") VALUES
    ('0');

