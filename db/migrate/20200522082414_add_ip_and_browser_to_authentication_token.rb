class AddIpAndBrowserToAuthenticationToken < ActiveRecord::Migration[6.0]
  class AuthenticationToken < ApplicationRecord
  end

  def up
    add_column :authentication_tokens, :browser, :string
    add_column :authentication_tokens, :ip, :inet
    add_column :authentication_tokens, :last_used_at, :datetime, default: -> { 'CURRENT_TIMESTAMP' }, null: false

    # Did you know? Adding a new column which cannot be null may cause issues if records exist in the table
    # But here I fill in those columns basic data so that in the future none developer needs to waste time wondering why this migration adding null: false columns crashes
    # If production database is huge it's worth making this migration concurrent :)
    AuthenticationToken.update_all(ip: '::1')

    change_column :authentication_tokens, :ip, :inet, null: false
  end

  def down
    remove_column :authentication_tokens, :browser
    remove_column :authentication_tokens, :ip
    remove_column :authentication_tokens, :last_used_at
  end
end
