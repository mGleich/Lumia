class EventTypesController < ApplicationController
  before_filter :require_login
  before_filter :require_admin
  layout "admin"
  # GET /event_types
  # GET /event_types.json
  def index
    @event_types = EventType.all
    @event_types = EventType.paginate(:per_page => 15, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @event_types }
    end
  end

  # GET /event_types/1
  # GET /event_types/1.json
  def show
    @event_type = EventType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event_type }
    end
  end

  # GET /event_types/new
  # GET /event_types/new.json
  def new
    @event_type = EventType.new
    @root = EventType.find(2)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event_type }
    end
  end

  # GET /event_types/1/edit
  def edit

    @event_type = EventType.find(params[:id])

    self.reload_params

  end


  # POST /event_types
  # POST /event_types.json
  def create
    @event_type = EventType.new(params[:event_type])

    @event_type.parent_id = params[:parent]
    @parent = EventType.find(params[:parent])
    #setzt automatisch den Vaterknoten als Knoten
    @parent.node = true
    #der Frischling wird ein Blatt
    @event_type.node = false

    respond_to do |format|
      if @event_type.save && @parent.save
        self.reload_params
        format.html { redirect_to @event_type, notice: 'Ereignistyp wurde erfolgreich angelegt' }
        format.json { render json: @event_type, status: :created, location: @event_type }
      else
        self.reload_params
        format.html { render action: "new" }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /event_types/1
  # PUT /event_types/1.json
  def update
    @event_type = EventType.find(params[:id])

    @old_parent = @event_type.parent

    @event_type.parent_id = params[:parent]
    @event_type.save
    @parent = @event_type.parent

    @parent.node = true
    @parent.save

    if @old_parent.has_children? == false
      @old_parent.node = false
      @old_parent.save
    end

    respond_to do |format|
      if @event_type.update_attributes(params[:event_type])
        format.html { redirect_to @event_type, notice: 'Ereignistyp wurde erfolgreich bearbeitet' }
        format.json { head :no_content }
      else
        self.reload_params
        format.html { render action: "edit" }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_types/1
  # DELETE /event_types/1.json
  def destroy
    @event_type = EventType.find(params[:id])
    @parent = @event_type.parent
    @event_type.destroy

    if @parent.has_children? == false
      @parent.node = false
      @parent.save
    end
    respond_to do |format|
      format.html { redirect_to event_types_url }
      format.json { head :no_content }
    end
  end

  #Funktion soll dazu dienen das bereits eingegebene Daten beim neuladen der Seite nicht verschwinden
  #wird nur aufgerufen wenn ein Speichern der Daten aus welchen Gründen auch immer nicht funktionierte
  def reload_params
    @root = EventType.find(2)

    @ancestors = @event_type.ancestor_ids

    for i in 1..4
      if @ancestors[i] == nil
        @ancestors[i] = 0
      end
    end
  end
end
