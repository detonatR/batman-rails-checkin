class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.string :email
      t.integer :project_id

      t.timestamps
    end
  end
end
