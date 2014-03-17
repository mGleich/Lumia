class ReleasesController < ApplicationController

  before_filter :require_login
  before_filter :require_admin
  layout "admin"
  # GET /releases
  # GET /releases.json
  def index
    @releases = Release.all
    @releases = Release.paginate(:per_page => 15, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @releases }
    end
  end

  # GET /releases/1
  # GET /releases/1.json
  def show
    @release = Release.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @release }
    end
  end

  # GET /releases/new
  # GET /releases/new.json
  def new
    @release = Release.new
    @root = EventType.find(2)

    @available_states = State.all

    @add_states = Array.new
    @add_event_types = Array.new

    @by_system = false
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @release }
    end
  end

  # GET /releases/1/edit
  def edit
    @release = Release.find(params[:id])

    self.reload_params
  end

  # POST /releases
  # POST /releases.json
  def create
    @release = Release.new(params[:release])

    if params[:add_states] != nil
      params[:add_states].each do |f|
        @state = State.find(f)
        @release.states << @state
      end
    end

    if params[:create_by_system] == "1"
      @release.event_types << EventType.find(1)
    end

    if params[:add_event_types] != nil
      params[:add_event_types].each do |f|
        @event_type = EventType.find(f)
        @release.event_types << @event_type
      end
    end

    respond_to do |format|
      if @release.save
        format.html { redirect_to @release, notice: 'Ausloeser wurde erfolgreich erzeugt' }
        format.json { render json: @release, status: :created, location: @release }
      else
        self.reload_params
        format.html { render action: "new" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /releases/1
  # PUT /releases/1.json
  def update
    @release = Release.find(params[:id])

    @release.states.clear
    if params[:add_states] != nil
      params[:add_states].each do |f|
        @state = State.find(f)
        @release.states << @state
      end
    end

    @release.event_types.clear
    if params[:add_event_types] != nil
      params[:add_event_types].each do |f|
        @event_type = EventType.find(f)
        @release.event_types << @event_type
      end
    end

    if params[:create_by_system] == "1"
      @release.event_types << EventType.find(1)
    end

    respond_to do |format|
      if @release.update_attributes(params[:release])
        format.html { redirect_to @release, notice: 'Ausloeser wurde erfolgreich aktualisiert' }
        format.json { head :no_content }
      else
        self.reload_params
        format.html { render action: "edit" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.json
  def destroy
    @release = Release.find(params[:id])
    @release.destroy

    respond_to do |format|
      format.html { redirect_to releases_url }
      format.json { head :no_content }
    end
  end

  def reload_params
    @root = EventType.find(2)

    @available_states = State.all.reject { |l| @release.states.include? l }

    @add_states = @release.states
    @add_event_types = @release.event_types

    if @add_event_types.include?(EventType.find(1))
      @add_event_types.delete(EventType.find(1))
      @by_system = true
    end
  end
end
