class Song < ApplicationRecord
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  def self.import
    require 'csv'
    csv_text = File.read( Rails.root.join('data', 'mp3_data.csv') )
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      begin
        song = Song.new
        song.id = row['ID']
        song.title = row['Title']
        song.interpret = row['Interpret']
        song.album = row['Album']
        song.track = row['track']
        song.year = row['year']
        song.genre = row['genre']
        song.save!
      rescue => error
        Rails.logger.info "Song:Import:Error: #{error}"
      end
    end
  end
end
