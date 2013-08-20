# coding: utf-8
class AuthenticationsController < DeviseController
  before_filter :authenticate_user!, :except => [:create, :failure]

  def index
    @meta_title = I18n.t("devise_russian.my_authentications")
    @authentications = current_user.authentications
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'].to_s)
    if authentication
      flash[:notice] = I18n.t("devise.sessions.signed_in")
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.apply_omniauth(omniauth, false)
      current_user.save
      flash[:notice] = I18n.t("devise.sessions.signed_already")
      redirect_to authentications_url
    else
      @user = User.new
      @user.apply_omniauth(omniauth, true)
      if @user.save
        flash[:notice] = I18n.t("devise.confirmations.send_instructions")
        sign_in_and_redirect(:user, @user)
      else
        session[:omniauth] = omniauth.except('extra')
        render :controller => "registrations", :template => "devise/registrations/new"
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find_by_id(params[:id])
    if @authentication
      @authentication.destroy
      flash[:notice] = I18n.t("devise.sessions.signed_out")
      redirect_to authentications_url
    else
      flash[:error] = I18n.t("devise_russian.authentication_not_found")
      redirect_to "/"
    end
  end

  def failure
    redirect_to devise_russian.new_user_session_url
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  protected

  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end
end
