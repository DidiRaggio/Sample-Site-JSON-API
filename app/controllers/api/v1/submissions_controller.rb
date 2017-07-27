class Api::V1::SubmissionsController < ApplicationController
  before_action :authenticate_with_token!
  respond_to :json

  def index
  	if current_user.is_dev != false
    	respond_with current_user.submissions
	else
		respond_with current_user.received_submissions
		# respond_with submissions: current_user.submissions, received_submissions: current_user.received_submissions
	end
  end

	def show
	  	if current_user.is_dev != false
	    	respond_with current_user.submissions.find(params[:id])
		else
			respond_with current_user.received_submissions.find(params[:id])
		end
	end

	def create
		if current_user.is_dev?
		  # submission = current_user.submissions.build(submission_params.except(:is_approved, :feedback))
		  submission = current_user.submissions.build(dev_submission_params)

		  if submission.save
		    render json: submission, status: 201, location: [:api, current_user, submission]
		  else
		    render json: { errors: submission.errors }, status: 422
		  end
		else
			 render json: { errors: "Sorry, only developers can create submissions" }, status: 422
		end
	end

	def update
		if current_user.is_dev?
		    submission = current_user.submissions.find(params[:id])
		    if submission.update(dev_update_submission_params)
		      render json: submission, status: 200, location: [:api, current_user, submission]
		    else
		      render json: { errors: submission.errors }, status: 422
		    end	
		else
		    submission = current_user.received_submissions.find(params[:id])
		    if submission.update(influencer_update_submission_params)
		      render json: submission, status: 200, location: [:api, current_user, submission]
		    else
		      render json: { errors: submission.errors }, status: 422
		    end
		end	
	end

	def destroy
	    submission = current_user.submissions.find(params[:id])
	    submission.destroy
	    head 204
	end

	private

	  def dev_update_submission_params
	    params.require(:submission).permit(:dev_note)
	  end

	  def dev_submission_params
	    params.require(:submission).permit(:dev_id, :influencer_id, :pitch_id, :dev_note)
	  end

	  def influencer_update_submission_params
	    params.require(:submission).permit(:is_approved, :feedback )
	  end

end
