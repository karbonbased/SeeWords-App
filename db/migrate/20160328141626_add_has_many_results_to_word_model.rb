class AddHasManyResultsToWordModel < ActiveRecord::Migration
  def change
  	add_reference :results, :words, index: true 
  end
end
