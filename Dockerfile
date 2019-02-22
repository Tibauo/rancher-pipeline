FROM centos:7 as tmp
RUN yum update -y \
  && yum install wget -y \
  && cd /tmp \
  && wget https://raw.githubusercontent.com/travis-ci/gimme/master/gimme \
  && mv gimme /usr/local/sbin \
  && chmod +x /usr/local/sbin/gimme \
  && gimme 1.4

COPY main.go /tmp/

RUN source ~/.gimme/envs/go1.4.env \
  && cd /tmp \
  && go build main.go


FROM centos:7
COPY --from=tmp /tmp/main /tmp
RUN /tmp/main
