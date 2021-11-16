ARG VERSION=unspecified
# TODO: Switch base Docker image from python:3.9.6 to a current
# alpine image (e.g. python:3.10.0-alpine)
# Issue: https://github.com/cisagov/pca-report-generator-docker/issues/11
FROM python:3.9.6

ARG VERSION

# For a list of pre-defined annotation keys and value types see:
# https://github.com/opencontainers/image-spec/blob/master/annotations.md
# Note: Additional labels are added by the build workflow.
LABEL org.opencontainers.image.authors="mark.feldhousen@cisa.dhs.gov"
LABEL org.opencontainers.image.vendor="Cybersecurity and Infrastructure Security Agency"

ARG CISA_UID=421
ENV CISA_HOME="/home/cisa"
ENV PCA_REPORT_LIBRARY_SRC="/usr/src/pca-report-tools"
ENV ECHO_MESSAGE="Hello World from Dockerfile"

RUN addgroup --system --gid ${CISA_UID} cisa \
  && adduser --system --uid ${CISA_UID} --ingroup cisa cisa

RUN apt-get update && \
 apt-get install --no-install-recommends -y texlive texlive-bibtex-extra texlive-xetex wget

COPY src/version.txt /src

WORKDIR ${PCA_REPORT_LIBRARY_SRC}

RUN wget -O sourcecode.tgz https://github.com/cisagov/pca-report-library/archive/v${VERSION}.tar.gz && \
  tar xzf sourcecode.tgz --strip-components=1 && \
  pip install --requirement requirements.txt && \
  cp -r src/pca_report_library/assets/fonts /usr/share/fonts/truetype/ncats && \
  fc-cache -fsv && \
  chmod +x ${PCA_REPORT_LIBRARY_SRC}/var/getenv && \
  ln -snf ${PCA_REPORT_LIBRARY_SRC}/var/getenv /usr/local/bin && \
  rm sourcecode.tgz

USER cisa
WORKDIR ${CISA_HOME}
CMD ["getenv"]
