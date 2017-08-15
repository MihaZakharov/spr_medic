class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def all

    res=[]
    buf={}
    @groups = Group.where('kls_parent=1613').order("NAME ASC").each do |grp|
	    if grp.products.exists?
                buf={}
		buf[:name] = grp.name
		buf[:id] = grp.id
		buf[:kls_parent] = grp.kls_parent
		buf[:kls_unicode] = grp.kls_unicode
		buf[:kls_childcount] = grp.kls_childcount
 	        res.push(buf)
	    end
    end
  #  @rgroups = @group
#    @groups = Group.where('kls_parent=1613')
#    render json: @groups
    render json: res

  end

  def alln

    res=[]
    buf={}
    @groups = Group.where('kls_parent=1612').order("name ASC").each do |grp|
	   # if grp.products.where("price > 0").exists?
                buf={}
		buf[:name] = grp.name
		buf[:id] = grp.id
		buf[:kls_parent] = grp.kls_parent
		buf[:kls_unicode] = grp.kls_unicode
		buf[:kls_childcount] = grp.kls_childcount
 	        res.push(buf)
	#    end
    end
  #  @rgroups = @group
#    @groups = Group.where('kls_parent=1613')
#    render json: @groups
    render json: res

  end

  def index
    @groups = Group.all
    render json: @groups
  end

  # GET /groups/1
  # GET /groups/1.json
  def showgrp
    @grp = params[:id].to_s
    @groups=Group.where("kls_parent="+@grp).order("name asc")
    render json: @groups
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name)
    end
end
