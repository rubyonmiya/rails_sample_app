# ベースとなるイメージの指定（rubyのバージョン3.0.3を指定）
FROM ruby:3.1.3

# ビルド時に実行するコマンドの指定
# インストール可能なパッケージの一覧の更新
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    default-mysql-client \
    yarn

# 作業ディレクトリの指定
WORKDIR /rails_sample_app
COPY Gemfile /rails_sample_app/Gemfile
COPY Gemfile.lock /rails_sample_app/Gemfile.lock
RUN bundle install
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
