class Cukigem
  class << self
    attr_accessor :project_root, :temp_root, :application_name, :paths_to_clear

    def app_root
      File.join(temp_root, application_name)
    end
  end

  self.project_root = File.expand_path(File.join(File.dirname(__FILE__), '..', '..')).freeze
  #Now, below I'm referencing to a symbolic link, outside of the rails application.
  self.temp_root = File.join(project_root, "../non_rails_tmp").freeze
  self.application_name = "rails_app".freeze

  self.paths_to_clear = %w[
      "db/*.sqlite3",
      "db/migrate/*.rb",
      "app/views/**",
      "app/controllers/**",
      "app/helpers/**",
      "app/models/**",
      "vendor/plugins/**",
      "public/images/**",
      "public/stylesheets/**"
  ]
end
