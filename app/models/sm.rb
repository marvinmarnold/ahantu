class Sm < ActiveRecord::Base
  belongs_to :cart
  belongs_to :phone
  validate :phone_id, :sent_at, :message,
  	presence: true
  validates :incoming, 
  	:inclusion => { in: [true, false] }

  def self.send(p, m, c)
  	deliver Sm.create(phone_id: p.id, message: m, incoming: false, cart: c)
  end

  def self.deliver(sms)
    RestClient.get('localhost:13014/cgi-bin/sendsms', {:params => {
      :username => 'ahantu',
      :password => 'n4rcisiO!marvin',
      :to => sms.phone.number,
      :text => sms.message.encode('ascii', :invalid => :replace, :undef => :replace, :replace => ' ')
    }})
  end

  def sanitized
    Sm.sanitize(message)
  end

  def self.sanitize(s)
    s.downcase.delete(' ')
  end

end
