class Player
  def play_turn(warrior)
  	if @already_gone_backwards || warrior.feel(:backward).wall?
  		@already_gone_backwards = true
	  	if warrior.feel.empty?
	  		walk_or_rest(warrior, :forward)
	  	else
	  		warrior_or_captive(warrior, :forward)
	  	end
  	else
	  	if warrior.feel(:backward).empty?
	  		walk_or_rest(warrior, :backward)
	  	else
	  		warrior_or_captive(warrior, :backward)
	  	end
  	end
  	@health = warrior.health
  end

  def walk_or_rest(warrior, direction)
  	if @health.nil? || @health > warrior.health
  		if warrior.health < 10
  			if(direction == :forward)
  				warrior.walk!(:backward)
			else
  				warrior.walk!(:forward)
			end
  		else
  			warrior.walk!(direction)
  		end
  	else
	  	if warrior.health < 20 && !warrior.feel(direction).stairs?
  			warrior.rest!
  		else
  			warrior.walk!(direction)
		end	
  	end
  end

  def warrior_or_captive(warrior, direction)
  	if warrior.feel(direction).captive?
  		warrior.rescue!(direction)
  	else
  		warrior.attack!(direction)
  	end
  end
end
