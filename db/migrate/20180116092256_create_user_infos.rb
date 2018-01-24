class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.string :token
      t.string :expires_in
      t.string :token_type
      t.string :scope
      t.string :refresh_token
      t.string :last_authenticated
      
      t.string :rider_id
      t.string :picture
      t.string :first_name
      t.string :last_name
      t.string :promo_code
      t.string :email
      t.string :mobile_verified
      t.string :uuid

      t.timestamps
    end
  end
end
