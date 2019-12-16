const app = require('../api') // Link to your server file
const supertest = require('supertest')
const request = supertest(app)

it('gets the test endpoint', async done => {
  const response = await request.get('/orders')

  expect(response.status).toBe(200)
  expect(response.body.message).toBe('pass!')
  done()
})