# require 'gnuplot'

class ODESimulator

  #==========================
  #INITIALIZERS AND ACCESSORS
  #==========================

  attr_accessor :points #access list of points
  attr_accessor :step_size #accessor for t stepsize

  def initialize (update, step_size=0.01,
                  x_lims=(-5.0..5.0), y_lims=(-5.0..5.0), t_lims=(0..1),
                  num_points=20)
    @update = update #set update functions
    @x_lims = x_lims #set bounds
    @y_lims = y_lims #set number of points
    @num_points = num_points
    generate() #generate
  end

  #==========
  #SIMULATING
  #==========

  def generate ()
    #initialize n points to random values within x&y bounds
    rng = Random.new
    @points = Array.new
    @num_points.times do
      @points << [rng.rand(@x_lims), rng.rand(@y_lims)]
    end
  end

  def rk4_weight ()
    #returns rk4 weighted sum for updating
  end

  def update ()
    #sets all points according to rk4 update function
  end

  def plot ()
    #plot all x and y points
  end

  def simulate ()
    #for number of t-steps
    #update then plot
  end

end
