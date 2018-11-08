class ActivitiesController < ApplicationController
  def index
    #@activities = PublicActivity::Activity.order(&quot;created_at desc&quot;)
    @activities = PublicActivity::Activity.order("created_at DESC")
  end
end
