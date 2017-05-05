class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #inding.pry
    captain_ids = Classification.all.find_by(name: "Catamaran").boats.pluck(:captain_id) #return all captains
    #self.all.where("")
    self.all.where(id: captain_ids)
  end

  def self.sailors
    captain_ids = Boat.sailboats.pluck(:captain_id)
    self.all.where(id: captain_ids)
  end

  def self.talented_seamen
    #binding.pry
    sailor_ids = Boat.sailboats.pluck(:captain_id).uniq
    motor_ids = Classification.all.find_by(name: "Motorboat").boats.pluck(:captain_id).uniq
    both_ids = []
    sailor_ids.each {|id| both_ids << id if motor_ids.include?(id)}
    self.all.where(id: both_ids)
  end


  def self.non_sailors
    sailor_ids = Boat.sailboats.pluck(:captain_id).uniq
    all_capt_ids = Boat.all.pluck(:captain_id).uniq
    non_sailor_ids = all_capt_ids.reject {|c_id| sailor_ids.member?(c_id)}
    self.all.where(id: non_sailor_ids)
  end

end
