class Activity < ActiveRecord::Base
  has_many :venue_activities
  has_many :venues, through: :venue_activities

  KINDS = %w(darts billiards shuffleboard)
end
