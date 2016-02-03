class Movie < ActiveRecord::Base
  include Swagger::Blocks
  has_and_belongs_to_many :users
  mount_uploader :poster, PosterUploader
  attr_accessor :owns

  swagger_schema :Movie do
    key :required, [:id, :name]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :title do
      key :type, :string
    end
    property :release do
      key :type, :string
    end
  end
end
