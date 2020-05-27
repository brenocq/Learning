const express = require('express');
const router = express.Router();

router.get('/',(req, res, next) => {
	res.status(200).json({
		message: "Some get method"
	});
});

router.post('/',(req, res, next) => {
	const product = {
		name: req.body.name,
		price: req.body.price
	};
	res.status(201).json({
		message: "Some post method",
		createdProduct: product
	});
});

router.get('/:productId',(req, res, next) => {
	const id = req.params.productId;
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

router.patch('/:productId',(req, res, next) => {
	const id = req.params.productId;
	res.status(200).json({
		message: "Product updated!"
	});
});

router.delete('/:productId',(req, res, next) => {
	const id = req.params.productId;
	res.status(200).json({
		message: "Product deleted!"
	});
});

module.exports = router;
