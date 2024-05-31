# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all
    params[:active_link] = 'categories'
  end

  def new
    @category = Category.new
  end

  def edit
    @category = set_category
  end

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
    @category = set_category

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
    @category = set_category

    if @category.bulletins.present?
      flash[:warning] = t('category.destroy.has_bulletins')
      redirect_back(fallback_location: admin_categories_path)
    else
      @category.destroy

      flash[:primary] = t('category.destroy.success')
      redirect_to admin_categories_path
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
