class EmailsOfClientsController < ApplicationController
  before_filter :require_login
  # GET /emails_of_clients
  # GET /emails_of_clients.json
  def index
    @emails_of_clients = EmailsOfClient.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emails_of_clients }
    end
  end

  # GET /emails_of_clients/1
  # GET /emails_of_clients/1.json
  def show
    @emails_of_client = EmailsOfClient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @emails_of_client }
    end
  end

  # GET /emails_of_clients/new
  # GET /emails_of_clients/new.json
  def new
    @emails_of_client = EmailsOfClient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @emails_of_client }
    end
  end

  # GET /emails_of_clients/1/edit
  def edit
    @emails_of_client = EmailsOfClient.find(params[:id])
  end

  # POST /emails_of_clients
  # POST /emails_of_clients.json
  def create
    @emails_of_client = EmailsOfClient.new(params[:emails_of_client])

    respond_to do |format|
      if @emails_of_client.save
        format.html { redirect_to @emails_of_client, notice: 'Emails of client was successfully created.' }
        format.json { render json: @emails_of_client, status: :created, location: @emails_of_client }
      else
        format.html { render action: "new" }
        format.json { render json: @emails_of_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /emails_of_clients/1
  # PUT /emails_of_clients/1.json
  def update
    @emails_of_client = EmailsOfClient.find(params[:id])

    respond_to do |format|
      if @emails_of_client.update_attributes(params[:emails_of_client])
        format.html { redirect_to @emails_of_client, notice: 'Emails of client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @emails_of_client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails_of_clients/1
  # DELETE /emails_of_clients/1.json
  def destroy
    @emails_of_client = EmailsOfClient.find(params[:id])
    @emails_of_client.destroy

    respond_to do |format|
      format.html { redirect_to emails_of_clients_url }
      format.json { head :no_content }
    end
  end
end
