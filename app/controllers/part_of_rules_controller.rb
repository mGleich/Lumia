class PartOfRulesController < ApplicationController

  before_filter :require_login
  before_filter :require_admin
  layout "admin"
  # GET /part_of_rules
  # GET /part_of_rules.json
  def index
    @part_of_rules = PartOfRule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @part_of_rules }
    end
  end

  # GET /part_of_rules/1
  # GET /part_of_rules/1.json
  def show
    @part_of_rule = PartOfRule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @part_of_rule }
    end
  end

  # GET /part_of_rules/new
  # GET /part_of_rules/new.json
  def new
    @part_of_rule = PartOfRule.new

    @add_event_types = Array.new

    self.reload_params

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @part_of_rule }
    end
  end

  # GET /part_of_rules/1/edit
  def edit
    @part_of_rule = PartOfRule.find(params[:id])
    @add_event_types = @part_of_rule.event_types
    self.reload_params

  end

  # POST /part_of_rules
  # POST /part_of_rules.json
  def create
    @part_of_rule = PartOfRule.new(params[:part_of_rule])

    if params[:add_event_types_arr] != nil
      params[:add_event_types_arr].each do |f|
        @event_type = EventType.find(f)
        @part_of_rule.event_types << @event_type
      end
    end

    respond_to do |format|
      if @part_of_rule.save
        format.html { redirect_to @part_of_rule, notice: 'Part of rule was successfully created.' }
        format.json { render json: @part_of_rule, status: :created, location: @part_of_rule }
      else
        @add_event_types = @part_of_rule.event_types
        self.reload_params
        format.html { render "new" }
        format.json { render json: @part_of_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /part_of_rules/1
  # PUT /part_of_rules/1.json
  def update
    @part_of_rule = PartOfRule.find(params[:id])

    @part_of_rule.event_types.clear
    if params[:add_event_types_arr] != nil
      params[:add_event_types_arr].each do |f|
        @event_type = EventType.find(f)
        @part_of_rule.event_types << @event_type
      end
    end

    respond_to do |format|
      if @part_of_rule.update_attributes(params[:part_of_rule])
        format.html { redirect_to @part_of_rule, notice: 'Part of rule was successfully updated.' }
        format.json { head :no_content }
      else
        @add_event_types = @part_of_rule.event_types
        self.reload_params
        format.html { render action: "edit" }
        format.json { render json: @part_of_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /part_of_rules/1
  # DELETE /part_of_rules/1.json
  def destroy
    @part_of_rule = PartOfRule.find(params[:id])
    @part_of_rule.destroy

    respond_to do |format|
      format.html { redirect_to part_of_rules_url }
      format.json { head :no_content }
    end
  end

  def reload_params

    @root = EventType.find(2)
    @first_level_selection = Array.new

    @event_type = EventType.new()
    @first_level_selection << @event_type
    @root.children.each do |child|
      @first_level_selection << child
    end

    for i in 2..5
      instance_variable_set "@#{@event_type.depth_name(i)}_level_selection".to_sym, Array.new
    end
  end

  def update_select_field
    @number = params[:depth].to_i

    @x_level_selection = Array.new
    if params[:id] ==""
      @event_type = EventType.new()
    else
      @event_type = EventType.find(params[:id])
      @x_level_selection << EventType.new()
      @x_level_selection = @x_level_selection +@event_type.children
    end
  end
end
