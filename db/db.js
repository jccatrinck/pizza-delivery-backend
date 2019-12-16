const pg = require('pg');
const sql = require('yesql')('db/sql/',  {type: 'pg'})
const { isProduction } = require('../helpers')
const hostname = isProduction ? 'db' : 'localhost'
const password = isProduction ? process.env.POSTGRES_PASSWORD : 'mypassword'
const conString = `postgres://postgres:${password}@${hostname}:5432/pizza_delivery`;
//process.env.PG_CONN_STRING
const client = new pg.Client(conString);
client.connect();

module.exports = {
  isProduction,
  db: client,
  ...sql
}