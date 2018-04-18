class TestsController < Simpler::Controller

  def index
    # render html: "<h1>jkjkj</h1>"
  end

  def create

  end

  def show
    render plain: "#{params}"
  end

end
