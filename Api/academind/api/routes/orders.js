const express = require('express');
const router = express.Router();
const { getOrders, postOrders } = require('../controllers/orders.controller')

router.get('/', getOrders);
router.post('/', postOrders);

router.get('/:orderId',(req, res, next) => {
	const id = req.params.orderId;
	if(id === 'special') {
		res.status(200).json({
			message: "A special id!!"
		});
	}else{
		res.status(200).json({
			message: "A id",
			id: id
		});
	}
});

router.patch('/:orderId',(req, res, next) => {
	const id = req.params.orderId;
	res.status(200).json({
		message: "Order updated!"
	});
});

router.delete('/:orderId',(req, res, next) => {
	const id = req.params.orderId;
	res.status(200).json({
		message: "Order deleted!"
	});
});

module.exports = router;
