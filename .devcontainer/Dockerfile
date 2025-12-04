FROM ruby:3.2.2

# ロケールとタイムゾーンの設定
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
ENV TZ=Asia/Tokyo

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    locales tzdata \
    libpq-dev \
    nodejs \
    npm \
    postgresql-client \
    git \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# ロケールの生成
RUN sed -i '/ja_JP.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8

# タイムゾーンの設定
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install GitHub CLI
RUN mkdir -p -m 755 /etc/apt/keyrings \
	&& curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& apt update \
	&& apt install gh -y

# Node.jsの最新LTSバージョンをインストール
RUN npm install -g n && n lts

# 作業ディレクトリの設定
WORKDIR /workspace

# Rails 8.1.1のインストール
RUN gem install rails -v 8.1.1

# 非rootユーザーの作成
RUN useradd -m -s /bin/bash vscode && \
    mkdir -p /workspace && \
    chown -R vscode:vscode /workspace

USER vscode

# デフォルトのシェルをbashに設定
ENV SHELL /bin/bash

CMD ["/bin/bash"]
