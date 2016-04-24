class StockMailer < ApplicationMailer
  default from: :mail_address

  def sendmail_stock(hoge)
    @hoge = hoge
    mail to: "tetsuya.kusumoto@gmail.com"
  end
end
