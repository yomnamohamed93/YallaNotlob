class GroupsController < ApplicationController
  before_action :set_group, only: %i(show edit update destroy)

  # GET /groups
  # GET /groups.json
  def index
    @user = current_user
    @groups = @user.groups
  end

  def show
    @user = current_user
    @groups = Group.find params[:id]
    @membersG= @group.members
   end

  def new
    @user = current_user
    @group = @user.groups.new
  end

  def edit; end

  def create
    @user = current_user
    @group = @user.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_url, notice: 'Group created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_user
    @group = @user.groups.find(params[:id])
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to [@group], notice: 'Group updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def members
    @group = Group.find params[:group_ID]
    # @group = Group.where(:group_group_ID => params[:group_ID]).first # file_name is the data key of Ajax request in view
    @members = @group.members
  #  if request.xhr?
   #
  #      render :json => {
  #                          :g_members => @group.members
  #                      }
  #   end
    respond_to do |format|
      # format.html # show.html.erb
      format.json { render json: @members.to_json }
    end
  end

  def add_member
    begin
      @member = current_user.friends.where(email: params[:friend_email]).first
      @group = Group.find params[:group_id]
      begin
        @group.members.find @member.id
      rescue
        @group.members << @member
      end
      respond_to do |format|
        # format.html # show.html.erb
        format.json { render json: @member }
      end
    rescue
      respond_to do |format|
        # format.html # show.html.erb
        format.json { render json: "Not found" }
      end
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @user = current_user
    @group = @user.groups.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :user_id)
  end
  def member_params
    params.require(:group).permit(:name, :user_id)
  end
end
