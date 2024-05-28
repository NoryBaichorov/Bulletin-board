# frozen_string_literal: true

class RemoveAllUsersAddIndexAddAdmins < ActiveRecord::Migration[7.1]
  def change
    User.destroy_all

    add_index :users, :email, unique: true

    User.create(email: 'nory.baichorov@gmail.com', admin: true, name: 'Nory')
    User.create(email: 'vasiliqa13@gmail.com', admin: true, name: 'Vasilisa')
  end
end
