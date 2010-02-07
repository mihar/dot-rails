# Truncate the nasty big default README file.
run "echo 'Comming soon' > README"

# Have our bit of gem.
gem 'haml'
gem 'RedCloth'
gem 'resource_controller'
gem 'will_paginate'
rake "gems:install", :sudo => true

# Install HAML and SASS
run "haml --rails ."
run "mkdir public/stylesheets/sass"

# Get the standardista
plugin "standardista", :git => "git://github.com/mislav/standardista.git"

# RSpec question.
if yes?("Do you want to use RSpec?")
  plugin "rspec", :git => "git://github.com/dchelimsky/rspec.git"
  plugin "rspec-rails", :git => "git://github.com/dchelimsky/rspec-rails.git"
  generate :rspec
end

# Setup Git.
git :init
file ".gitignore", <<-END
.DS_Store
.eprj
config/initializers/gmaps.rb
log/*.log
tmp/**/*
nbproject
config/database.yml
db/*.sqlite3
END
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

# Generate the static pages controller and setup the root.
generate :controller, "pages index"
route "map.root :controller => :pages"
run "rm public/index.html"

# Generate the standard layout.
generate :layout

# Finally add to repo and commit.
git :add => "."
git :commit => "-m 'Initial import.'"