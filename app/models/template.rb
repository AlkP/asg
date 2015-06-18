class Template < ActiveRecord::Base
  has_attached_file :att_file
  do_not_validate_attachment_file_type :att_file
end
