'use strict'

gulp = require 'gulp'
runs = require 'run-sequence'
$ = require('gulp-load-plugins')()
minifyCSS = require 'gulp-minify-css'
production = true if $.util.env.env is 'production'
filename = require('uuid').v4()
lazypipe = require 'lazypipe'
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
    .pipe $.if !production, $.changed paths.test,
      extension: '.js'
    .pipe $.coffee, bare: true
    .pipe gulp.dest paths.test

gulp.task 'html', ->
  gulp.src paths.src + '/*.html'
    .pipe $.useref.assets()
    # Concatenate And Minify JavaScript
    .pipe $.if '*.js', $.uglify()
    .pipe $.useref.restore()
    .pipe $.useref()
    # Concatenate And Minify Styles
    .pipe $.if '*.css', $.csso()
    .pipe $.useref.restore()
    .pipe $.useref()
    .pipe $.if '*.html', $.htmlmin
      removeComments: true
      collapseWhitespace: true
    .pipe gulp.dest paths.dist

# Clean
gulp.task 'clean', require('del').bind null, [
    paths.dist
  ]

# Images
gulp.task 'images', ->
  gulp.src paths.images + '/**/*.{jpg,jpeg,png,gif}'
    .pipe $.if production, $.changed paths.dist + '/assets/images'
    .pipe $.if production, $.cache $.imagemin
      progressive: true
      interlaced: true
    .pipe $.if production, gulp.dest paths.dist + '/assets/images'

# testing via mocha tool
gulp.task 'test', ->
  gulp.src paths.test + '/test.js'
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
  gulp.watch paths.images + '/**/*.{jpg,jpeg,png,gif}', ['images', reload]
  gulp.watch paths.script + '/**/*.js', reload
  gulp.watch paths.css + '/**/*.css', reload

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
