devise_russian
==============

Часто используемые наработки по джему Devise для авторизации. Включает решение по авторизации в социальных сетях

## Установка

Ставим джемы:

    gem "devise"
    gem "devise_russian"

А также джемы, через которые мы будем авторизовываться в социальных сетях:

    gem "omniauth-facebook"
    gem "omniauth-vkontakte"
    gem "omniauth-odnoklassniki"

Обратите внимание на метод providers модели Authentication: https://github.com/vav/devise_russian/blob/master/app/models/authentication.rb

В случае необходимости задать свой список провайдеров:

app/models/authentication_decorator.rb:

    Authentication.class_eval do
      def self.providers
        [
          ['facebook', 'Facebook'],
          ['vkontakte', 'Vkontakte'],
          ['odnoklassniki', 'Odnoklassniki'],
          ['twitter', 'Twitter'],
          ['github', 'Github'],
          ['google_oauth2', 'Google']
        ]
      end
    end

В config/initializers/omniauth.rb:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :facebook, '2222222222222', 'sdsdsd6sd5sd6sdsd65sd6sd56sd6sd534sd54sd',
        {:client_options => {:ssl => {:ca_file => "#{Rails.root}/config/ca-bundle.crt"}}}

      provider :vkontakte, '222222','sds4dasdah22as22dg',
        {:client_options => {:ssl => {:ca_file => "#{Rails.root}/config/ca-bundle.crt"}}}

      provider :odnoklassniki, "2222222", "HGF33GH3F3HGF3HGF3SD",
        :public_key => "DFKSFDKJHJHFJSDSADSD", :provider_ignores_state => true

      ...

Миграции:

    # Пользователи
    create_table :users do |t|

      t.datetime :deleted_at # Дата удаления

      # Основная информация
      t.string  :name # Имя
      t.string  :role # Роль
      t.decimal :balance, :precision => 10, :scale => 4, :null => false, :default => 0

      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true

    # Авторизации
    create_table :authentications do |t|
      t.integer :user_id
      t.string  :provider
      t.string  :uid
      t.string  :email
      t.string  :name
      t.timestamps
    end

    add_index :authentications, :user_id

Прописываем роуты:

config/routes.rb:

    mount DeviseRussian::Engine => "/auth", :as => "devise_russian"

Подключаем девайс и русский девайс в модели:

app/models/user.rb:

    # Devise
    devise :database_authenticatable,
           :confirmable,
           :registerable,
           :recoverable,
           :rememberable,
           :trackable,
           :validatable

    # Russian Devise
    omniauthable

    class << self
      ...
      # Вывод списка провайдеров на странице входа
      def omniauth_enabled
        false
      end
      ...
    end

Прописывем название и адрес сайта для подвала писем от Devise:

    ru:
      devise_russian:
        my_authentications: Мои авторизации
        authentication_not_found: Авторизация не найдена
        mailer:
          site_name: Мега-портал
          site_url: "http://www.portal.ru"

Ссылки на вход и регистрацию:

    <ul>
      <li><a href="/auth/login">Вход</a></li>
      <li><a href="/auth/register">Регистрация</a></li>
    </ul>

Ну и так далее. Настраивайте под себя!
