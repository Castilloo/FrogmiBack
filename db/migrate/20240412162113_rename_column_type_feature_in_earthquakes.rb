class RenameColumnTypeFeatureInEarthquakes < ActiveRecord::Migration[7.1]
  def change
    rename_column :earthquakes, :type, :feature_type
  end
end
