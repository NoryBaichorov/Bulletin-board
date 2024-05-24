# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @query = current_user.bulletins.ransack(params[:query])

    @bulletins = @query.result.page(params[:page]).per(5)
  end
end
