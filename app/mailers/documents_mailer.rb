class DocumentsMailer < ApplicationMailer
  def created_document(document)
    @user = document.user
    @document = document.url
    mail to: @user.email
  end
end
