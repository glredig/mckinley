require 'rails_helper'

RSpec.describe TestsController, type: :controller do
  describe 'GET #index' do
    before { get :index }
    it { should respond_with(:success) }
    it { expect(assigns(:test)).to eq({ a: 1, b: 2, c: 3 }) }
  end
end
