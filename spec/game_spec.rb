require_relative '../app/game'

describe Game do
  context 'When testing Game class' do
    before(:all) do
      @game = Game.new(true, 2021, 2000)
    end

    it 'The Game class initialize correctly' do
      expect(@game.multiplayer).to be true
      expect(@game.last_play_at).to eq 2021
      expect(@game.publish_date).to eq 2000
    end

    it 'Check if the game can_be_archived' do
      expect(@game.can_be_archived?).to be false
      @game.last_play_at = 2010
      expect(@game.can_be_archived?).to be true
    end
  end
end
