const express = require('express');
const app = express();
const morgan = require('morgan');
const bodyParser = require('body-parser');

const productsRoutes = require('./api/routes/products')
const ordersRoutes = require('./api/routes/orders')

app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

// Allow access
app.use((req, res, next) => {
	res.header('Access-Control-Allow-Origin','*');
	res.header('Access-Control-Allow-Headers','*');

	if(req.method === 'OPTIONS') {
		res.header('Access-Control-Allow-Headers', 'GET, PUT, POST, PATCH, DELETE');
		return res.status(200).json({});
	}
	next();
});

// Routes
app.use('/products', productsRoutes);
app.use('/orders', ordersRoutes);

// Error handling
app.use((req, res, next) => {
	const error = new Error('Not found');
	error.status = 404;
	next(error);
});

app.use((error, req, res, next) => {
	res.status(error.status || 500);
	res.json({
		error: {
			message: error.message
		}
	});
});

module.exports = app;
