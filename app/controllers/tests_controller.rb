class TestsController < ApplicationController
  def index
    @test = { a: 1, b: 2, c: 3 }
    render json: @test.to_json, status: :ok
  end
end
