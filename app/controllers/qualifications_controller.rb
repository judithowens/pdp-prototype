class QualificationsController < ApplicationController
    def new
        @qualification = Qualification.new()
        @method = 'Add'
        render 'qualifications_form'
    end

    def create
        @user = User.find(params[:user_id])
        @qualification = @user.qualifications.create(qualification_params)
        if @qualification.save
            redirect_to root_path
        else
            render 'qualifications_form'
        end
    end

    def edit
        @qualification = Qualification.find(params[:id])
        @method = 'Edit'
        render 'qualifications_form'
    end

    def update
        @qualification = Qualification.find(params[:id])
        if @qualification.update(qualification_params)
            redirect_to root_path
        else
            render 'qualifications_form'
        end
    end

    private
    def qualification_params
      params.require(:qualification).permit(:name, :awarded_date, :grade, :expiry_date, :details, :certificate)
    end
end
