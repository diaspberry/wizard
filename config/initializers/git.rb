directory = Rails.application.config.diaspora[:directory]
Rails.application.config.diaspora[:git] = Git.open(directory)
