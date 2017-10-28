require 'euler.rb'

class ODE_Simulator

  #===========
  #MEMBER DATA
  #===========
  
  #x update function in terms of t, x, y
  #y update function in terms of t, x, y
  #step size of t
  #bounds on x and y and t
  #number of points to generate
  #set of x,y points

  #==========================
  #INITIALIZERS AND ACCESSORS
  #==========================

  #accessor for x update fn
  #accessor for y update fn
  #accessor for t stepsize
  #accessor for points

  #initializer
  #set bounds
  #set number of points
  #generate
  #set update functions
  #end

  #==========
  #SIMULATING
  #==========

  #generate
  #initialize n points to random values within x&y bounds
  #end

  #rk4_weight
  #returns rk4 weighted sum for updating
  #end

  #update
  #sets all points according to rk4 update function
  #end

  #plot
  #plot all x and y points
  #end

  #simulate
  #for number of t-steps
  #update then plot
  #end

end
