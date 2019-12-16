const express = require('express')
const products = require('./controllers/products')
const orders = require('./controllers/orders')
const app = express()
const port = 3001

if (!process.env.NODE_ENV || process.env.NODE_ENV === 'development') {
  const cors = require('cors')
  
  var corsOptions = {
    origin: 'http://localhost:3000',
    optionsSuccessStatus: 200
  }

  app.use(cors(corsOptions))
}

app.use(express.json());

app.get('/products', products.get);

app.post('/orders', orders.post);
app.get('/orders', orders.get);
app.get('/orders/:orderId', orders.get);
app.put('/orders/:orderId/:productId', orders.put);
app.delete('/orders/:orderId', orders.delete);

app.listen(port, () => console.log(`Listening on port ${port}!`))

// Error handling middleware
app.use(function(err, req, res, next) {
  if (!err.statusCode) err.statusCode = 500;
  
  res.status(err.statusCode).send({
    error: 'An internal error ocurred'
  });

  //TO-DO: store error log
  console.error(err.message, err.stack)
});

process.on('uncaughtException', function(err) {
  //TO-DO: store exception log
  console.error(err.message)
});

process.on('unhandledRejection', function(reason, p){
  //TO-DO: store unhandled rejection log
  console.error(`unhandledRejection: ${reason}`)
});