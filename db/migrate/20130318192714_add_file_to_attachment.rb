class AddFileToAttachment < ActiveRecord::Migration
  def self.up
    add_attachment :attachments, :attached_file
  end

  def self.down
    remove_attachment :attachments, :attached_file
  end
end
