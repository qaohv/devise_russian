# coding: utf-8
class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource
    render :new
  end

  def edit
    redirect_to edit_dashboard_user_path
  end

  def create
    build_resource
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

  def after_update_path_for(scope)
    session[:referrer] ? session[:referrer] : root_path
  end
end
