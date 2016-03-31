require 'rails'

module Refresher
  class Railtie < Rails::Railtie
    railtie_name :refresher

    rake_tasks do
      load "tasks/db_refresher.rake"
    end
  end
end
