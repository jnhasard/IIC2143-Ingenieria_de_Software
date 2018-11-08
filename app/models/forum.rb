class Forum < ApplicationRecord
	# belongs_to :user
	validates :title, presence: true, uniqueness: true  # presence: true hace que el titulo no pueda estar vacío
	validates :body, presence: true, length: { minimum: 20 }
	before_save :set_visits_count
	has_many :publications
	has_and_belongs_to_many :users
	#include PublicActivity::Model
	#tracked

	def update_visits_count
		# self.save if self.visits_count.nil?
		self.update(visits_count: self.visits_count + 1)
	end
	def fixed_visits_count
		# self.save if self.visits_count.nil?
		self.update(visits_count: self.visits_count - 1)
	end
	private

	def set_visits_count
		self.visits_count ||= 0
	end
	# validates :username, format: { with: /regex/ }
	def self.search(search)
		if search
			Forum.where(["title LIKE ?", "%#{search}%"])
		else
			all
		end
	end


end
