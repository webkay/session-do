class Task < ActiveRecord::Base
  after_initialize :done_at_init

  belongs_to :user
  has_many :visits

  validates :name, presence: true
  validates :comment, length: { maximum: 255 }, allow_blank: true

  scope :daily, ->{ where(is_daily: true) }
  scope :put_off, ->{ where(is_daily: false)}
  scope :sorted_by_done_at, ->{ order('done_at desc') }

  scope :sorted_nested, ->{ order('is_daily desc, done_at desc') }
  scope :reverse_of_id, ->{ order('id desc') }

  def time_passed_by
    (Time.now.in_time_zone - done_at).to_i/3600
  end

  def bar_length
    time_passed_by.abs.to_i/2
  end

  def done_at_init
    self.done_at ||= Time.now.in_time_zone
  end
end
