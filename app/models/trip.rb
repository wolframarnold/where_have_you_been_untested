class Trip < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true
#  validates :user, :presence => true
  validates :begun_on, :presence => true,
            :if => Proc.new {|trip| trip.ended_on.present?}
  validates :ended_on, :presence => true,
            :if => Proc.new {|trip| trip.begun_on.present?}

  #def check_begun_date
  #  self.begun_on.present?
  #end

  attr_accessible :name, :places_attributes, :begun_on, :ended_on

  has_many :places, dependent: :destroy, :inverse_of => :trip

  accepts_nested_attributes_for :places, :reject_if => :all_blank

  #scope :desc, order('created_at DESC')
  #scope :alpha, order('name ASC')
  #scope :this_year, where('created_at > "2012-01-01"')
  #
  def as_json(opts={})
    super(opts.merge(:include => :places))
  end


  scope :desc, order('created_at DESC')
  scope :last_12_months, lambda {
          #where(:created_at => (1.year.ago)...(Time.now))
          where("created_at > ?", 1.year.ago)
        }
end
