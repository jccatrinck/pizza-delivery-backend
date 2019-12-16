const {
  db,
  getProducts
} = require('../db/db')

class ProductsController {

  async get(req, res, next) {
    try {
      let result = await db.query(getProducts())
      res.json(result.rows)   
    } catch (err) {
      return next(err)        
    }
  }

}

module.exports = new ProductsController()