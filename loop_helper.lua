-- W/del freeze looper controlled by Compare 2

function init()
   input[1].mode ('change', 1, 0.1, 'both') -- NOT 1
   input[2].mode ('change', 1, 0.1, 'both') -- NOT 2
   reset = false
   scale = 1.0
end

-- Output cv to cm's fade, logic is reversed since we use NOT
function set_values()
   if input[1].volts > 1 then one = false else one = true end
   if input[2].volts > 1 then two = false else two = true end

   -- rng 1 + 2, balanced, on
   if one and two then
      output[1].volts = (math.random() * 10 - 5) * scale -- W/del 1 that
      output[2].volts = (math.random() * 10 - 5) * scale -- W/del 2 that
      output[3].volts = 0                                -- Cold Mac fade
      output[4].volts = 5                                -- Submix VCA
   end

   -- rng 1, left, on
   if one and not two then
      output[1].volts = (math.random() * 10 - 5) * scale
      if reset then output[2].volts = 0 end
      output[3].volts = -5
      output[4].volts = 5
   end

   -- rng 2, right, on
   if not one and two then
      if reset then output[1].volts = 0 end
      output[2].volts = (math.random() * 10 - 5) * scale
      output[3].volts = 5
      output[4].volts = 5
   end

   -- balanced, off
   if not one and not two then
      if reset then output[1].volts = 0 end
      if reset then output[2].volts = 0 end
      output[3].volts = 0
      output[4].volts = 0
   end
end

input[1].change = function() set_values() end
input[2].change = function() set_values() end
