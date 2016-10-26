class DistanceAndTime < ActiveRecord::Base
  belongs_to :start_address, class_name: 'Address', foreign_key: 'start_id'
  belongs_to :end_address, class_name: 'Address', foreign_key: 'end_id'

  class << self
    def fetch_and_create(start_string, destination_string)
      start = Address.find_by_place(start_string)
      if start.nil?
        p "can't find #{start_string}"
        return false
      end
      destination = Address.find_by_place(destination_string)
      if destination.nil?
        p "can't find #{destination_string}"
        return false
      end

      dis_time = DistanceAndTime.find_by(start_id: start.id, end_id: destination.id)
      if dis_time
        return true
      else
        dis_time = DistanceAndTime.new
        dis_time.start_id = start.id
        dis_time.end_id = destination.id
      end

      json = get_api_result(start, destination)
      if limit?(json)
        p 'limited!!!!!'
        return false
      end
      res = parse json
      dis_time.distance = res[0]
      dis_time.cost_time = res[1]
      dis_time.save

      dis_time_opposite = DistanceAndTime.find_by(start_id: destination.id, end_id: start.id)
      if dis_time_opposite
        return true
      else
        dis_time_opposite = DistanceAndTime.new
        dis_time_opposite.start_id = destination.id
        dis_time_opposite.end_id = start.id
      end
      dis_time_opposite.distance = res[0]
      dis_time_opposite.cost_time = res[1]
      dis_time_opposite.save

      true
    end

    private

    def get_api_result(start, destination)
      origin = "#{start.latitude},#{start.longitude}"
      des = "#{destination.latitude},#{destination.longitude}"
      api = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{des}&mode=drive&language=ja"
      uri = URI.parse(api)
      json = Net::HTTP.get(uri)
      JSON.parse(json)
    end

    def limit?(json)
      status = json['status']
      if status == 'OK'
        false
      else
        true
      end
    end

    def parse(json_data)
      begin
        distance = json_data['rows'][0]['elements'][0]['distance']['value']
        duration = json_data['rows'][0]['elements'][0]['duration']['value']
        [distance, duration]
      rescue
        p json_data
        [999999999, 999999999]
      end
    end
  end
end
