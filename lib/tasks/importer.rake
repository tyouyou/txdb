require 'csv'

namespace :importer do
  desc "TODO"
  task address: :environment do
    file = '/Users/zhangrong/Desktop/taxi-data/擬似データを作るためのデータ/Ootaku-address(revised).csv'
    CSV.table(file).each do |row|
      place = row[0]
      next if Address.find_by_place(place)
      longitude = row[1].to_f
      latitude = row[2].to_f
      address = Address.new
      address.place = place
      address.longitude = longitude
      address.latitude = latitude
      address.save
    end
  end

  task distance_and_time: :environment do
    file = '/Users/zhangrong/Desktop/taxi-data/擬似データの結果/EdogawaPseudoData.csv'
    addresses = []
    CSV.table(file).each do |row|
      start = row[1]
      destination = row[4]
      addresses << start
      addresses << destination
    end
    is_break = false
    addresses.each do |add1|
      addresses.each do |add2|
        p "#{add1}, #{add2}"
        resp = DistanceAndTime.fetch_and_create(add1, add2)
        if resp == false
          is_break = true
          break
        end
      end
      break if is_break
    end
  end
end
