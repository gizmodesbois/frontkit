// Note the new way of requesting CoffeeScript since 1.7.x
require('coffee-script/register');
var gutil = require('gulp-util');
var gulpfile = 'Gulpfile.coffee'
// This bootstraps your Gulp's main file
require('./'+gulpfile);