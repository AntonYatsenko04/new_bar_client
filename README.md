menu item
    name
    description
    price

order
    List<MenuItem>
    table No
    price
    waiter id
    cook id
    status: taken, in cooking, pending payment, complete

waiter
    name

cook
    name

manager
    name


roles:
    manager
        CRUD for menu, order, broadcast, waiter, cook
	waiter
		CRUD for orders
	cook
		RU for orders (assign order to self)