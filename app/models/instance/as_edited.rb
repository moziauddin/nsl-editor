# frozen_string_literal: true
#   Copyright 2015 Australian National Botanic Gardens
#
#   This file is part of the NSL Editor.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
class Instance::AsEdited < Instance
  def update_if_changed(params, username)
    logger.debug("Update if changed for params: #{params}")
    assign_attributes(clean_all(params))
    if changed?
      logger.debug("Instance has changes to: #{changed}")
      self.updated_by = username
      self.extra_primary_override = params[:extra_primary_override] == "1"
      save!
      "Updated"
    else
      "No change"
    end
  rescue => e
    logger.error("Instance::AsEdited with params: #{params}")
    logger.error("Instance::AsEdited with params: #{e}")
    raise
  end

  private

  # Prevent empty or blank-filled params being treated as changes to empty
  # columns.
  def clean(param)
    if param == ""
      nil
    elsif param.nil?
      nil
    elsif param.rstrip == ""
      nil
    else
      param
    end
  end

  def clean_all(params)
    params.each do |key, value|
      params[key] = clean(value)
    end
  end
end
