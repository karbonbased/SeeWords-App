class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
    	t.string :origin_word
    	t.string :result_word

    	t.timestamps null: false
    end
  end
end
