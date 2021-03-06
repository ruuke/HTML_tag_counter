class DocumentsController < ApplicationController

  before_action :set_document, only: %i[show destroy]

  rescue_from Errno::ENOENT, with: :rescue_with_incorrect_url
  rescue_from RuntimeError, with: :rescue_standard_errors
  rescue_from Exception, with: :rescue_500_error

  def index
    @documents = current_user.documents.page(params[:page])
  end

  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.new(document_params)
    TagCountingService.new(@document).call

    if @document.save
      DocumentsMailer.created_document(@document).deliver_now
      redirect_to document_path(@document), notice: 'Document successfully created.'
    else
      render :new
    end
  end

  def show
    @document_tags = @document.tags.page(params[:page])
  end

  def destroy
    @document.destroy
    redirect_to documents_path, notice: 'Document deleted.'
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:url)
  end

  def rescue_with_incorrect_url
    redirect_to documents_path, notice: 'Incorrect URL.'
  end

  def rescue_standard_errors
    redirect_to documents_path, notice: 'Protected URL.'
  end

  def rescue_500_error
    redirect_to documents_path, notice: '500 - Internal Server error.'
  end

end
