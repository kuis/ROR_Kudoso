class Device < ActiveRecord::Base
  belongs_to :device_type
  belongs_to :family
  belongs_to :primary_member, class_name: 'Member'
  has_and_belongs_to_many :activities
  belongs_to :current_activity, class_name: 'Activity'
  belongs_to :management_device, class_name: 'Device', foreign_key: 'management_id', counter_cache: :managed_devices_count
  has_many :managed_devices, class_name: 'Device', foreign_key: 'management_id'
  has_many :screen_times

  validates_uniqueness_of :name
  validates_presence_of :device_type_id
  validates_presence_of :family_id

  before_create { self.uuid = SecureRandom.hex(24) }

  attr_readonly :uuid

  def current_member
    current_member = nil
    current_member =  current_activity.member if current_activity.present?
  end
end
