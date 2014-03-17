class ClientsController < ApplicationController

  force_ssl
  # sorgt dafür das keine Funktionen ohne Login ausgeführt werden
  before_filter :require_login
  # HelferMothoden zum Sortieren
  helper_method :sort_column, :sort_direction

  # GET /clients
  # GET /clients.json
  def index
    #aufruf dient der Suchfunktion und der Erweiterung durch Seitenaufteilung sowie Sortierung
    @clients = Client.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])
    #späterer Funktionsaufruf um neue Adressen zu erzeugen
    create_adresses

    if (params[:numbers_of_client] != nil)
      params[:numbers_of_client].each do |number|
        @number = @client.telenumbers_of_clients.build()
        @number.number = number
        @number.save
      end
    end

    if (params[:emails_of_client]!= nil)
      params[:emails_of_client].each do |email|
        @email = @client.emails_of_clients.build()
        @email.email = email
        @email.save
      end
    end


    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Der Klient wurde erfolgreich angelegt' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])

    @client.adresses.clear
    create_adresses

    @client.telenumbers_of_clients.clear
    if (params[:numbers_of_client] != nil)
      params[:numbers_of_client].each do |number|
        @number = @client.telenumbers_of_clients.build()
        @number.number = number
        @number.save
      end
    end

    @client.emails_of_clients.clear
    if (params[:emails_of_client]!= nil)
      params[:emails_of_client].each do |email|
        @email = @client.emails_of_clients.build()
        @email.email = email
        @email.save
      end
    end

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Die Daten des Klienten wurden erfolgreich aktualisiert' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.adresses.each do |adress|
      adress.destroy
    end
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end

  def events_to_client
    @events = Event.where(:client_id => params[:id]).paginate(:per_page => 15, :page => params[:page])
    @client = Client.find(params[:id])
  end

  #Funktion um die Adressen zu erzeugen
  def create_adresses
    #Hier wird aus eine Sammlung an Teilregeln aus params extrahiert und abgearbeitet/erstellt
    adresses = params.select { |key, value| key.to_s.match(/^adress\d+/) } #regausdruck nochmal nachschauen ausprobieren mit über zehn adressen

    #Befinden sich in der Regel keine Teilregeln handelt es sich um eine Regel vom Typ Sofortige Regel
    if adresses.length != 0
      adresses.each do |adress|  #each.value   #schauen ob man die params ohne Konvertierung übergeben kann.
        @adress = @client.adresses.build(street: adress[1][:street], house_number: adress[1][:house_number], zipcode: adress[1][:zipcode].to_i, city: adress[1][:city], comment: adress[1][:comment])
      end
    end
  end

  private

  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  #Sortierfolge
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end

