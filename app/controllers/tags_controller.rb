class TagsController < ApplicationController

  before_action :set_tag, only: %i[show edit update destroy]
  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @tag.destroy
    redirect_to @tag.document
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

end
