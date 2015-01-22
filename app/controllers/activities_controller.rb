class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :family
  load_and_authorize_resource :member, through: :family
  load_and_authorize_resource :activity, through: :member

  respond_to :html

  def index
    @activities = @member.activities.all
    respond_with(@activities)
  end

  def show
    respond_with(@activity)
  end

  def new
    if params[:family_activity_id]
      famact = FamilyActivity.find(params[:family_activity_id])
      @activity = @member.new_activity(famact, nil)
      if params[:start]
        @activity.start!
      end
      redirect_to family_member_activities_path(@family, @member)
    else
      @activity = @member.activities.build
      respond_with(@activity)
    end
  end

  def edit
  end

  def create
    params[:activity][:member_id] = @member.id
    @activity = @member.activities.build(activity_params)
    @activity.save
    respond_with(@activity)
  end

  def update
    if params[:stop]
      @activity.stop!
      redirect_to family_member_activities_path(@family, @member)
    else
      params[:activity][:member_id] = @member.id
      @activity.update(activity_params)
      respond_with(@activity)
    end
  end

  def destroy
    @activity.destroy
    respond_with(@activity)
  end

  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:member_id, :created_by, :family_activity_id, :start_time, :end_time, :device_id, :content_id, :allowed_time, :activity_type_id, :cost, :reward)
      params.permit(:family_activity_id, :start)
    end
end
