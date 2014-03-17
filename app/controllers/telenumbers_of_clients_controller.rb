class TelenumbersOfClientsController < ApplicationController
  # GET /telenumbers_of_clients
  # GET /telenumbers_of_clients.json
  def index
    @telenumbers_of_clients = TelenumbersOfClient.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @telenumbers_of_clients }
    end
  end

  # GET /telenumbers_of_clients/1
  # GET /telenumbers_of_clients/1.json
  def show
    @telenumbers_of_client = TelenumbersOfClient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @telenumbers_of_client }
    end
  end

  # GET /telenumbers_of_clients/new
  # GET /telenumbers_of_clients/new.json
  def new
    @telenumbers_of_client = TelenumbersOfClient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @telenumbers_of_client }
    end
  end

  # GET /telenumbers_of_clients/1/edit
  def edit
    @telenumbers_of_client = TelenumbersOfClient.find(params[:id])
  end

  # POST /telenumbers_of_clients
  # POST /telenumbers_of_clients.json
  def create
    @telenumbers_of_client = TelenumbersOfClient.new(params[:telenumbers_of_client])

    respond_to do |format|
      if @telenumbers_of_client.save
        format.html { redirect_to @telenumbers_of_client, notice: 'Telenumbers of client was successfully created.' }
        format.json { render json: @telenumbers_of_client, status: :created, location: @telenumbers_of_client }
      else
        format.html { render action: "new" }
        format.json { render json: @telenumbers_of_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /telenumbers_of_clients/1
  # PUT /telenumbers_of_clients/1.json
  def update
    @telenumbers_of_client = TelenumbersOfClient.find(params[:id])

    respond_to do |format|
      if @telenumbers_of_client.update_attributes(params[:telenumbers_of_client])
        format.html { redirect_to @telenumbers_of_client, notice: 'Telenumbers of client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @telenumbers_of_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /telenumbers_of_clients/1
  # DELETE /telenumbers_of_clients/1.json
  def destroy
    @telenumbers_of_client = TelenumbersOfClient.find(params[:id])
    @telenumbers_of_client.destroy

    respond_to do |format|
      format.html { redirect_to telenumbers_of_clients_url }
      format.json { head :no_content }
    end
  end
end
