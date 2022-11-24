class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :texts, :chanded_on, :changed_on
  end
end
