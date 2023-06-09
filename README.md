# アプリケーション名
タイピングパラダイス

# アプリケーション概要
ユーザーが独自のテキストを入力して、自分自身のタイピングスキルを向上させることができます。ユーザーは、テキストの長さや難易度を調整でき、タイピングの正確さやスピードに基づいてスコアが計算されます。また、ユーザーが入力したテキストの結果を保存し、過去のパフォーマンスを追跡することができます。このアプリは、タイピングスキルを向上させたい人、タイピングに自信がない人、あるいは英語や他の言語を学びたい人にとって役立つツールです。

# URL
https://taipingu.onrender.com/

# テスト用アカウント
Basic認証ユーザー: admin  
Basic認証パスワード: 2222  
メールアドレス: test@test.com  
パスワード: test11

# 利用方法
## 目標投稿
1. トップページにて、スペースキーを押すことでゲームスタート(デフォルト文字)
2. トップページのヘッダーからユーザー新規登録を行う
3. トップページのヘッダーかユーザー名をクリックして作成ページへ
4. 作成ページにて、タイトル、答えを入力して作成ボタンを押す(下部に入力した文字が表示される)
5. ヘッダーの左上にある、タイピングパラダイスをクリックしてトップページへ戻る
6. スペースキーを押してゲームスタート
7. ゲーム終了したら、エスケープキーを押して再スタートする

## アプリケーションを作成した背景
自分で入力したい文字を作成できるタイピングゲームは、同じ文字ばかりで飽きてきた人にとって、より楽しい体験を提供します。タイピングスピードや正確性を向上させるための素晴らしい方法であり、学生やビジネスパーソンにも役立ちます。また、自分で作成した文字で遊ぶことができるという点は、ユーザーにとってよりパーソナライズされた体験を提供し、より一層の楽しみを提供することができます。

## 洗い出した要件
https://docs.google.com/spreadsheets/d/1-1Jpik69Dt1_9JPFqWkeY2Ds7YWeF63bMiMRfXnHs5Q/edit#gid=982722306

## 実装予定の機能
ユーザーが作成した文字をカテゴリーごとに分けて管理する機能を考えています。これにより、ユーザーは自分が作成した文字を使いやすい形で整理することができます。また、他のユーザーとカテゴリーを共有することができるため、より広い視野で文字を見ることができます。たとえば、プログラマー向けの文字や英単語など、特定の目的に合わせた文字を共有できます。この機能により、より多様なユーザーがアプリを利用することができ、より豊かな体験を提供することができます。

## データベース設計
![](imgs/%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E8%A8%AD%E8%A8%88.jpg)


## users テーブル
| colum                | type      | options                        |
| -------------------- | --------- | ------------------------------ |
| nickname             | string    | null: false                    |
| email                | string    | null: false                    |
| encrypted_password   | string    | null: false                    |

### Association
- has_many :games


## games テーブル
| colum                | type      | options                        |
| -------------------- | --------- | ------------------------------ |
| title                | string    | null: false                    |
| answer               | string    | null: false                    |
| user                 | string    | null: false, foreign_key: true |

### Association
- belongs_to :user


## 画面遷移図
![](imgs/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3.jpg)

## 開発環境
フロントエンド：HTML、CSS、Ajax、JavaScript  
バックエンド：Rails  
開発ツール：Visual Studio Code、GitHub

## ローカルでの動作方法
% git clone https://github.com/chikati3/taipingu.git  
% cd taipingu  
% bundle install  
% yarn install  
% rails db:create  
% rails db:migrate  
$ rails s

## 工夫したポイント
ユーザーがアプリにユーザー登録せずに、デフォルトで用意した文字で遊べることです。これにより、ユーザーは手軽にアプリを試すことができ、ストレスを感じることなくタイピングの練習ができます。また、titleとanswerを独立していることで、アプリケーションの柔軟性が高まります。たとえば、数学の計算ドリルであれば、titleに問題文、answerに正解を格納することができます。また、英単語の場合は、titleに単語、answerにその単語の意味を格納することができます。このように、titleとanswerを独立していることで、アプリケーションの利用範囲が広がり、より多くのユーザーに使っていただけると考えられます。
