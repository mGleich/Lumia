class RegularExpressionsController < ApplicationController

  before_filter :require_login
  before_filter :require_admin
  layout "admin"
  # GET /regular_expressions
  # GET /regular_expressions.json
  def index
    @regular_expressions = RegularExpression.all
    @regular_expressions = RegularExpression.paginate(:per_page => 5, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regular_expressions }
    end
  end

  # GET /regular_expressions/1
  # GET /regular_expressions/1.json
  def show
    @regular_expression = RegularExpression.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @regular_expression }
    end
  end

  # GET /regular_expressions/new
  # GET /regular_expressions/new.json
  def new
    @regular_expression = RegularExpression.new

    @available_releases = Release.all
    @available_rules = Rule.all
    @available_results = Result.all

    @add_releases = Array.new
    @add_rules = Array.new
    @add_results = Array.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @regular_expression }
    end
  end

  # GET /regular_expressions/1/edit
  def edit
    @regular_expression = RegularExpression.find(params[:id])

    update_params

  end

  # POST /regular_expressions
  # POST /regular_expressions.json
  def create
    @regular_expression = RegularExpression.new(params[:regular_expression])

    self.update_lists

    respond_to do |format|
      if @regular_expression.save
        format.html { redirect_to @regular_expression, notice: 'Regelausdruck wurde erfolgreich angelegt' }
        format.json { render json: @regular_expression, status: :created, location: @user }
      else
        update_params
        format.html { render action: "new" }
        format.json { render json: @regular_expression.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /regular_expressions/1
  # PUT /regular_expressions/1.json
  def update
    @regular_expression = RegularExpression.find(params[:id])

    @regular_expression.releases.clear
    @regular_expression.rules.clear
    @regular_expression.results.clear

    self.update_lists

    respond_to do |format|
      if @regular_expression.update_attributes(params[:regular_expression])
        format.html { redirect_to @regular_expression, notice: 'Regelausdruck wurde erfolgreich bearbeitet' }
        format.json { head :no_content }
      else
        update_params
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /regular_expressions/1
  # DELETE /regular_expressions/1.json
  def destroy
    @regular_expression = RegularExpression.find(params[:id])
    @regular_expression.destroy

    respond_to do |format|
      format.html { redirect_to regular_expressions_url }
      format.json { head :no_content }
    end
  end

  #hilfsfunktion dient dazu die Seite aktuell zu halten wenn ein Fehleintrag passiert
  def update_params
    @available_releases = Release.all.reject { |l| @regular_expression.releases.include? l }
    @available_rules = Rule.all.reject { |l| @regular_expression.rules.include? l }
    @available_results = Result.all.reject { |l| @regular_expression.results.include? l }
  end

  def update_lists
    if params[:add_releases_arr] != nil
      params[:add_releases_arr].each do |f|
        @release = Release.find(f)
        @regular_expression.releases << @release
      end
    end

    if params[:add_rules_arr]!= nil
      params[:add_rules_arr].each do |f|
        @rule = Rule.find(f)
        @regular_expression.rules << @rule
      end
    end
    if  params[:add_results_arr] != nil
      params[:add_results_arr].each do |f|
        @result = Result.find(f)
        @regular_expression.results << @result
      end
    end
  end
end
