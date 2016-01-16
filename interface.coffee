#  Inserts "doc" into the collection "movies".
exports.insert  = (db, doc, callback) ->
  db.collection('movies').insertOne doc, callback

# Finds all documents in the "movies" collection
# whose "director" field equals the given director,
# ordered by the movie's "title" field.
exports.byDirector = (db, director, callback) ->
  db.collection 'movies'
  .find director: director
  .sort title: 1
  .toArray callback
