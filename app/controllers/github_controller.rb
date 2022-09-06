class GithubController < ApplicationController
  def new
    @user = current_user
    @client = Octokit::Client.new(access_token: current_user.access_token)
  end

  def create
    @client.repo_all
  end
end
