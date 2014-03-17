class RulesController < ApplicationController

  before_filter :require_login
  before_filter :require_admin
  layout "admin"
  # GET /rules
  # GET /rules.json
  def index
    @rules = Rule.all
    @rules = Rule.paginate(:per_page => 15, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rules }
    end
  end

  # GET /rules/1
  # GET /rules/1.json
  def show
    @rule = Rule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/new
  # GET /rules/new.json
  def new
    @rule = Rule.new
    @root = EventType.find(2)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rule }
    end
  end

  # GET /rules/1/edit
  def edit
    @rule = Rule.find(params[:id])
    save_failed
  end

  # POST /rules
  # POST /rules.json

  def create
    @rule = Rule.new
    @rule.name = params[:rule_name]

    create_part_of_rules

    respond_to do |format|
      if @rule.save
        format.html { redirect_to @rule, notice: 'Regel wurde erfolgreich angelegt.' }
        format.json { render json: @rule, status: :created, location: @rule }
      else
        save_failed
        format.html { render "new" }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rules/1
  # PUT /rules/1.json
  def update
    @rule = Rule.find(params[:id])
    @rule.name = params[:rule_name]

    @rule.part_of_rules.clear

    create_part_of_rules

    respond_to do |format|
      if @rule.update_attributes(params[:rule])
        format.html { redirect_to @rule, notice: 'Regel wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        save_failed
        format.html { render action: "edit" }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy

    respond_to do |format|
      format.html { redirect_to rules_url }
      format.json { head :no_content }
    end
  end

  def save_failed
    @twenty = Array.new
    for i in 0..19
      @twenty[i] = i+1
    end
    @root = EventType.find(2)
  end

  def create_part_of_rules
    #Hier wird aus eine Sammlung an Teilregeln aus params extrahiert und abgearbeitet/erstellt
    part_of_rules = params.select { |key, value| key.to_s.match(/^part_of_rule\d+/) }

    #Befinden sich in der Regel keine Teilregeln handelt es sich um eine Regel vom Typ Sofortige Regel
    if part_of_rules.length == 0
      @rule.type = "RuleStraight"
    else
      @rule.type = "RuleWithParts"
      part_of_rules.each do |part_of_rule|
        @part_of_rule = @rule.part_of_rules.build(boperator: part_of_rule[1][:boperator], test_value: part_of_rule[1][:test_value].to_i)
        if part_of_rule[1][:add_event_types] != nil && part_of_rule[1][:add_event_types].length != 0
        part_of_rule[1][:add_event_types].each do |event_type_id|
          @part_of_rule.event_types << EventType.find(event_type_id)
        end
        end
        end
    end
  end
end


