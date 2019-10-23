class UsersController < ApplicationController
    def show
        id = params[:id].present? ? params[:id] : current_user.id
        @user = User.find(id)
        @qualifications = @user.qualifications
        @role = @user.role.present? ? @user.role.name : "No role set"
    end
end
