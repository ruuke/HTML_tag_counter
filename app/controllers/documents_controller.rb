class DocumentsController < ApplicationController

  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def create 
    @document = Document.create(document_params)
    if @document.save
      redirect_to documents_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
  end

  private

  def document_params
    params.require(:document).permit(:url)
  end

end
