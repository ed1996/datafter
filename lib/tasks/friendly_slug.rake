namespace :frirendly_slug do
  desc 'Generate slug firendly'

  task :message_slug do
    Message.find_each(&:save)
  end

  task :user_slug do
    User.find_each(&:save)
  end

  task :hommage_slug do
    Hommage.find_each(&:save)
  end
end