namespace :twitter do
  desc "Find the most active user"
  task by_user: :environment do
    Twit.most_active_user.each do |twit|
      puts "@#{twit.screen_name} -> #{twit.total}"
    end
  end

  desc "Find total twits by hour"
  task by_hour: :environment do
    @twits = Twit.by_hour

    puts 'time  -> total'
    puts '--------------'
    @twits.each do |twit|
      puts "#{twit.hour.to_i}:00 -> #{twit.total}"
    end
  end

end
