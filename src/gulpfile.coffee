do ->
  'use strict'
  
  gulp         = require 'gulp'
  gutil        = require 'gulp-util'
  plumber      = require 'gulp-plumber'
  connect      = require 'gulp-connect'
  coffee       = require 'gulp-coffee'
  sass         = require 'gulp-sass'
  concat       = require 'gulp-concat'
  uglify       = require 'gulp-uglify'
  minifyCSS    = require 'gulp-minify-css'
  sourcemaps   = require 'gulp-sourcemaps'
  autoprefixer = require 'gulp-autoprefixer'

  gulp.task 'connect', ->
    connect.server
      root: '../dist'
      livereload: true
    return
  
  gulp.task 'html', ->
    gulp.src('*.html')
      .pipe(gulp.dest('../dist'))
      .pipe connect.reload()
  
  gulp.task 'sass', ->
    gulp.src('styles/*.sass')
      .pipe(sourcemaps.init())
      .pipe(sass(
        indentedSyntax: true
        errLogToConsole: true
      )).on('error', gutil.log)
      .pipe(autoprefixer({
        browsers: ['last 2 versions']
      }))
      .pipe(minifyCSS()).on('error', gutil.log)
      .pipe(sourcemaps.write('.'))
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
    gulp.watch [ 'styles/*.sass', 'styles/*/*.sass' ], [ 'sass' ]
    gulp.watch [ 'js/*.js' ], [ 'js' ]
    gulp.watch [ 'coffee/*.coffee' ], [ 'coffeeTask' ]
    return
  
  gulp.task 'default', [
    'connect'
    'watch'
  ]
  return
