class PeopleController < ApplicationController
  def index
    @user_contacts = UserContact.all.order("id desc")
  end
end
