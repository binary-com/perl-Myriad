FROM deriv/dzil
ARG HTTP_PROXY

ONBUILD COPY . /app/

ONBUILD RUN prepare-apt-cpan.sh \
 && dzil authordeps | cpanm -n

RUN dzil install \
 && dzil clean \
 && git clean -fd \
 && apt purge --autoremove -y \
 && rm -rf .git .circleci

ENTRYPOINT [ "myriad.pl" ]

