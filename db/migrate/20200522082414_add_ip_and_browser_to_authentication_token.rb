class AddIpAndBrowserToAuthenticationToken < ActiveRecord::Migration[6.0]
  class AuthenticationToken < ApplicationRecord
  end

  def up
    add_column :authentication_tokens, :ip, :inet
    AuthenticationToken.update_all(ip: '::1')

    change_column :authentication_tokens, :ip, :inet, null: false
    add_column :authentication_tokens, :browser, :string
  end

  def down
    remove_column :authentication_tokens, :ip
    remove_column :authentication_tokens, :browser
  end
end
