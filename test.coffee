require 'coffee-script/register'
assert = require('assert')
connect = require('./connect')
dbInterface = require('./interface')
fs = require('fs')
movies = require('./movies')

#  This test suite is meant to be run through gulp (use the `npm run watch`)
#  script. It will provide you useful feedback while filling out the API in
#  `interface.coffee`. You should **not** modify any of the below code.
describe 'dbInterface', ->
  db = undefined
  succeeded = 0
  georgeLucasMovies = undefined

  #  This test ensures that interface.coffee'
  # `insert()` function properly inserts
  #  a document into the "movies" collection.
  it 'can insert a movie', (done) ->
    doc =
      title: 'Rogue One'
      year: 2016
      director: 'Gareth Edwards'
    dbInterface.insert db, doc, (error) ->
      assert.ifError error
      db.collection('movies').count { title: 'Rogue One' }, (error, c) ->
        assert.ifError error
        assert.equal c, 1
        done()
        return
      return
    return

  #  This test ensures that interface.coffee' `byDirector()` function can load a
  #  single document.
  it 'can query data by director', (done) ->
    dbInterface.byDirector db, 'Irvin Kershner', (error, docs) ->
      assert.ifError error
      assert.ok Array.isArray(docs)
      assert.equal docs.length, 1
      assert.equal docs[0].title, 'The Empire Strikes Back'
      ++succeeded
      done()
      return
    return

  #  This test ensures that interface.coffee' `byDirector()` function loads
  #  movies in ascending order by their title. That is, "Attack of the Clones"
  #  comes before "The Phantom Menace", at least in lexicographic order.
  it 'returns multiple results ordered by title', (done) ->
    dbInterface.byDirector db, 'George Lucas', (error, docs) ->
      assert.ifError error
      assert.ok Array.isArray(docs)
      assert.equal docs.length, 4
      assert.equal docs[0].title, 'Attack of the Clones'
      assert.equal docs[1].title, 'Revenge of the Sith'
      assert.equal docs[2].title, 'Star Wars'
      assert.equal docs[3].title, 'The Phantom Menace'
      docs.forEach (doc) ->
        delete doc._id
        return
      assert.deepEqual Object.keys(docs[0]), [
        'title'
        'year'
        'director'
      ]
      ++succeeded
      georgeLucasMovies = docs
      done()
      return
    return

  #  This function does some basic setup work to make sure you have the correct
  #  data in your "movies" collection.
  before (done) ->
    connect (error, conn) ->
      if error
        return done(error)
      db = conn
      db.collection('movies').remove {}, (error) ->
        if error
          return done(error)
        fns = []
        movies.movies.forEach (movie) ->
          fns.push (callback) ->
            dbInterface.insert db, movie, callback
            return
          return
        require('async').parallel fns, done
        return
      return
    return

  #  The below code generates the answer code that we will use to
  #  verify you got the correct answer. Modifying this code is a
  #  violation of the honor code.
  after (done) ->
    if succeeded >= 2
      _0xc3a0 = [
        'test'
        'length'
        './output.dat'
        'the mean stack awakens'
        'writeFileSync'
        'fs'
      ]
      x = {}
      x[_0xc3a0[0]] = georgeLucasMovies[_0xc3a0[1]]
      require(_0xc3a0[5])[_0xc3a0[4]] _0xc3a0[2],
        x[_0xc3a0[0]] == 4 and _0xc3a0[3]
      db.close done
    else
      db.close done
    return
  return
