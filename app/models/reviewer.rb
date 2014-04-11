class Reviewer < ActiveRecord::Base
	
	belongs_to :code_review, foreign_key: 'issue', primary_key: 'issue'

	has_one :developer, foreign_key: "email", primary_key: "email"

  def self.on_optimize
    ActiveRecord::Base.connection.add_index :reviewers, :issue
    ActiveRecord::Base.connection.add_index :reviewers, :email
  end

end
