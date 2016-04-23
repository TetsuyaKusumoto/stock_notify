class RennameSahresColumnToStocks < ActiveRecord::Migration
  def change
    rename_column :stocks, :sahres_issued, :shares_issued
  end
end
