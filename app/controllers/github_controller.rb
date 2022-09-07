class GithubController < ApplicationController
  def index
    @client = Octokit::Client.new(access_token: current_user.access_token)
    @repos = @client.repos
  end

  def new
    @user = current_user
    @category = Category.new
    @client = Octokit::Client.new(access_token: current_user.access_token)
    puts "retrieving"
    @files = @client.contents("#{@client.user.login}/#{params[:repo]}").map { |x| x.path }
  end

  def create
    @client = Octokit::Client.new(access_token: current_user.access_token)
    gh_path = gh_params
    gh_object = @client.contents("#{@client.user.login}/#{gh_path[:repo]}", path: "#{gh_path[:path]}")
    SourceCodeParser.parse_gh(gh_object, params, current_user)
    redirect_to categories_path, notice: "File successfully uploaded"
  end

  private

  def cat_params
    params.require(:category).permit(:name, :category_type)
  end

  def file_params
    params.require(:source_code)
  end

  def gh_params
    params.permit(:path, :repo)
  end

end
