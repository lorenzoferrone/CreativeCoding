var gulp = require('gulp')
var watch = require('gulp-watch')
var rapyd = require('gulp-rapyd');


var path = 'src/**/*.py'

// Compile every pyj file and put the resulting js files in a rapyd/ directory:
gulp.task('default', function() {
    gulp.src(path)
        .pipe(watch(path))
        .pipe(rapyd({bare: true, es6: true}).on('error', function(e){console.log(e)}))
        .pipe(gulp.dest('app/'))
});
