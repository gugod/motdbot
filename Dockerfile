FROM docker.io/library/perl:5.38
WORKDIR /app
COPY . /app
RUN cpm install -g \
    && rm -rf /root/.cpanm /root/.cpan /root/.perl-cpm
