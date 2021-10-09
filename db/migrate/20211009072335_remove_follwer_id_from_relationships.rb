class RemoveFollwerIdFromRelationships < ActiveRecord::Migration[5.2]
  def change
    remove_column :relationships, :follwer_id, :integer
  end
end
