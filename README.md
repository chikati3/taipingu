# README

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