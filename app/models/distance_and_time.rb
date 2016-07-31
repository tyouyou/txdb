class DistanceAndTime < ActiveRecord::Base
  belongs_to :start_address, class_name: 'Address'
  belongs_to :end_address, class_name: 'Address'
end
