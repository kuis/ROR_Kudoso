class MembersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :family
  load_and_authorize_resource :member, through: :family

  respond_to :html

  # GET /members
  # GET /members.json
  def index
    @members = @family.members.all
    respond_with(@members)
  end

  # GET /members/1
  # GET /members/1.json
  def show

  end

  # GET /members/new
  def new
    @family = Family.find(params[:family_id])
    parent = @family.members.where(parent: true).limit(1).first
    @member = Member.new(family_id: @family.id, last_name: parent.try(:last_name))
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @family = Family.find(params[:family_id])
    @member = Member.new(params[:member].merge({family_id:@family.id}))
    respond_to do |format|
      if @member.save
        format.html { redirect_to @family, notice: 'Family member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    params[:member][:birth_date] = Chronic.parse(params[:member][:birth_date]) if params[:member][:birth_date]
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to [@family, @member], notice: 'Family member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to @family, notice: 'Family member was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private


  # Never trust parameters from the scary internet, only allow the white list through.
  def member_params
    params.require(:member).permit(:first_name, :last_name, :username, :parent, :password, :password_confirmation, :birth_date)
  end
end
