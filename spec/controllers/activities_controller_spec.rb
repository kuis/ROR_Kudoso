require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ActivitiesController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Activity. As you add validations to Activity, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { member_id: @member.id,
    created_by_id: @member.id,
    family_activity_id: @family_activity.id,
    allowed_time: 30}
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ActivitiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }


  context 'with an authenticated member' do
    before(:each) do
      @member = FactoryGirl.create(:member)
      @family = @member.family
      sign_in_member(@member)
    end

    describe "GET index" do
      it "assigns all activities as @activities" do
        activity = FactoryGirl.create(:activity, created_by_id: @member.id, member_id: @member.id)
        get :index, {family_id: @family.id, member_id: @member.id}, valid_session
        expect(assigns(:activities)).to match_array([activity])
      end
    end

    describe "GET show" do
      it "assigns the requested activity as @activity" do
        activity = FactoryGirl.create(:activity, created_by_id: @member.id, member_id: @member.id)
        get :show, {family_id: @family.id, member_id: @member.id, :id => activity.to_param}, valid_session
        expect(assigns(:activity)).to eq(activity)
      end
    end

    describe "GET new" do
      it "assigns a new activity as @activity" do
        get :new, {family_id: @family.id, member_id: @member.id}, valid_session
        expect(assigns(:activity)).to be_a_new(Activity)
      end
    end

    describe "GET edit" do
      it "assigns the requested activity as @activity" do
        activity = FactoryGirl.create(:activity, created_by_id: @member.id, member_id: @member.id)
        get :edit, {family_id: @family.id, member_id: @member.id, :id => activity.to_param}, valid_session
        expect(assigns(:activity)).to eq(activity)
      end
    end

    describe "GET create" do
      # We use a get link to create activities
      it "creates a new Activity" do
        activity_template = FactoryGirl.create(:activity_template, restricted: false)
        expect {
          get :new, {family_id: @family.id, member_id: @member.id, activity_template_id: activity_template.id}
        }.to change(Activity, :count).by(1)
      end

      it "creates and starts a new Activity" do
        activity_template = FactoryGirl.create(:activity_template, restricted: false)
        get :new, {family_id: @family.id, member_id: @member.id,  activity_template_id: activity_template.id, start: true}
        expect(assigns(:activity).start_time).to be_between(Time.now.localtime - 1.minute, Time.now.localtime)
      end
    end

    describe "PUT update" do
      it "stops a previously started activity" do
        activity = FactoryGirl.create(:activity, created_by_id: @member.id, member_id: @member.id, start_time: 1.hour.ago, end_time: nil)
        put :update, {family_id: @family.id, member_id: @member.id, :id => activity.to_param, stop: true}, valid_session
        expect(response).to redirect_to(family_member_path(@family, @member))
        activity.reload
        expect(activity.end_time).to be > activity.start_time
      end
    end

    describe "DELETE destroy" do
      it "does not destroys the requested activity" do
        activity = FactoryGirl.create(:activity, created_by_id: @member.id, member_id: @member.id)
        expect {
          delete :destroy, {family_id: @family.id, member_id: @member.id, :id => activity.to_param}, valid_session
        }.to change(Activity, :count).by(0)
      end

      it "redirects to the current member dashboard" do
        activity = FactoryGirl.create(:activity, created_by_id: @member.id, member_id: @member.id)
        delete :destroy, {family_id: @family.id, member_id: @member.id, :id => activity.to_param}, valid_session
        expect(flash[:error]).to be_present
        expect(response).to redirect_to(family_member_path(@family, @member))
      end
    end

    # describe "POST create" do
    #   describe "with valid params" do
    #     pending "creates a new Activity" do
    #       expect {
    #         post :create, {family_id: @family.id, member_id: @member.id, :activity => valid_attributes}, valid_session
    #       }.to change(Activity, :count).by(1)
    #     end
    #
    #     pending "assigns a newly created activity as @activity" do
    #       post :create, {:activity => valid_attributes}, valid_session
    #       expect(assigns(:activity)).to be_a(Activity)
    #       expect(assigns(:activity)).to be_persisted
    #     end
    #
    #     pending "redirects to the created activity" do
    #       post :create, {:activity => valid_attributes}, valid_session
    #       expect(response).to redirect_to(Activity.last)
    #     end
    #   end
    #
    #   describe "with invalid params" do
    #     pending "assigns a newly created but unsaved activity as @activity" do
    #       post :create, {:activity => invalid_attributes}, valid_session
    #       expect(assigns(:activity)).to be_a_new(Activity)
    #     end
    #
    #     pending "re-renders the 'new' template" do
    #       post :create, {:activity => invalid_attributes}, valid_session
    #       expect(response).to render_template("new")
    #     end
    #   end
    # end

    # describe "PUT update" do
    #   describe "with valid params" do
    #     let(:new_attributes) {
    #       skip("Add a hash of attributes valid for your model")
    #     }
    #
    #     it "updates the requested activity" do
    #       activity = Activity.create! valid_attributes
    #       put :update, {:id => activity.to_param, :activity => new_attributes}, valid_session
    #       activity.reload
    #       skip("Add assertions for updated state")
    #     end
    #
    #     it "assigns the requested activity as @activity" do
    #       activity = Activity.create! valid_attributes
    #       put :update, {:id => activity.to_param, :activity => valid_attributes}, valid_session
    #       expect(assigns(:activity)).to eq(activity)
    #     end
    #
    #     it "redirects to the activity" do
    #       activity = Activity.create! valid_attributes
    #       put :update, {:id => activity.to_param, :activity => valid_attributes}, valid_session
    #       expect(response).to redirect_to(activity)
    #     end
    #   end
    #
    #   describe "with invalid params" do
    #     it "assigns the activity as @activity" do
    #       activity = Activity.create! valid_attributes
    #       put :update, {:id => activity.to_param, :activity => invalid_attributes}, valid_session
    #       expect(assigns(:activity)).to eq(activity)
    #     end
    #
    #     it "re-renders the 'edit' template" do
    #       activity = Activity.create! valid_attributes
    #       put :update, {:id => activity.to_param, :activity => invalid_attributes}, valid_session
    #       expect(response).to render_template("edit")
    #     end
    #   end
    # end



  end

end
