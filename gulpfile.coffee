gulp = require 'gulp'
config = require './config'
please = require 'gulp-pleeease'
clean = require 'gulp-clean'
notify = require 'gulp-notify'
spriteGenerator = require 'gulp-sprite-generator'

compass = require 'gulp-compass'
uglify = require 'gulp-uglify'
autoprefixer = require 'gulp-autoprefixer'
minifyCss = require 'gulp-minify-css'
jshint = require 'gulp-jshint'
imagemin = require 'gulp-imagemin'
concat = require 'gulp-concat'
cache = require 'gulp-cache'
livereload = require 'gulp-livereload'
rename = require 'gulp-rename'
connect = require 'gulp-connect'
lr = require 'tiny-lr'
server = lr()


# Directory Manipulation
gulp.task "clean", ->
    gulp.src([
        'public/assets/css'
        'public/assets/js'
        'public/assets/images'
    ],
            read: false
    ).pipe clean()

# CSS Styles
gulp.task "styles", ->
    gulp.src("src/assets/css/scss/screen.scss")
    .pipe compass(
        config_file: "src/assets/config.rb"
    )
    .pipe(autoprefixer("last 2 version", "safari 5", "ie 8", "ie 9", "opera 12.1", "ios 6", "android 4"))
    .pipe(gulp.dest("public/assets/css"))
    .pipe(rename(suffix: ".min"))
    .pipe(minifyCss())
    .pipe(gulp.dest("public/assets/css"))
    .pipe(livereload(server))
    .pipe notify(message: "Styles task complete")

# JS Scripts
gulp.task "scripts", ->
    gulp.src("src/assets/js/scripts/*.js")
    .pipe(jshint(".jshintrc"))
    .pipe(jshint.reporter("default"))
    .pipe(concat("main.js"))
    .pipe(gulp.dest("public/assets/scripts/js"))
    .pipe(rename(suffix: ".min"))
    .pipe(uglify())
    .pipe(gulp.dest("public/assets/js"))
    .pipe(livereload(server))
    .pipe notify(message: "Scripts task complete")

# Images

gulp.task "imageMin", ->
    gulp.src('src/assets/images/**/*').pipe(imagemin(
            optimizationLevel: 5
            progressive: true
            interlaced: true
    ))
    .pipe(gulp.dest('public/assets/images'))
    .pipe(livereload(server))
    .pipe(notify(message: "Image minification task complete"))

gulp.task "imageSprite", ->

gulp.task "images", ->
    gulp.start("imageMin")
    gulp.src('src/assets/images').pipe(notify(message: "Images task complete"))

#Watchers and servers

gulp.task "watch", ->
    # Watch .scss files
    gulp.watch "src/assets/css/scss/screen.scss", ["styles"]

    # Watch .js files
    gulp.watch "src/assets/js/scripts/**/*.js", ["scripts"]

    # Watch image files
    gulp.watch "src/assets/images/**/*", ["images"]

gulp.task "serverConnect", ->
    connect.server
        port: 4000
        root: "public"
        livereload: true



#Default task to launch gulp
gulp.task "default", ["clean"], ->
  gulp.start "styles", "scripts", "images"
  return

# Launch server
gulp.task "server", ["serverConnect","watch"]