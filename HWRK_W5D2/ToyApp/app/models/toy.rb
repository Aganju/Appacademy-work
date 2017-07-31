class Toy < ActiveRecord::Base
  validates :name, uniqueness: { scope: :toyable,
     message: "can only have one of the same toy" }

  belongs_to :toyable, polymorphic: true
end
