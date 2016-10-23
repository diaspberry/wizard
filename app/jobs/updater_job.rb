class UpdaterJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    git = Rails.application.config.diaspora[:git]
    wd = Rails.application.config.diaspora[:directory]

    unless git.nil?
      git.fetch # update tags
      git.pull("origin", "master")
    end

    Bundler.with_clean_env do
      `BUNDLE_GEMFILE=#{wd}/Gemfile bundle install`
      #if $?.exitstatus == 0
      #  render json: {success: true}
      #else
      #  render json: {success: false}
      #end
    end
  end
end
