class DocumentsController < ApplicationController

  before_action :set_document, only: %i[show destroy]

  rescue_from Errno::ENOENT, with: :rescue_with_incorrect_url
  rescue_from RuntimeError, with: :rescue_standard_errors

  def index
    @documents = Document.order(:url).page(params[:page])
  end

  def new
    @document = Document.new
  end

  def create 
    @document = Document.new(document_params)
    TagCountingService.new(@document).call    

    if @document.save
      redirect_to document_path(@document)
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @document.destroy
    redirect_to documents_path
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:url)
  end

  def rescue_with_incorrect_url
    redirect_to documents_path, notice: '#Incorrect URL.'
  end

  def rescue_standard_errors
    redirect_to documents_path, notice: 'Incorrect URL.'
  end

end
