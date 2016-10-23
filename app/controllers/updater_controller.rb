# Diaspberry Wizard
#
# Copyright (C) 2016 Lukas Matt <lukas@zauberstuhl.de>,
# Matthias Neutzner <matthias.neutzner@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class UpdaterController < ApplicationController
  include UpdaterHelper

  def check
    git = Rails.application.config.diaspora[:git]
    version = Gem::Version.new(latest_diaspora_version)
    installed = git.tags.last.name.sub(/^v/, '')

    if version > Gem::Version.new(installed)
      render json: {update: true, version: version.version}
    else
      render json: {update: false}
    end
  end

  def update
    UpdaterJob.perform_now
    render :index
  end
end
