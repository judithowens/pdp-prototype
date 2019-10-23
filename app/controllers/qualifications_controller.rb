class QualificationsController < ApplicationController
    def new
        @qualification = Qualification.new()
    end

    def create
        @user = User.find(params[:user_id])
        @qualification = @user.qualifications.create(qualification_params)
        if @qualification.save!
            redirect_to root_path
        end
    end

    private
    def qualification_params
      params.require(:qualification).permit(:name, :awarded_date, :grade, :expiry_date, :details, :certificate)
    end
end
