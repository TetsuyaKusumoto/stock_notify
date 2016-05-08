class StockMailer < ApplicationMailer
  default from: :mail_address

  def sendmail_stocks(stocks)
    @stocks = stocks
    mail(to: "tetsuya.kusumoto@gmail.com",
         from: "service@example.com",
         subject: "通知メール")
  end
end
