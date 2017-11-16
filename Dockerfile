FROM swiftdocker/swift:4.0.2

RUN apt-get update && apt-get install wget -y
RUN /bin/bash -c "$(wget -qO- https://apt.vapor.sh)"

RUN apt-get update && apt-get install cmysql -y

ADD ./ /app
WORKDIR /app

RUN swift build -c release

ENV PATH /app/.build/release:$PATH

RUN chmod -R a+w /app && chmod -R 777 /app

RUN useradd -m myuser
USER myuser
RUN ls .build/release
CMD .build/x86_64-unknown-linux/release/Run --env=production --workdir="/app"
