mongodb = require('mongodb')
uri = 'mongodb://localhost:27017/movies'

module.exports = (callback) ->
  mongodb.MongoClient.connect uri, callback
