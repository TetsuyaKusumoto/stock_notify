class Stock < ActiveRecord::Base

  def exist?(code)
    Stock.find_by(code: code)
  end
  def updated_before_oneyear?
    # 時刻を比較し1年以上前かどうか
    updated_at < DateTime.now.prev_year
  end



end
