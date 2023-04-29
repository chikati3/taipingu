require 'rails_helper'

RSpec.describe "Games", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @game_title = Faker::Name.initials
    @game_answer = Faker::Name.initials
  end

  context 'タイピング投稿ができるとき'do
    it 'ログインしたユーザーは投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページに自分の名前がかあることを確認する
      expect(page).to have_content(@user.nickname)
      # 投稿ページに移動する
      visit new_game_path
      # フォームに情報を入力する
      fill_in 'game_title', with: @game_title
      fill_in 'game_answer', with: @game_answer
      # 送信するとgameモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Game.count }.by(1)
      # 投稿した内容がページに表示されている
      expect(page).to have_content(@game_title)
      expect(page).to have_content(@game_answer)
    end
  end
  context 'タイピング投稿ができないとき'do
    it 'ログインしていないと投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('作成')
    end
  end
end


RSpec.describe 'タイピング内容削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @game = FactoryBot.create(:game, user: @user)
  end
  context 'タイピング内容が削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したタイピング内容の削除ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページに自分の名前がかあることを確認する
      expect(page).to have_content(@user.nickname)
      # 投稿ページに移動する
      visit new_game_path
      # 「削除」へのリンクがあることを確認する
      expect(page).to have_selector("a[data-method='delete'][href='#{game_path(@game)}']", text: '✖︎')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find("a[data-method='delete'][href='#{game_path(@game)}']").click
      }.to change { Game.count }.by(-1)
      # トップページにはタイピング内容が存在しないことを確認する
      expect(page).to have_no_content(@game.title)
      expect(page).to have_no_content(@game.answer)
    end
  end
end

