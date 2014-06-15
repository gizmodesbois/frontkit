gulp = require 'gulp'
config = require './config'
please = require 'gulp-pleeease'
clean = require 'gulp-clean'
notify = require 'gulp-notify'
spriteGenerator = require 'gulp-sprite-generator'

compass = require 'gulp-compass'
autoprefixer = require 'gulp-autoprefixer'
minifyCss = require 'gulp-minify-css'
jshint = require 'gulp-jshint'
imagemin = require 'gulp-imagemin'
concat = require 'gulp-concat'
cache = require 'gulp-cache'
livereload = require 'gulp-livereload'
rename = require 'gulp-rename'


# Directory Manipulation
gulp.task "clean", ->

# CSS Styles
gulp.task "styles", ->

# JS Scripts
gulp.task "scripts", ->

# Images
gulp.task "spriteGenerator", ->

gulp.task "images", ->


#Default task to launch gulp
gulp.task "default", ["clean"], ->
  gulp.start "styles", "scripts", "images"