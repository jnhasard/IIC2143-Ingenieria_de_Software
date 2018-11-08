class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :publication
  acts_as_votable
  validates :body, presence: true, length: { minimum: 10 }
  before_save :set_visits_count
  #include PublicActivity::Model
	#tracked

  def set_visits_count
	self.visits_count ||= 0
  end
  def update_visits_count
	# self.save if self.visits_count.nil?
	self.update(visits_count: self.visits_count + 1)
  end
end
