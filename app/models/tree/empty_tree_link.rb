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

#   A tree link identifies a placement in a tree.
class Tree::EmptyTreeLink < ActiveRecord::Base
  self.table_name = "tree_link"
  self.primary_key = "id"
  self.sequence_name = "nsl_global_seq"
  default_scope { where("2 = 3") }

  def empty?
    true
  end

  def supernode
    nil
  end

  def subnode
    nil
  end

  def placed?
    false
  end

  def placed_via_instance?(_instance)
    false
  end

  def placed_as
    "not placed"
  end

  def accepted?
    false
  end

  def excluded?
    false
  end

  def untreated?
    false
  end

  def default_to_accepted?
    true
  end

  def default_to_excluded?
    false
  end

  def default_to_untreated?
    false
  end

  def placed_via_instance?(_instance)
    false
  end
end
