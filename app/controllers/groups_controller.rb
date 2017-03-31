class GroupsController < ApplicationController
  before_action :set_group, only: %i(show edit update destroy)

  # GET /groups
  # GET /groups.json
  def index
    @user = User.find(current_user)
    @groups = @user.groups
  end

  def show; end

  def new
    @user = User.find(params[:user_id])
    @group = @user.groups.new
  end

  def edit; end

  def create
    @user = User.find(params[:user_id])
    @group = @user.groups.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to [@user, @group], notice: 'Group created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:user_id])
    @group = @user.groups.find(params[:id])
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to [@user, @group], notice: 'Group updated.' }
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
      format.html { redirect_to user_groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @user = User.find(params[:user_id])
    @group = @user.groups.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :user_id)
  end
end
