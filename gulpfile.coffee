'use strict'

gulp = require 'gulp'
runs = require 'run-sequence'
$ = require('gulp-load-plugins')()
filename = require('uuid').v4()
browserSync = require 'browser-sync'
reload = browserSync.reload

paths =
  src: 'app'
  script: 'app/assets/js'
  css: 'app/assets/css'
  images: 'app/assets/images'
  test: 'test'
  dist: 'dist'
  vendor: 'app/assets/vendor'

gulp.task 'test_coffee', ->
  gulp.src paths.test + '/**/*.coffee'
    .pipe $.changed paths.test,
      extension: '.js'
    .pipe $.coffee bare: true
    .pipe gulp.dest paths.test

gulp.task 'html', ->
  assets = $.useref.assets()
  gulp.src paths.src + '/*.html'
    .pipe $.replace 'main.min', filename
    .pipe assets
    # Concatenate And Minify JavaScript
    .pipe $.if '*.js', $.uglify()
    # Concatenate And Minify Styles
    .pipe $.if '*.css', $.csso()
    .pipe assets.restore()
    .pipe $.useref()
    .pipe $.if '*.html', $.minifyHtml()
    .pipe gulp.dest paths.dist
    .pipe $.size title: 'html'

# Clean
gulp.task 'clean', require('del').bind null, [
    paths.dist
  ]

# Images
gulp.task 'images', ->
  gulp.src paths.images + '/**/*.{jpg,jpeg,png,gif}'
    .pipe $.changed paths.dist + '/assets/images'
    .pipe $.imagemin
      progressive: true
      interlaced: true
    .pipe gulp.dest paths.dist + '/assets/images'
    .pipe $.size title: 'images'

# testing via mocha tool
gulp.task 'test', ->
  gulp.src paths.test + '/**/*.js'
    .pipe $.mocha
      reporter: 'spec'

# Connect
gulp.task 'connect:app', ->
  browserSync
    notify: false
    server:
      baseDir: [paths.src]

  # run tasks automatically when files change
  gulp.watch paths.test + '/**/*.coffee', ['test_coffee']
  gulp.watch paths.src + '/*.html', reload
  gulp.watch paths.css + '/**/*.css', reload
  gulp.watch paths.images + '/**/*.{jpg,jpeg,png,gif}', reload
  gulp.watch paths.script + '/**/*.js', reload

# Connect
gulp.task 'connect:dist', ->
  browserSync
    notify: false
    server:
      baseDir: [paths.dist]

  gulp.watch paths.dist + '/**/*', reload

gulp.task 'copy', ->
  gulp.src [
    paths.src + '/favicon.ico'
    paths.src + '/robots.txt']
    .pipe gulp.dest paths.dist


# The default task (called when you run `gulp`)
gulp.task 'default', (cb) ->
  runs(
    'connect:app'
    cb)

# Build

gulp.task 'build', (cb) ->
  runs([
    'images'
    'copy']
    'html'
    cb)


gulp.task 'release', (cb) ->
  runs(
    ['build']
    cb)

module.exports = gulp
