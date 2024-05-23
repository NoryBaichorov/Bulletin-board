# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  before_action :authenticate_user!

  def index
    @bulletins = Bulletin.under_moderate_bulletins
    params[:active_link] = 'moderate'
  end
end
