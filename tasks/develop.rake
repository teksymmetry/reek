require 'rake/clean'
require 'reek/smells/smells'
require 'yaml'

CONFIG_DIR = 'config'
CONFIG_FILE = "#{CONFIG_DIR}/defaults.reek"

CLOBBER.include(CONFIG_DIR)

directory CONFIG_DIR

file CONFIG_FILE => [CONFIG_DIR] do
  config = {}
  Reek::SmellConfig::SMELL_CLASSES.each do |klass|
    config[klass.name.split(/::/)[-1]] = klass.default_config
  end
  $stderr.puts "Creating #{CONFIG_FILE}"
  File.open(CONFIG_FILE, 'w') { |f| YAML.dump(config, f) }
end

task CONFIG_FILE => FileList['lib/reek/smells/*.rb']

task 'rspec:fast' => [CONFIG_FILE]
task 'rspec:all' => [CONFIG_FILE]
task 'reek' => [CONFIG_FILE]
task 'check_manifest' => [CONFIG_FILE]
