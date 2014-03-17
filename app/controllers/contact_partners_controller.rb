class ContactPartnersController < ApplicationController
  force_ssl
  before_filter :require_login
  # GET /contact_partners
  # GET /contact_partners.json
  def index
    @contact_partners = ContactPartner.all
    @contact_partners = ContactPartner.paginate(:per_page => 15, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contact_partners }
    end
  end

  # GET /contact_partners/1
  # GET /contact_partners/1.json
  def show
    @contact_partner = ContactPartner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact_partner }
    end
  end

  # GET /contact_partners/new
  # GET /contact_partners/new.json
  def new
    @contact_partner = ContactPartner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact_partner }
    end
  end

  # GET /contact_partners/1/edit
  def edit
    @contact_partner = ContactPartner.find(params[:id])
  end

  # POST /contact_partners
  # POST /contact_partners.json
  def create
    @contact_partner = ContactPartner.new(params[:contact_partner])

    respond_to do |format|
      if @contact_partner.save
        format.html { redirect_to @contact_partner, notice: 'Ansprechpartner wurde erfolgreich erzeugt' }
        format.json { render json: @contact_partner, status: :created, location: @contact_partner }
      else
        format.html { render action: "new" }
        format.json { render json: @contact_partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contact_partners/1
  # PUT /contact_partners/1.json
  def update
    @contact_partner = ContactPartner.find(params[:id])

    respond_to do |format|
      if @contact_partner.update_attributes(params[:contact_partner])
        format.html { redirect_to @contact_partner, notice: 'Ansprechpartner wurde erfolgreich bearbeitet.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact_partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_partners/1
  # DELETE /contact_partners/1.json
  def destroy
    @contact_partner = ContactPartner.find(params[:id])
    @contact_partner.destroy

    respond_to do |format|
      format.html { redirect_to contact_partners_url }
      format.json { head :no_content }
    end
  end
end
