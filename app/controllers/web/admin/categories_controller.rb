# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  before_action :resource_category, only: %i[edit update destroy]

  def index
    @categories = Category.all
    params[:active_link] = 'categories'
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:primary] = t('category.create.success')
      redirect_to admin_categories_path
    else
      flash[:danger] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category.update(category_params)

    if @category.save
      flash[:primary] = t('category.update.success')
      redirect_to admin_categories_path
    else
      flash[:danger] = @category.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy

    flash[:primary] = t('category.destroy.success')
    redirect_back(fallback_location: admin_categories_path)
  end

  private

  def resource_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
