# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.ordered_bulletins
  end

  def show
    resource_bulletin
  end

  def new
    @bulletin = Bulletin.new
  end

  def edit; end

  def create
    @bulletin = Bulletin.new(bulletin_params.merge(user_id: current_user.id))

    if @bulletin.save
      flash[:primary] = t('bulletins.create.success')
      redirect_to @bulletin
    else
      redirect_back(fallback_location: new_bulletin_path)
      flash[:danger] = @bulletin.errors.full_messages.to_sentence
    end
  end

  def update; end

  def destroy; end

  private

  def resource_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id, :user_id)
  end
end
