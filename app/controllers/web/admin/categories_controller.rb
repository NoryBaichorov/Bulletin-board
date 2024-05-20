# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all
  end

  def show
    resource_category
  end

  def new
    @category = Bulletin.new
  end

  def edit; end

  def create
    @category = category.new(bulletin_params.merge(user_id: current_user.id))

    if @category.save
      flash[:primary] = t('bulletins.create.success')
      redirect_to @category
    else
      redirect_back(fallback_location: new_bulletin_path)
      flash[:danger] = @category.errors.full_messages.to_sentence
    end
  end

  def update; end

  def destroy; end

  private

  def resource_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
