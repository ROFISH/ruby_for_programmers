class Page

  include ActiveModel::Model
  attr_accessor :id, :name, :body_text, :handle

# class methods

  class << self
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

  def attributes
    {
      'id'        => @id,
      'name'      => @name,
      'body_text' => @body_text,
      'handle'    => @handle
    }
  end

  def save
    # get the raw data
    rawstring = File.read(File.join(Rails.root,'db','pages.json'))
    rawdata = JSON::load(rawstring)
    # delete this record's row
    rawdata.delete_if {|row| row['id'] == @id }
    # add the new record to the raw data
    rawdata << attributes
    # save the raw data back to the file
    f = File.open(File.join(Rails.root,'db','pages.json'),'w')
    f.write rawdata.to_json
    f.close
    # return true so that we know it was successful
    true
  end
end
