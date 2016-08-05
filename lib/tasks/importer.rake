require 'csv'

namespace :importer do
  desc "TODO"
  task address: :environment do
    # sample:
    # place,longitude,latitude
    # "日本, 〒279-0032 千葉県浦安市千鳥１６",139.8877148,35.6075089
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
    # sample:
    # 出発時間,乗車地,乗車地の経度,乗車地の緯度,降車地,降車地の経度,降車地の緯度
    # 14:25,"日本, 〒132-0031 東京都江戸川区松島１丁目３−１１",139.8610594,35.7031413,"日本, 〒132-0022 東京都江戸川区大杉５丁目１８−１２",139.8780715,35.7104604
    file = '/Users/zhangrong/Desktop/taxi-data/擬似データの結果/OotakuPseudoData(40).csv'
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
