# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  private

  def resource_category
    @category = Category.find(params[:id])
  end
end
