require "ostruct"

class AccountsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    # Do NOT save to database yet!
    session[:pending_account] = account_params
    code = rand(100000..999999).to_s
    session[:verification_code] = code
    session[:verification_code_expires_at] = 3.minutes.from_now

    # Send verification code email using OpenStruct (since no Account exists yet)
    AccountMailer.verification_email(OpenStruct.new(username: account_params[:username]), code).deliver_now
    redirect_to verify_accounts_path, notice: "Check your email for the verification code."
  end

  def verify
    # Just render the verification form
    @account = Account.new(session[:pending_account])
  end

  def process_verification
    input_code = params[:verification_code]

    if session[:verification_code_expires_at].nil? || Time.current > session[:verification_code_expires_at]
      flash.now[:alert] = "Verification code has expired. Please sign up again."
      render :verify, status: :unprocessable_entity
    elsif input_code == session[:verification_code]
      @account = Account.new(session[:pending_account])
      @account.verified = true
      if @account.save
        # Clean up session data
        session.delete(:pending_account)
        session.delete(:verification_code)
        session.delete(:verification_code_expires_at)
        redirect_to root_path, notice: "Account verified and created!"
      else
        flash.now[:alert] = "Failed to create account: #{@account.errors.full_messages.join(', ')}"
        render :verify, status: :unprocessable_entity
      end
    else
      @account = Account.new(session[:pending_account])
      flash.now[:alert] = "Invalid verification code."
      render :verify, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:car_model, :car_type, :plate_number, :username, :password, :password_confirmation)
  end

end
