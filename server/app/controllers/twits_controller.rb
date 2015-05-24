class TwitsController < ActionController::Base
  rescue_from Twit::DuplicatedException, with: :duplicated_twit

  # Creates a new twit
  # Try to find the author using her twitter_id, or create a new author, using
  # the contents of the author request param.
  # If there's an error while saving the twit, return a 422 response.
  def create
    @author = Author.find_or_initialize_by(twitter_id: author_params[:twitter_id]) do |author|
      author.assign_attributes(author_params)
    end

    unless @author.save
      return render json: {errors: @author.errors}, status: :unprocessable_entity
    end

    @twit = @author.twits.build(twit_params)

    if @twit.save
      render json: @twit
    else
      render json: {errors: @twit.errors}, status: :unprocessable_entity
    end
  end

  private

    # If the Twit already exists, return a 409 (Conflict) status code.
    def duplicated_twit(exception)
      render json: {errors: 'Twit already exists'}, status: :conflict
    end

    # Define the allowed params for the Twit model
    def twit_params
      params.require(:twit).permit(:origin_id, :body, :twit_date)
    end

    # Define the allowed params for the Author model
    def author_params
      params[:twit].require(:author).permit(:twitter_id, :screen_name, :name)
    end

end
