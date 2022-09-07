class GithubController < ApplicationController
  def new
    @user = current_user
    @category = Category.new
    @client = Octokit::Client.new(access_token: current_user.access_token)
  end

  def create
    @gh_file = @client.contents("jrhome/rails-watch-list", path: 'app/models/movie.rb')
    @code = Base64.decode64(@gh_file.content)
    @file_name = @gh_file.name

    uploaded_file = file_params  #change this to upload github stuff
    SourceCodeParser.parse_file(uploaded_file, params, current_user)
    redirect_to categories_path, notice: "File successfully uploaded"

    # @repositories = @client.repositories
    # @repositories.each {|x| x.contents_url.to_s.sub("{+path}","") }
  end

  private

  def cat_params
    params.require(:category).permit(:name, :category_type)
  end

  def file_params
    params.require(:source_code)
  end

end
