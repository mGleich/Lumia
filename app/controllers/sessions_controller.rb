class SessionsController < ApplicationController
  force_ssl
# GET /sessions/new
# GET /sessions/new.json
  def new
  end
  #Dieser Controller überprüft die Eingegebenen Bentuzerdaten

  # POST /sessions
  # POST /sessions.json
  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
        redirect_to clients_path, :notice => "Sie haben sich angemeldet!"
    else
      flash.now.alert = "Fehlerhafte Benutzername oder Passwort"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "Sie haben sich abgemeldet!"
  end
end
