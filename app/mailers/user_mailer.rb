class UserMailer < ActionMailer::Base
  default from: 'wbooksapi-27@wolox.com.ar'
  def notice_email(rent)
    @rent = rent
    user = User.find(rent.user_id)
    @book = Book.find(rent.book_id)
    mail(to: user.email, subject: 'Rent Notification')
  end
end
