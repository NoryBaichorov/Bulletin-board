# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.under_moderation
    params[:active_link] = 'moderate'
  end
end
