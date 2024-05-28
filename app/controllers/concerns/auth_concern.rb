# frozen_string_literal: true

module AuthConcern
  def authenticate_user!
    return if signed_in?

    flash[:danger] = t('authorization.unauthorized')
    redirect_back(fallback_location: root_path)
  end

  def authenticate_admin!
    return if current_user&.admin?

    flash[:danger] = t('authorization.not_admin')
    redirect_back(fallback_location: root_path)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    session.clear
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end
end
