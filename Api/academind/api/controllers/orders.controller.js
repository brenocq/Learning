const pg = require('pg');

const pool = new pg.Pool({
	host: '??',
	port: '??',
	user: '??',
	password: '??',
	database: '??'
})

const getOrders = async (req, res, next) => {
	const response = await pool.query('select * from producer');
	console.log(response.rows);
	res.status(200).json({
		message: "Some get method!",
		database: response.rows
	});
}

const postOrders = async (req, res, next) => {
	const producer = {
		name: req.body.name,
		email: req.body.email
	};
	const now = new Date().toISOString();
	const response = await pool.query('INSERT INTO producer (name, email, creation) VALUES ($1,$2,$3) RETURNING id', [producer.name, producer.email, now]);
	console.log(response)
	res.status(200).json({
		message: "Producer created!"
	});
}

module.exports = {
	getOrders,
	postOrders
}
