# autoload_pathで読み込んだものはRailsの命名規則に従ったクラス名などが読み込むことができる
class StockData
  def self.execute
    # 実行したいコードを書く
    p "Hello world"
  end
end
