require 'csv'

namespace :exporter do
  desc "export all"
  task run: :environment do
    file = '/Users/zhangrong/Desktop/taxi-data/disance_and_time.csv'
    CSV.open(file, 'w') do |csv|
      csv << ['出発地', '目的地', '時間', '距離']
      DistanceAndTime.find_each do |dis_and_time|
        start = dis_and_time.start_address.place
        end_place = dis_and_time.end_address.place
        csv << [start, end_place, dis_and_time.cost_time, dis_and_time.distance]
      end
    end
  end
end
