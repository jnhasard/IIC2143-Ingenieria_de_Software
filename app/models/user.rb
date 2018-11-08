require 'oauth'
require 'json'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, presence: true, uniqueness: true  # presence: true hace que el titulo no pueda estar vacío
  # validates :username, presence: true #length: { minimum: 20 }
  # validates :imagen, presence: true
  has_many :publications, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_and_belongs_to_many :forums
  
  include PermissionsConcern
  
  # has_attached_file :image, styles: { medium: "1200x720", thumb:"800x600", mini: "400x200"}
  # validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  acts_as_voter
  def popularity
    counter = 0
    self.publications.each do |pub|
      counter += 0.2
      counter += pub.get_upvotes.size
      counter -= pub.get_downvotes.size
      counter += pub.visits_count / 10
    end
    self.comments.each do |comm|
      counter += 0.1
      counter += comm.get_upvotes.size / 2
      counter -= comm.get_downvotes.size
    end
    return counter.round(2)
  end


  def avatar
  	# get the email from URL-parameters or what have you and make lowercase
	email_address = self.email.downcase
	# create the md5 hash
	hash = Digest::MD5.hexdigest(email_address)
	# compile URL which can be used in <img src="RIGHT_HERE"...
	image_src = "https://www.gravatar.com/avatar/#{hash}"
  end

  def tweet_timeline options=nil # funciona
    consumer = ::OAuth::Consumer.new(ENV["API_KEY"], ENV["API_SECRET"], {site: "https://api.twitter.com", scheme: :header})
    token_hash = {oauth_token: ENV["ACCESS_TOKEN"], oauth_token_secret: ENV["ACCESS_TOKEN_SECRET"]}
    @access_token = ::OAuth::AccessToken.from_hash(consumer, token_hash)
    JSON.parse(@access_token.request(:get, 'https://api.twitter.com/1.1/statuses/home_timeline.json?&count=5', options).body)
  end

  def tweet_trends_city options=nil  # funciona WOEID de Stgo
    consumer = ::OAuth::Consumer.new(ENV["API_KEY"], ENV["API_SECRET"], {site: "https://api.twitter.com", scheme: :header})
    token_hash = {oauth_token: ENV["ACCESS_TOKEN"], oauth_token_secret: ENV["ACCESS_TOKEN_SECRET"]}
    @access_token = ::OAuth::AccessToken.from_hash(consumer, token_hash)
    JSON.parse(@access_token.request(:get, 'https://api.twitter.com/1.1/trends/place.json?id=349859', options).body)
  end

  def tweet_search(topic) options=nil # funciona
    consumer = ::OAuth::Consumer.new(ENV["API_KEY"], ENV["API_SECRET"], {site: "https://api.twitter.com", scheme: :header})
    token_hash = {oauth_token: ENV["ACCESS_TOKEN"], oauth_token_secret: ENV["ACCESS_TOKEN_SECRET"]}
    @access_token = ::OAuth::AccessToken.from_hash(consumer, token_hash)
    JSON.parse(@access_token.request(:get, 'https://api.twitter.com/1.1/search/tweets.json?&count=50&lang=es&q='+topic+'&result_type=popular', options).body)
  end

=begin
  def tweet_search(topic) options=nil
    @API_KEY = "A7weLeopCUJigJ6dcuA1PT46v"
    @API_SECRET = "O38J568ZJlVHeP37HQtlex7yHObVAnicPIcSODFTULPLtQx9mB"
    @ACCESS_TOKEN = "933078947608350723-jkatOIKFMGhh4u1WrUwXJlAwvbOO7bQ"
    @ACCESS_TOKEN_SECRET = "3Djy9C2wjQJC3lTMUQ0Vrf7rLjqtkQUSsRqo157fk592M"
    consumer = ::OAuth::Consumer.new(@API_KEY, @API_SECRET, {site: "https://api.twitter.com", scheme: :header})
    token_hash = {oauth_token: @ACCESS_TOKEN, oauth_token_secret: @ACCESS_TOKEN_SECRET}
    @access_token = ::OAuth::AccessToken.from_hash(consumer, token_hash)
    JSON.parse(@access_token.request(:get, 'https://api.twitter.com/1.1/search/tweets.json?&count=50&lang=es&q='+topic+'&result_type=popular', options).body)
  end
=end


  def tweet_realtime_filter(word) options=nil
    consumer = ::OAuth::Consumer.new(ENV["API_KEY"], ENV["API_SECRET"], {site: "https://api.twitter.com", scheme: :header})
    token_hash = {oauth_token: ENV["ACCESS_TOKEN"], oauth_token_secret: ENV["ACCESS_TOKEN_SECRET"]}
    @access_token = ::OAuth::AccessToken.from_hash(consumer, token_hash)
    JSON.parse(@access_token.request(:get, 'https://stream.twitter.com/1.1/statuses/filter.json?track='+word, options).body).first(5)
  end
end
