object @search
attributes 	:name,
						:query,
						:sources,
						:relative_timestamp,
						:date_from,
						:time_from,
						:date_to,
						:time_to,
						:host_from,
						:host_to,
						:group_by,
						:sentinel_params

# child :search_fields => :search_fields_attributes do |search|
#   attribute :and_or
# end

# child :search_fields do
child :search_fields => :search_fields_attributes do
  attributes 	:search_id,
							:data_source_id,
							:data_source_field_id,
							:data_field_operator_id,
							:and_or,
							:match_or_attribute_value
end