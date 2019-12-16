const {
  db,
  postCustomer,
  postOrder,
  postOrderProduct,
  getOrderItems,
  getOrders,
  getOrderById,
  getProductId,
  getCustomerByName,
  putOrder,
  putOrderItem,
  deleteOrderItems,
  deleteOrder
} = require('../db/db')

class OrdersController {

  async post(req, res, next) {
    let {
      customerInfo: { name, address },
      itemList
    } = req.body

    try {
      await db.query('BEGIN')

      let result = await db.query(postCustomer({ name, address }))

      let customer = result.rows[0]

      if (!customer) return

      result = await db.query(postOrder({ customerId: customer.customer_id }))

      let order = result.rows[0]

      if (!order) return

      for (let i = 0; i < itemList.length; i++) {
        const { name, size, amount } = itemList[i]

        result = await db.query(getProductId({ name, size }))

        let product = result.rows[0]

        result = await db.query(postOrderProduct({
          orderId: order.order_id,
          productId: product.product_id,
          amount
        }))
      }

      await db.query('COMMIT')

      res.json(req.body)
    } catch (err) {
      next(err)
      await db.query('ROLLBACK')
      return
    }
  }

  async get(req, res, next) {
    const { orderId } = req.params

    try {
      if (orderId) {
        let result = await db.query(getOrderById({ orderId }))

        let order = result.rows[0]

        result = await db.query(getOrderItems({ orderId }))

        order.itemList = result.rows

        res.json(order || [])
      } else {
        let { rows: orders } = await db.query(getOrders())

        for (let i = 0; i < orders.length; i++) {
          const { rows } = await db.query(getOrderItems({ orderId: orders[i].orderId }))

          orders[i].itemList = rows
        }

        res.json(orders)
      }
    } catch (err) {
      return next(err)
    }
  }

  async put(req, res, next) {
    const { orderId, productId } = req.params
    let {
      status,
      itemList
    } = req.body


    try {
      let result = await db.query(putOrder({ orderId, status }))

      let order = result.rows[0]

      for (let i = 0; i < itemList.length; i++) {
        const { name, size } = itemList[i];        
        
        result = await db.query(getProductId({ name, size }))

        const { product_id: newProductId } = result.rows[0]

        await db.query(putOrderItem({ 
          orderId: order.orderId,
          productId,
          newProductId,
          amount
        }))
        
      }
    } catch (err) {
      return next(err)
    }



    res.json({})
  }

  async delete(req, res, next) {
    const { orderId } = req.params

    try {
      await db.query(deleteOrderItems({ orderId }))
      await db.query(deleteOrder({ orderId }))
    } catch (err) {
      return next(err)
    }

    res.json(true)
  }

}

module.exports = new OrdersController()