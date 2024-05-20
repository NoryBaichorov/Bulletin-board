# frozen_string_literal: true

class AddAdmins < ActiveRecord::Migration[7.1]
  def change
    User.find_by(email: 'nory.baichorov@gmail.com').update(admin: true)
  end
end
