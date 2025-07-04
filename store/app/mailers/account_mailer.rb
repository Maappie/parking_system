class AccountMailer < ApplicationMailer
  default from: "renzmapa0321@gmail.com"   # use your Gmail here

  # account: an object with a username/email property (can be OpenStruct or Account)
  # code: the verification code (string)
  def verification_email(account, code)
    @account = account
    @code = code
    mail(to: @account.username, subject: "Your Verification Code")
  end
end
