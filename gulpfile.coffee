gulp = require('gulp')
mocha = require('gulp-mocha')

gulp.task 'test', ->
  error = false
  gulp.src('./test.coffee').pipe(mocha()).on('error', ->
    console.log 'Tests failed!'
    error = true
  ).on 'end', ->
    if !error
      console.log 'Tests succeeded! Enter the below code:\n' +
        require('fs').readFileSync('./output.dat')
      # process.exit 0

gulp.task 'watch', ->
  gulp.watch [
    './test.coffee'
    './interface.coffee'
  ], [ 'test' ]
