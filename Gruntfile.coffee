module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-bower-cli'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  bower = 'bower_components'
  assets = 'app/assets'
  dist = 'dist'
  vendorFiles = [
    "#{bower}/jquery/dist/jquery.js"
    'node_modules/bootstrap-sass/assets/javascripts/bootstrap.js'
    "#{bower}/autoNumeric/autoNumeric.js"
    "#{bower}/spin.js/spin.js"
  ]

  grunt.initConfig
    copy:
      images:
        expand: true,
        flatten: true,
        src: ['images/*']
        dest: "#{dist}/images/"
      fonts:
        expand: true,
        flatten: true,
        src: ['fonts/*']
        dest: "#{dist}/fonts/"
    sass:
      options:
        compass: true
        loadPath: [
          'node_modules/bootstrap-sass/assets/stylesheets'
          'node_modules/font-awesome/scss'
        ]
      styles:
        expand: true
        cwd: "#{assets}/styles"
        src: ['*.scss']
        dest: dist
        ext: '.css'

    cssmin:
      styles:
        src: ["#{dist}/application.css"]
        dest: "#{dist}/application.min.css"

    coffee:
      compile:
        src: "#{assets}/scripts/**/*.coffee"
        dest: "#{dist}/application.js"

    uglify:
      vendor:
        src: vendorFiles
        dest: "#{dist}/vendor.min.js"

      scripts:
        options:
          banner: '"use strict";\n/* Created by Rudolf Kovalyov | <%= grunt.template.today("yyyy-mm-dd") %> */\n'
        src: "#{dist}/application.js"
        dest: "#{dist}/application.min.js"

    clean:
      dist: [dist]
      styles: ["#{dist}/application.css", "#{dist}/application.css.map"]
      scripts: ["#{dist}/application.js", "#{dist}/application.js.map"]

    watch:
      stylesheets:
        files: "#{assets}/styles/**"
        tasks: ['sass', 'cssmin:styles', 'clean:styles']
      scripts:
        files: "#{assets}/scripts/**"
        tasks: ['coffee', 'uglify:scripts', 'clean:scripts']


  grunt.registerTask 'build', [
    'clean:dist'
    'bower:install'
    'copy'
    'sass'
    'cssmin'
    'clean:styles'
    'coffee'
    'uglify'
    'clean:scripts'
  ]
  grunt.registerTask 'default', [
    'build'
    'watch'
  ]
