class UsersController < ApplicationController
  def index
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        #Tell the UserMailer to send a welcome email after save
        UserMailer.with(user: @user).welcome_email.deliver_later

        format.html { redirect_to(@user, notice: "User was successsfully created")}
        format.json { render json: @user, status: :created, location: @user}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
