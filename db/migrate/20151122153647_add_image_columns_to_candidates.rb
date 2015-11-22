class AddImageColumnsToCandidates < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :candidates do |t|
        dir.up   { add_attachment :candidates, :image }
        dir.down { remove_attachment :candidates, :image }
      end
    end
  end
end
