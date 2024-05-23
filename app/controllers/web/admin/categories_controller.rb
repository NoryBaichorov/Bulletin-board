# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all
    params[:active_link] = 'categories'
    authorize Category
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
    authorize resource_category
  end

  def create
    @category = Category.new(category_params)

    authorize @category

    Rails.logger.debug '==============================='
    if @category.save
      flash[:primary] = t('category.create.success')
      redirect_to admin_categories_path
    else
      redirect_back(fallback_location: new_admin_category_path)
      flash[:danger] = @category.errors.full_messages.to_sentence
    end
  end

  def update
    authorize resource_category

    resource_category.update(category_params)

    if resource_category.save
      flash[:primary] = t('category.update.success')
      redirect_to resource_category
    else
      redirect_back(fallback_location: edit_admin_category_path)
      flash[:danger] = resource_category.errors.full_messages.to_sentence
    end
  end

  def destroy
    authorize resource_category

    resource_category.destroy

    flash[:primary] = t('category.destroy.success')
    redirect_back(fallback_location: admin_categories_path)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
