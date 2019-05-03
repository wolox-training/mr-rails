class UserMailer < ActionMailer::Base
  default from: 'wbooksapi-27@wolox.com.ar'
  def notice_email(rent)
    @rent = rent
    user = User.find(rent.user_id)
    @book = Book.find(rent.book_id)
    I18n.with_locale(user.locale) do
      mail(to: user.email, subject: I18n.t('user_mailer.notice_email.subject'))
    end
  end

  def expiration_email(rent)
    @rent = rent
    user = User.find(rent.user_id)
    @book = Book.find(rent.book_id)
    I18n.with_locale(user.locale) do
      mail(to: user.email, subject: I18n.t('user_mailer.expiration_email.subject'))
    end
  end
end
