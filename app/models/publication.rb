class Publication < ApplicationRecord
	belongs_to :forum
	belongs_to :user
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: { minimum: 20 }
	before_save :set_visits_count
	has_many :comments, dependent: :delete_all
	acts_as_votable
	#include PublicActivity::Model
	#tracked

	def update_visits_count
		self.save if self.visits_count.nil?
		self.update(visits_count: self.visits_count + 1)
	end

	private

	def set_visits_count
		self.visits_count ||= 0
	end

	def self.search(forum, search)
		if search and "%#{search}%" != ""
			Publication.where(["title LIKE ?", "%#{search}%"])
			#Publication.where(["forum_id LIKE ?", id])
		end
		if search and "%#{search}%" == ""
			forum.publications
		else
			forum.publications
		end
	end


end
