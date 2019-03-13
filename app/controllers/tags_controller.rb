class TagsController < ApplicationController

  before_action :set_tag, only: %i[show edit update destroy]

  def show
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tag_path
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to @tag.document
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:count)
  end

end
