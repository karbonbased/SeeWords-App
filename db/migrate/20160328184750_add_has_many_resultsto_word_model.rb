class AddHasManyResultstoWordModel < ActiveRecord::Migration
  def change
  	add_reference :results, :word, index: true
  end
end
