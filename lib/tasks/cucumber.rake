if Rails.env.test? || Rails.env.development?
   require 'cucumber/rake/task'

   Cucumber::Rake::Task.new(:cucumber) do |t|
      t.cucumber_opts = "features --format pretty"
   end
end
