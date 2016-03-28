class ChangeResultsTable < ActiveRecord::Migration
  def change
  	change_table :results do |t|
  t.remove :words
  t.string :associations
	end
end

end
