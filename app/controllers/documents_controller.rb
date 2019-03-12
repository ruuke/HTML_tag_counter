class DocumentsController < ApplicationController

  before_action :set_document, only: %i[show destroy]

  rescue_from Errno::ENOENT, with: :rescue_with_incorrect_url
  rescue_from StandardError, with: :rescue_standard_errors

  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def create 
    @document = Document.new(document_params)
    TagCountingService.new(@document).call    

    if @document.save
      redirect_to documents_path
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
    render plain: 'Incorrect URL.'
  end

  def rescue_standard_errors
    render plain: 'ooooo'
  end

end
