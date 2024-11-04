class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    new_actor = Actor.new
    new_actor.name = params[:query_name]
    new_actor.dob = params[:query_dob]
    new_actor.bio = params[:query_bio]
    new_actor.image = params[:query_image]

    if new_actor.save
      redirect_to("/actors")
    end
  end

  def delete_actor
    the_id = params.fetch("path_id")
    matching_records = Actor.where({ :id => the_id })

    the_actor = matching_records.at(0)

    the_actor.destroy

    redirect_to("/actors")
  end

  def update
    the_id = params[:path_id]
    actor = Actor.find_by(id: the_id)
    
    actor.name = params[:query_name]
    actor.dob = params[:query_dob]
    actor.bio = params[:query_bio]
    actor.image = params[:query_image]
    
    if actor.save
      redirect_to("/actors/#{actor.id}")
    end
  end
end
