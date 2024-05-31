# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include AuthConcern
  include Pundit::Authorization

  helper_method :signed_in?, :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:danger] = t('authorization.unauthorized')
    redirect_back(fallback_location: root_path)
  end

  # Решил оставить здесь, т.к используется и в Web::Bulletins и в Web::Admin::Bulletins
  def set_bulletin
    @bulletin = Bulletin.find params[:id]
  end
end
