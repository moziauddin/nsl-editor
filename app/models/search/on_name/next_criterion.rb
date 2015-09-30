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
class Search::OnName::NextCriterion

  def initialize(criteria_string)
    @criteria_string = criteria_string
  end

  def get
    @tokens = @criteria_string.split(/ /)
    if first_is_a_field
      get_field
      get_value
    else
      @field = ''
      get_value
    end
    return @field,@value,@tokens.join(' ')
  end

  def first_is_a_field
    !!@tokens.first.match(/:/)
  end

  def get_field
    @field = @tokens.first
    @tokens = @tokens.drop(1)
  end

  # e.g. for ['a', 'b', 'c', 'd:', 'e','f'] 
  # @value = "a b c"
  # @tokens = "a b c"
  def get_value
    value = '' 
    found_field = false
    num = 0
    @tokens.each do |x| 
      found_field = true if x.match(/:/)
      unless found_field
        num += 1
        value = value += " #{x}" unless found_field 
      end
    end
    @value = value.strip
    @tokens = @tokens.drop(num)
  end

end



