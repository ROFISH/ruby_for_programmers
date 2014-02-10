class Page

  include ActiveModel::Model
  extend ActiveModel::Callbacks
  attr_accessor :id, :name, :body_text, :handle, :updated_at

  define_model_callbacks :save

  before_save :touch

  validates_presence_of :name
  validates_length_of :name, minimum: 3

# class methods

  class << self
    def find(id)
      load_data
      detected = @data.detect{|row| row['id'].to_s == id.to_s}
      raise "Not Found!" if detected.blank?
      Page.new(detected)
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

  def attributes
    {
      'id'        => @id,
      'name'      => @name,
      'body_text' => @body_text,
      'handle'    => @handle,
      'updated_at'=> @updated_at
    }
  end

  def save
    return false if !valid?
    run_callbacks :save do
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

  def touch
    @updated_at = Time.now
  end

  def persisted?
    # this is always persisted with our flat files
    true
  end
end
