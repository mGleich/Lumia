class AdressesController < ApplicationController
  before_filter :require_login
  # GET /adresses
  # GET /adresses.json
  def index
    @adresses = Adress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @adresses }
    end
  end

  # GET /adresses/1
  # GET /adresses/1.json
  def show
    @adress = Adress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @adress }
    end
  end

  # GET /adresses/new
  # GET /adresses/new.json
  def new
    @adress = Adress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @adress }
    end
  end

  # GET /adresses/1/edit
  def edit
    @adress = Adress.find(params[:id])
  end

  # POST /adresses
  # POST /adresses.json
  def create
    @adress = Adress.new(params[:adress])

    respond_to do |format|
      if @adress.save
        format.html { redirect_to @adress, notice: 'Adress was successfully created.' }
        format.json { render json: @adress, status: :created, location: @adress }
      else
        format.html { render action: "new" }
        format.json { render json: @adress.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /adresses/1
  # PUT /adresses/1.json
  def update
    @adress = Adress.find(params[:id])

    respond_to do |format|
      if @adress.update_attributes(params[:adress])
        format.html { redirect_to @adress, notice: 'Adress was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @adress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adresses/1
  # DELETE /adresses/1.json
  def destroy
    @adress = Adress.find(params[:id])
    @adress.destroy

    respond_to do |format|
      format.html { redirect_to adresses_url }
      format.json { head :no_content }
    end
  end
end
