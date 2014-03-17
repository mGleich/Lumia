class EventsController < ApplicationController

  before_filter :require_login
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @client = Client.find(@event.client_id)
    @event_type = EventType.find(@event.event_type_id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = current_user.events.build
    @event.client_id = params[:id]

    @root = EventType.find(2)

    @event_type_amount = Array.new

    @client = Client.find(params[:id])
    #Die Ereignistypen auswahl wird Dynamisch für den Klient erzeugt dadurch
    @client.event_types.each do |node|
      node.descendants.each do |descendant|
        @event_type_amount << descendant
      end
      node.ancestors.each do |ancestor|
        @event_type_amount << ancestor
      end
      @event_type_amount << node
    end

    @event_type_amount = @event_type_amount.uniq

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @client = Client.find(@event.client_id)

    self.reload_params

  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @client = Client.find(params[:event][:client_id])
    @event_type = EventType.find(params[:selected])
    if @event_type.node == false
      @event.event_type_id = params[:selected]
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Ereignis wurde erfolgreich angelegt' }
        format.json { render json: @event, status: :created, location: @event }
      else
        @root = EventType.find(2)

        #sämtliche EventTypen die dem Klienten zur Auswahl stehen
        @event_type_amount = Array.new
        @client.event_types.each do |node|
          node.descendants.each do |descendant|
            @event_type_amount << descendant
          end
          node.ancestors.each do |ancestor|
            @event_type_amount << ancestor
          end
          @event_type_amount << node
        end
        @event_type_amount = @event_type_amount.uniq
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    @client = Client.find(params[:event][:client_id])
    @event.event_type_id = nil
    @event_type = EventType.find(params[:selected])
    if @event_type.node == false
      @event.event_type_id = params[:selected]
    end

    respond_to do |format|
      if params[:event][:event_type_id] != "" && @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Ereignis wurde erfolgreich bearbeitet' }
        format.json { head :no_content }
      else
        self.reload_params
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @client = Client.find(@event.client_id)
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_to_client_path(@client) }
      format.json { head :no_content }
    end
  end

  def reload_params
    #lade event auswahl zum client
    @root = EventType.find(2)

    #sämtliche EventTypen die dem Klienten zur Auswahl stehen
    @event_type_amount = Array.new
    @client.event_types.each do |node|
      node.descendants.each do |descendant|
        @event_type_amount << descendant
      end
      node.ancestors.each do |ancestor|
        @event_type_amount << ancestor
      end
      @event_type_amount << node
    end

    @event_type_amount = @event_type_amount.uniq

    #beinhaltet alle vorherig ausgewählten Elemente
    if @event.event_type_id != nil
    @selected_event_type = EventType.find(@event.event_type_id)

    @selected_event_type_amount = @selected_event_type.ancestor_ids

    for i in 1..4
      if @selected_event_type_amount[i] == nil
        @selected_event_type_amount[i] = 0
      end
     end

    @selected_event_type_amount << @selected_event_type.id
    end
    end
end

