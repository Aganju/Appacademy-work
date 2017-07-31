# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string
#  bonus      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer
#

class Track < ApplicationRecord
  validates :name, :bonus, :album_id, presence: true

  belongs_to :album

end
