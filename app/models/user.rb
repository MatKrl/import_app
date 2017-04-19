class User < ApplicationRecord
  has_many :playlists

  def self.import
    require 'csv'
    csv_text = File.read( Rails.root.join('data', 'user_data.csv') )
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      begin
        User.create!(row.to_hash)
      rescue => error
        Rails.logger.info "User:Import:Error: #{error}"
      end
    end
  end
end
