namespace :data do

  desc "Importing Songs, Users and Playlists"
  task import: :environment do
    start_time = Time.now

    Song.import
    User.import
    Playlist.import

    puts "Finished in #{ (Time.now-start_time).round(2) }s"
  end

end
