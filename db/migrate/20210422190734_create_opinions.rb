# frozen_string_literal: true

class CreateOpinions < ActiveRecord::Migration[6.1] # rubocop:todo Style/Documentation
  def change
    create_table :opinions do |t|
      t.references :user, foreign_key: true
      t.text :text

      t.timestamps
    end
  end
end
