require 'rails_helper'

RSpec.describe Game, type: :model do
  before do
    @game = FactoryBot.build(:game)
  end

  describe 'typing保存' do
    it 'titleとanswerが存在すれば登録できる' do
      expect(@game).to be_valid
    end

    it 'titleが空では登録できない' do
      @game.title = ''
      @game.valid?
      expect(@game.errors.full_messages).to include("Title can't be blank")
    end
    it 'answerが空では登録できない' do
      @game.answer = ''
      @game.valid?
      expect(@game.errors.full_messages).to include("Answer can't be blank")
    end
  end
end
