class Page

# class methods

  class << self
    def find(id)
      load_data
      @data.detect{|row| row["id"] == id}
    end

    def where(predecate)
      raise ArgumentError.new("predecate must be a hash!") unless predecate.is_a?(Hash)
      load_data

      # this isn't the best way to do this (maybe via inject), but to show for example
      # for all the data rows
      found_data = @data.select do |row|
        has_all_conditions = true
        # check to see if the row supports all our conditions by using the AND statement
        predecate.each do |key, value|
          has_all_conditions = has_all_conditions && row[key.to_s] == value
        end
        # if it has all conditions, then this is true
        has_all_conditions
      end
      found_data.map{|x| Page.new(x)}
    end

    private

    def load_data
      return true if @loaded
      rawdata = File.read(File.join(Rails.root,'db','pages.json'))
      @data = JSON::load(rawdata)
    end
  end


# instance methods

  def initialize(data)
    @data = data
  end

  def id
    @data['id']
  end

  def name
    @data['name']
  end

  def body_text
    @data['body_text']
  end

  def handle
    @data['handle']
  end

end
