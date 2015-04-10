do ->
  'use strict'
  
  gulp    = require('gulp')
  gutil   = require('gulp-util')
  plumber = require('gulp-plumber')
  connect = require('gulp-connect')
  coffee  = require('gulp-coffee')
  concat  = require('gulp-concat')
  uglify  = require('gulp-uglify')

  gulp.task 'connect', ->
    connect.server
      root: '../dist'
      livereload: true
    return
  
  gulp.task 'html', ->
    gulp.src('*.html')
      .pipe(gulp.dest('../dist'))
      .pipe connect.reload()
  
  gulp.task 'css', ->
    gulp.src('css/custom.css')
      .pipe(plumber())
      .pipe(gulp.dest('../dist/css'))
      .pipe connect.reload()
  
  gulp.task 'js', ->
    gulp.src('js/*.js')
      .pipe(plumber())
      .pipe(uglify())
      .pipe(gulp.dest('../dist/js'))
      .pipe connect.reload()
  
  gulp.task 'coffeeTask', ->
    gulp.src('./coffee/*.coffee')
      .pipe(plumber())
      .pipe(coffee({bare: true}).on('error', gutil.log))
      .pipe(concat('script.js'))
      .pipe(gulp.dest('./dev-js'))
      .pipe(uglify())
      .pipe(gulp.dest('../dist/js'))
      .pipe connect.reload()
  
  gulp.task 'watch', ->
    gulp.watch [ '*.html' ], [ 'html' ]
    gulp.watch [ 'css/custom.css' ], [ 'css' ]
    gulp.watch [ 'js/*.js' ], [ 'js' ]
    gulp.watch [ 'coffee/*.coffee' ], [ 'coffeeTask' ]
    return
  
  gulp.task 'default', [
    'connect'
    'watch'
  ]
  return
