class ResultInfo < Result
  # attr_accessible :title, :body
  validates_presence_of :info

  def execute_result (client)
      client.comment = self.info
      client.save
    end
end
