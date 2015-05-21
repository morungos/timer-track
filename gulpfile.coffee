gulp =             require 'gulp'

mocha =            require 'gulp-mocha'
rename =           require 'gulp-rename'
sourcemaps =       require 'gulp-sourcemaps'

browserify =       require 'browserify'
coffeeify =        require 'coffeeify'
source =           require 'vinyl-source-stream'
buffer =           require 'vinyl-buffer'
del =              require 'del'

uglify =           require 'gulp-uglify'

gulp.task 'clean', (cb) ->
  del(['./lib'], cb)


gulp.task 'coffee', () ->

  b = browserify {
    entries: './src/timer-track'
    extensions: ['.coffee']
    debug: true
    standalone: 'TimerTrack'
    transform: [coffeeify]
  }

  b.bundle()
    .pipe source('timer-track.js')
    .pipe buffer()
    .pipe rename('timer-track.js')
    .pipe sourcemaps.init({loadMaps: true})
    .pipe sourcemaps.write('./')
    .pipe gulp.dest('./lib')


gulp.task 'test', ['coffee'], () ->
  gulp.src './test/**/*.*coffee'
    .pipe mocha({reporter: 'spec'})


gulp.task 'compress', ['coffee'], () ->
  gulp.src ['./lib/*.js', '!./lib/*.min.js']
    .pipe uglify()
    .pipe rename {extname: '.min.js'}
    .pipe gulp.dest './lib/'


gulp.task 'build', ['coffee', 'compress']