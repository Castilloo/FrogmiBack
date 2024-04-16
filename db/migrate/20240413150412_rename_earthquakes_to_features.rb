class RenameEarthquakesToFeatures < ActiveRecord::Migration[7.1]
  def change
    rename_table :earthquakes, :features
  end
end
