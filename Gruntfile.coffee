"use strict"
LIVERELOAD_PORT = 35729
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)
mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt) ->
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    project:
      src: "./src"
      app: "./app"
      temp: "./temp"
      assets: "<%= project.app %>/assets"
      styles: "<%= project.src %>/styles"
      components: "<%= project.src %>/scripts/components/{,*/}*.coffee"
      plugins: "<%= project.src %>/scripts/plugins/{,*/}*.js"
      views: "<%= project.src %>/views/{,*/}*.html"

    tag:
      banner: "/*!\n" + " * <%= pkg.name %>\n" + " * <%= pkg.title %>\n" + " * @author <%= pkg.author %>\n" + " * <%= pkg.url %>\n" + " */\n"

    connect:
      options:
        port: 9000
        hostname: "127.0.0.1"

      livereload:
        options:
          middleware: (connect) ->
            [
              lrSnippet
              mountFolder(connect, "app")
            ]

    concat:
      plugins:
        src: ["<%= project.plugins %>"]
        dest: "<%= project.temp %>/temp-plugins.js"

      components:
        src: ["<%= project.components %>"]
        dest: "<%= project.temp %>/temp-components.coffee"

      styles:
        src: [
          "<%= project.styles %>/variables.styl"
          "<%= project.styles %>/mixins.styl"
          "<%= project.styles %>/sprite.styl"
          "<%= project.styles %>/reset/*.styl"
          "<%= project.styles %>/core/*.styl"
          "<%= project.styles %>/bootstrap-components/*.styl"
          "<%= project.styles %>/components/*.styl"
        ]
        dest: "<%= project.temp %>/temp-styles.styl"

      options:
        stripBanners: true
        nonull: true

    coffee:
      components:
        src: ["<%= concat.components.dest %>"]
        dest: "<%= project.temp %>/temp-components.js"

    uglify:
      plugins:
        src: ["<%= concat.plugins.dest %>"]
        dest: "<%= project.assets %>/js/<%= pkg.name %>-plugins.min.js"

      components:
        src: ["<%= coffee.components.dest %>"]
        dest: "<%= project.assets %>/js/<%= pkg.name %>-components.min.js"

      options:
        sourceMap: yes

    stylus:
      styles:
        src: ["<%= concat.styles.dest %>"]
        dest: "<%= project.temp %>/temp-styles.css"

        options:
          paths: [
            "<%= project.assets %>/css/"
            "<%= project.assets %>/fonts/"
            "<%= project.assets %>/img/"
          ]
          compress: no
          urlfunc: "data"

    autoprefixer:
      styles:
        src: ["<%= stylus.styles.dest %>"]
        dest: "<%= project.assets %>/css/<%= pkg.name %>-styles.css"

        options:
          browsers: [
            "last 2 version"
            "ie 9"
          ]

    cssmin:
      styles:
        cwd: "<%= project.assets %>/css"
        src: ["<%= pkg.name %>-styles.css"]
        dest: "<%= project.assets %>/css/"
        ext: ".min.css"
        expand: true

    includes:
      files:
        cwd: "<%= project.src %>/views"
        src: ["*.html"]
        dest: "<%= project.app %>"
        options:
          flatten: true
          silent: true
          filenameSuffix: ".html"


    sprite:
      icons:
        src: ['<%= project.assets %>/img/icons/*.png']
        destImg: '<%= project.assets %>/img/<%= pkg.name %>-icons.png'
        destCSS: '<%= project.styles %>/sprite.styl'
        imgPath: '../img/<%= pkg.name %>-icons.png'
        algorithm: 'binary-tree'
        padding: 2
        engine: 'pngsmith'
        cssFormat: 'stylus'


    open:
      server:
        path: "http://localhost:<%= connect.options.port %>"

    watch:
      stylus:
        files: "<%= project.styles %>/{,*/}*.styl"
        tasks: ["process-styles"]

      plugins:
        files: "<%= project.plugins %>"
        tasks: ["process-plugins"]

      components:
        files: "<%= project.components %>"
        tasks: ["process-components"]

      includes:
        files: "<%= project.views %>"
        tasks: ["process-html"]

      icons:
        files: '<%= sprite.icons.src %>'
        tasks: ['make-sprite']

      livereload:
        options:
          livereload: LIVERELOAD_PORT

        files: ["<%= project.app %>/**"]

  grunt.registerTask "process-html", [
    "includes"
  ]
  grunt.registerTask "process-styles", [
    "concat:styles"
    "stylus"
    "autoprefixer"
    "cssmin"
  ]
  grunt.registerTask "process-plugins", [
    "concat:plugins"
    "uglify:plugins"
  ]
  grunt.registerTask "process-components", [
    "concat:components"
    "coffee"
    "uglify:components"
  ]
  grunt.registerTask "make-sprite", [
    "sprite"
  ]

  grunt.registerTask "build", [
    "concat"
    "process-styles"
    "process-html"
    "process-plugins"
    "process-components"
    "make-sprite"
  ]
  grunt.registerTask "default", ["build"]
  grunt.registerTask "server", [
    "build"
    "connect:livereload"
    "open"
    "watch"
  ]
  return