class DocumentsController < ApplicationController

  rescue_from Errno::ENOENT, with: :rescue_with_incorrect_url

  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def create 
    @document = Document.create(document_params)
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
  end

  private

  def document_params
    params.require(:document).permit(:url)
  end

  def rescue_with_incorrect_url
    render plain: 'Incorrect URL.'
  end

end
