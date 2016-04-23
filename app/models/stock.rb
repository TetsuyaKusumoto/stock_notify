class Stock < ActiveRecord::Base
  def self.get_stock_data
    ###　プログラム作成
    # 初期化情報
    p "初期化をはじめます"

    #poltergistの設定
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {:js_errors => false, :timeout => 1000 }) #追加のオプションはググってくださいw
    end
    Capybara.default_selector = :xpath
    session = Capybara::Session.new(:poltergeist)
    # トレーダーずWebの設定
    url_traders = 'http://www.traders.co.jp/domestic_stocks/domestic_market/new_price/new_price.asp?n_flg=2'
    charset = nil

    #自由にUser-Agent設定してください。
    session.driver.headers = { 'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X)" }

    # トレーダーズウェブ
    html_traders = open(url_traders) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end


    # 1日一回定時にプログラムが回る
    # 四季報オンラインを巡回する
    p "URLを巡回します"
    session.visit "http://shikiho.jp/tk/ranking/price/highlow/high/y10"
    # htmlをパース(解析)してコードを取り出す
    page = Nokogiri::HTML.parse(session.html)

    # htmlをパース(解析)してオブジェクトを生成
    page_traders = Nokogiri::HTML.parse(html_traders, nil, 'shift-jis')
    #p doc
    # タイトルを表示


    p "コードを取り出します"
    for i in 0..50 do
      code_html = page.xpath("//*[@id='rank_code_#{i}']")
      p code_html.text
      code = code_html.text
      if !code.empty?
        @stock = Stock.find_or_initialize_by(code: code)
        if @stock.new_record?
          yahoo_data = JpStock.quote(code: code)
          @stock.name = yahoo_data.company_name
          @stock.market = nil
          @stock.market_cap = yahoo_data.market_cap
          @stock.shares_issued = yahoo_data.shares_issued / 100
          @stock.dividend_yield = yahoo_data.dividend_yield
          @stock.dividend_one = yahoo_data.dividend_one
          @stock.per = yahoo_data.per
          @stock.pbr = yahoo_data.pbr
          @stock.eps = yahoo_data.eps
          @stock.bps = yahoo_data.bps
          @stock.years_high = yahoo_data.years_high
          @stock.years_high_date = nil
          @stock.years_low = yahoo_data.years_low
          @stock.years_low_date = nil

          p @stock
          @stock.save
        end
      else
        break
      end

        # yahooでスクレイピングして、保存
        # メール通知の内容を

      # トレーダースWebの更新日が今年の1/4
      html_traders = open(url_traders) do |f|
        charset = f.charset # 文字種別を取得
        f.read # htmlを読み込んで変数htmlに渡す
      end
      # yahooでの時価総額が100億以下
      # PERが60倍未満
    end
  end
  # CSVを取り出しておいて、年初来高値が2016/1/4
  # DBへ新規かアップデート
  # メール通知
end
