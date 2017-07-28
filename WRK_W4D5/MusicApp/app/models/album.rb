# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string
#  live       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :integer
#

class Album < ApplicationRecord
  validates :name, :live, :band_id, presence: true

  belongs_to :band
  has_many :tracks
end
