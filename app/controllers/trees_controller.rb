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

#   Trees are classification graphs for taxa.
#   There are several types of trees - see the model.
class TreesController < ApplicationController
  def index
  end

  def ng
    render "trees/#{params[:template]}", layout: false
  end

  # Move name ....
  # Update name ....
  def place_name
    @placement = Tree::Workspace::Placement.new(
      username: current_user.username,
      name_id: place_name_params[:name_id],
      instance_id: place_name_params[:instance_id],
      parent_name_id: place_name_params[:parent_name_id],
      parent_name_typeahead: place_name_params[:parent_name_typeahead_string],
      placement_type: place_name_params[:placement_type],
      workspace_id: @current_workspace.id)
    if placement_changed?(place_name_params)
      @placement.save 
      @message = "Changed"
    else
      @message = "No change"
    end
  rescue => e
    begin
      @message = JSON.parse(first_error.response)["msg"]["msg"]
    rescue
      @message = e.to_s
    end
    logger.error "place_name error @message: #{@message}"
    render "place_name_error", status: 422
  end

  def remove_name_placement
    @response = @current_workspace
                .remove_instance(username,
                                 remove_name_placement_params[:name_id])
  rescue => e
    logger.error("remove_name_placement error: #{e}")
    # e.backtrace.each { |trace| logger.error trace }
    @message = e.to_s
    render "remove_name_placement_error", status: 422
  end
 
  def xupdate_value
    @response = TreeArrangement.find(session[:current_classification])
                               .update_value(
                                 username,
                                 params[:tree_arrangement][:name_id],
                                 params[:tree_arrangement][:value_label],
                                 params[:value]
                               )
  rescue => e
    logger.error e
    render "update_value_error", status: 422
  end

  def update_value
    logger.debug('start update_value')
    logger.debug("params[:tree_workspace][:name_id]: #{params[:tree_workspace][:name_id]}")
    logger.debug("params[:tree_workspace][:value_label]: #{params[:tree_workspace][:value_label]}")
    logger.debug("params[:value]: #{params[:value]}")
    logger.debug('update_value before call')
    @response = @current_workspace.update_value(
                                 username,
                                 params[:tree_workspace][:name_id],
                                 params[:tree_workspace][:value_label],
                                 params[:value]
                               )
  rescue => e
    logger.error e
    render "update_value_error", status: 422
  end

  private

  def place_name_params
    params.require(:place_name).permit(:name_id,
                                       :instance_id,
                                       :parent_name,
                                       :parent_name_id,
                                       :parent_name_typeahead_string,
                                       :placement_type,
                                       :move,
                                       :update,
                                       :original_name_id,
                                       :original_instance_id,
                                       :original_parent_name_id,
                                       :original_parent_name_typeahead_string,
                                       :original_placement_type)
  end

  def remove_name_placement_params
    params.require(:remove_placement).permit(:name_id, :instance_id, :delete)
  end

  def placement_changed?(params)
    params[:name_id] != params[:original_name_id] ||
    params[:instance_id] != params[:original_instance_id] ||
    params[:placement_type] != params[:original_placement_type] ||
    params[:parent_name_typeahead_string] != params[:original_parent_name_typeahead_string] ||
    params[:parent_name_id] != params[:original_parent_name_id]
  end
end

