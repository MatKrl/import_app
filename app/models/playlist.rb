class Playlist < ApplicationRecord
  belongs_to :user

  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  def self.import
    require 'csv'
    csv_text = File.read( Rails.root.join('data', 'playlist_data.csv') )
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      begin
        playlist = Playlist.new
        playlist.user_id = row['user_id']
        playlist.name = row['name']
        playlist.song_ids = row['mp3_ids']
        playlist.save!
      rescue => error
        Rails.logger.info "Playlist:Import:Error: #{error}"
      end
    end
  end
end
