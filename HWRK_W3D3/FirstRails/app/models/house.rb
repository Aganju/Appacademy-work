class House < ActiveRecord::Base
  validates :address, presence: true

  has_many :residents,
    class_name: "Person",
    primary_key: :id,
    foreign_key: :house_id
end
