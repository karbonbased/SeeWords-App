class AddUrllgColumnToResults < ActiveRecord::Migration
  def change
  	add_column :results, :url_lg, :string
  end
end
