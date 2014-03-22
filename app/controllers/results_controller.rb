class ResultsController < ApplicationController
  force_ssl
  before_filter :require_login
  before_filter :require_admin
  layout "admin"
  # GET /results
  # GET /results.json
  def index
    @results = Result.all
    @results = Result.paginate(:per_page => 15, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @results }
    end
  end

  # GET /results/1
  # GET /results/1.json
  def show
    @result = Result.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @result }
    end
  end

  # GET /results/new
  # GET /results/new.json
  def new
    @result = Result.new
    @available_states = State.all
    @root = EventType.find(2)
    @add_event_types = @result.event_types

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @result }
    end
  end

  # GET /results/1/edit
  def edit
    @result = Result.find(params[:id])
    reload_edit_params
  end

# POST /results
# POST /results.json
  def create

    @result = Result.new
    @result.name = params[:name]

    if params[:type] == "Statuswechsel"
      @result.type = "ResultStateChange"
      if params[:selected_state] != nil && params[:selected_state] != ""
        @state = State.find(params[:selected_state])
        @result.state = @state
      end
    end

    if params[:type] == "Ereignistypen Menge aendern"
      @result.type = "ResultChangeEventTypeAmount"

      if  params[:event_type_operator] != nil && params[:event_type_operator] != ""
        @result.event_type_operator = params[:event_type_operator]

        if (params[:event_type_operator]) == "Zur Menge Hinzufuegen" || (params[:event_type_operator]) == "Aus Menge entfernen"

          if params[:add_event_types] != nil
            params[:add_event_types].each do |f|
              @event_type = EventType.find(f)
              @result.event_types << @event_type
            end
          end
        end
      end
    end

    if params[:info] != nil && (params[:type]) == "Info"
      @result.type = "ResultInfo"
      @result.info = params[:info]
    end

    if params[:type] == "Client Sperren"
      @result.type = "ResultLock"
    end

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Ergebnis wurde erfolgreich erzeugt' }
        format.json { render json: @result, status: :created, location: @result }
      else
        self.reload_edit_params
        format.html { render "new" } #redirect_to new_result_path
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

# PUT /results/1
# PUT /results/1.json
  def update
    @result = Result.find(params[:id])
    @result.name = params[:name]

    if params[:type] == "Statuswechsel"
      @result.type = "ResultStateChange"
      clear_entity
      if params[:selected_state] != nil && params[:selected_state] != ""
        @state = State.find(params[:selected_state])
        @result.state = @state
      end

    end

    if params[:type] == "Ereignistypen Menge aendern"
      @result.type = "ResultChangeEventTypeAmount"
      clear_entity
      if  params[:event_type_operator] != nil && params[:event_type_operator] != ""
        @result.event_type_operator = params[:event_type_operator]

        if (params[:event_type_operator]) == "Zur Menge Hinzufuegen" || (params[:event_type_operator]) == "Aus Menge entfernen"

          if params[:add_event_types] != nil
            params[:add_event_types].each do |f|
              @event_type = EventType.find(f)
              @result.event_types << @event_type
            end
          end
        end
      end
    end

    if params[:info] != nil && (params[:type]) == "Info"
      @result.type = "ResultInfo"
      clear_entity
      @result.info = params[:info]
    end

    if params[:type] == "Client Sperren"
      @result.type = "ResultLock"
      clear_entity
    end

    respond_to do |format|
      if @result.save
        format.html { redirect_to @result, notice: 'Ergebnis wurde erfolgreich aktualisiert' }
        format.json { head :no_content }
      else
        self.reload_edit_params
        format.html { render "edit" }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

# DELETE /results/1
# DELETE /results/1.json
  def destroy
    @result = Result.find(params[:id])
    @result.destroy

    respond_to do |format|
      format.html { redirect_to results_url }
      format.json { head :no_content }
    end
  end

  def reload_edit_params
    @available_states = State.all
    @add_event_types = @result.event_types
    @root = EventType.find(2)

    if @result.type == "ResultStateChange"
      @available_states.delete(@result.state)
    end

    if @result.type == "ResultChangeEventTypeAmount"
      @event_type = EventType.new
    end

    if  @result.type == "ResultStateChange"
      @type = "Statuswechsel"
    end

    if @result.type == "ResultChangeEventTypeAmount"
      @type = "Ereignistypen Menge aendern"
    end

    if @result.type == "ResultInfo"
      @type = "Info"
    end

    if @result.type == "ResultLock"
      @type = "Client Sperren"
    end
  end

  def clear_entity
    @result.save
    @result = Result.find(params[:id])
    @result.event_types.clear
    @result.state = nil
    @result.info = nil
    @result.event_type_operator = nil
  end
end
