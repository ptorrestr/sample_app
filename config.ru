# This file is used by Rack-based servers to start the application.

map '/quiltro' do
  require ::File.expand_path('../config/environment',  __FILE__)
  run Rails.application
end
