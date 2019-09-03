class AddExpiresAtToAuthenticationToken < ActiveRecord::Migration[6.0]
  class AuthenticationToken < ApplicationRecord
  end

  def up
    add_column :authentication_tokens, :expires_at, :datetime

    AuthenticationToken.update_all(expires_at: Time.zone.now + 1.day)

    change_column :authentication_tokens, :expires_at, :datetime, null: false
  end

  def down
    remove_column :authentication_tokens, :expires_at
  end
end
