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
class Search::OnAuthor::WhereClauses

  attr_reader  :sql

  def initialize(parsed_request, incoming_sql)
    @parsed_request = parsed_request
    @sql = incoming_sql
    build_sql
  end

  def build_sql
    Rails.logger.debug("Search::OnAuthor::WhereClause.sql")
    remaining_string = @parsed_request.where_arguments.downcase 
    @common_and_cultivar_included = @parsed_request.common_and_cultivar
    @sql = @sql.for_id(@parsed_request.id) if @parsed_request.id
    x = 0 
    until remaining_string.blank?
      field,value,remaining_string = Search::NextCriterion.new(remaining_string).get 
      Rails.logger.info("field: #{field}; value: #{value}")
      add_clause(field,value)
      x += 1
      raise "endless loop #{x}" if x > 50
    end
  end

  def add_clause(field,value)
    if field.blank? && value.blank?
      @sql
    elsif field.blank? 
      @sql = @sql.lower_name_like("*#{value.downcase}*")
    else 
      # we have a field
      canonical_field = canon_field(field)
      canonical_value = value.blank? ? '' : canon_value(value)
      if ALLOWS_MULTIPLE_VALUES.has_key?(canonical_field) && canonical_value.split(/,/).size > 1
        case canonical_field
        when /\Aname-rank:\z/
          @sql = @sql.where("name_rank_id in (select id from name_rank where lower(name) in (?))",canonical_value.split(',').collect {|v| v.strip})
        else
          raise "The field '#{field}' currently cannot handle multiple values separated by commas." 
        end
      elsif WHERE_ASSERTION_HASH.has_key?(canonical_field)
        @sql = @sql.where(WHERE_ASSERTION_HASH[canonical_field])
      elsif FIELD_NEEDS_WILDCARDS.has_key?(canonical_field)
        @sql = @sql.where(FIELD_NEEDS_WILDCARDS[canonical_field],"%#{canonical_value}%")
      elsif WHERE_INTEGER_VALUE_HASH.has_key?(canonical_field)
        @sql = @sql.where(WHERE_INTEGER_VALUE_HASH[canonical_field],canonical_value.to_i)
      else
        raise "No way to handle field: '#{canonical_field}' in an author search." unless WHERE_VALUE_HASH.has_key?(canonical_field)
        @sql = @sql.where(WHERE_VALUE_HASH[canonical_field],canonical_value)
      end
    end
  end

  def canon_value(value)
    value.gsub(/\*/,'%')
  end

  def canon_field(field)
    if WHERE_INTEGER_VALUE_HASH.has_key?(field)
      field
    elsif WHERE_ASSERTION_HASH.has_key?(field)
      field
    elsif FIELD_NEEDS_WILDCARDS.has_key?(field)
      field
    elsif WHERE_VALUE_HASH.has_key?(field)
      field
    elsif CANONICAL_FIELD_NAMES.has_value?(field)
      field
    elsif CANONICAL_FIELD_NAMES.has_key?(field)
      CANONICAL_FIELD_NAMES[field]
    else
      raise "Cannot search authors for: #{field}" unless CANONICAL_FIELD_NAMES.has_key?(field)
    end
  end

  WHERE_INTEGER_VALUE_HASH = { 
    'id:' => "id = ? ",
    'duplicate-of-id:' => "duplicate_of_id = ? "
  }

  WHERE_ASSERTION_HASH = { 
    'is-a-duplicate:' => " duplicate_of_id is not null",
    'is-not-a-duplicate:' => " duplicate_of_id is null"
  }

  FIELD_NEEDS_WILDCARDS = { 
    'name:' => "lower(name) like ?",
    'abbrev:' => "lower(abbrev) like ?"
  }

  WHERE_VALUE_HASH = { 
    'name-exact:' => "lower(name) like ?",
    'full-name:' => "lower(full_name) like ?",
    'abbrev-exact:' => "lower(abbrev) like ?",
    'comments:' => " exists (select null from comment where comment.author_id = author.id and comment.text like ?) ",
    'comments-by:' => " exists (select null from comment where comment.author_id = author.id and comment.created_by like ?) ",
    'notes:' => " lower(notes) like ? ",
    'ipni-id:' => "lower(ipni_id) like ?",
  }

  CANONICAL_FIELD_NAMES = {
    'n:' => 'name:',
    'a:' => 'abbrev:',
    'extra-name-text:' => 'full_name:'
  }

  ALLOWS_MULTIPLE_VALUES = {
    'ids:' => true
  }


end



