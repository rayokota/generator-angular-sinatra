'use strict';
var util = require('util'),
    path = require('path'),
    yeoman = require('yeoman-generator'),
    _ = require('lodash'),
    _s = require('underscore.string'),
    pluralize = require('pluralize'),
    asciify = require('asciify');

var AngularSinatraGenerator = module.exports = function AngularSinatraGenerator(args, options, config) {
  yeoman.generators.Base.apply(this, arguments);

  this.on('end', function () {
    this.installDependencies({ skipInstall: options['skip-install'] });
    if (!options['skip-install']) {
      return this.spawnCommand('bundle', ['install']);
    }
  });

  this.pkg = JSON.parse(this.readFileAsString(path.join(__dirname, '../package.json')));
};

util.inherits(AngularSinatraGenerator, yeoman.generators.Base);

AngularSinatraGenerator.prototype.askFor = function askFor() {

  var cb = this.async();

  console.log('\n' +
    '+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+\n' +
    '|a|n|g|u|l|a|r| |s|i|n|a|t|r|a| |g|e|n|e|r|a|t|o|r|\n' +
    '+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+\n' +
    '\n');

  var prompts = [{
    type: 'input',
    name: 'baseName',
    message: 'What is the name of your application?',
    default: 'myapp'
  },
  {
    type: 'list',
    name: 'orm',
    message: 'Which object-relational mapper would you like to use?',
    choices: ['ActiveRecord', 'DataMapper'],
    default: 'ActiveRecord'
  }];

  this.prompt(prompts, function (props) {
    this.baseName = props.baseName;
    this.orm = props.orm == 'ActiveRecord' ? 'ar' : 'dm';

    cb();
  }.bind(this));
};

AngularSinatraGenerator.prototype.app = function app() {

  this.entities = [];
  this.resources = [];
  this.generatorConfig = {
    "baseName": this.baseName,
    "orm": this.orm,
    "entities": this.entities,
    "resources": this.resources
  };
  this.generatorConfigStr = JSON.stringify(this.generatorConfig, null, '\t');

  this.template('_generator.json', 'generator.json');
  this.template('_package.json', 'package.json');
  this.template('_bower.json', 'bower.json');
  this.template('bowerrc', '.bowerrc');
  this.template('Gruntfile.js', 'Gruntfile.js');
  this.copy('gitignore', '.gitignore');

  var dbDir = 'db/'
  var dbMigrateDir = dbDir + 'migrate/'
  var helpersDir = 'helpers/'
  var modelsDir = 'models/'
  var publicDir = 'public/'
  var routesDir = 'routes/'
  var viewsDir = 'views/'
  this.mkdir(dbDir);
  this.mkdir(dbMigrateDir);
  this.mkdir(helpersDir);
  this.mkdir(modelsDir);
  this.mkdir(publicDir);
  this.mkdir(routesDir);
  this.mkdir(viewsDir);

  this.copy('Gemfile_' + this.orm, 'Gemfile');
  this.copy('Rakefile_' + this.orm, 'Rakefile');
  this.template('_app_' + this.orm + '.rb', 'app.rb');
  this.template('_config.ru', 'config.ru');
  this.template('helpers/_init.rb', helpersDir + 'init.rb');
  this.template('helpers/_response_format.rb', helpersDir + 'response_format.rb');
  this.template('models/_init.rb', modelsDir + 'init.rb');
  this.template('routes/_init.rb', routesDir + 'init.rb');
  this.template('routes/_index.rb', routesDir + 'index.rb');

  var publicCssDir = publicDir + 'css/';
  var publicJsDir = publicDir + 'js/';
  var publicViewDir = publicDir + 'views/';
  this.mkdir(publicCssDir);
  this.mkdir(publicJsDir);
  this.mkdir(publicViewDir);
  this.template('public/_index.html', publicDir + 'index.html');
  this.copy('public/css/app.css', publicCssDir + 'app.css');
  this.template('public/js/_app.js', publicJsDir + 'app.js');
  this.template('public/js/home/_home-controller.js', publicJsDir + 'home/home-controller.js');
  this.template('public/views/home/_home.html', publicViewDir + 'home/home.html');
};

AngularSinatraGenerator.prototype.projectfiles = function projectfiles() {
  this.copy('editorconfig', '.editorconfig');
  this.copy('jshintrc', '.jshintrc');
};
