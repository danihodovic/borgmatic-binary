# The executable that PyInstaller builds is not fully static, in that it still
# depends on the system libc. Under Linux, the ABI of GLIBC is backward
# compatible, but not forward compatible. So if you link against a newer GLIBC,
# you can't run the resulting executable on an older system. The supplied binary
# bootloader should work with older GLIBC. However, the libpython.so and other
# dynamic libraries still depends on the newer GLIBC. The solution is to compile
# the Python interpreter with its modules (and also probably bootloader) on the
# oldest system you have around, so that it gets linked with the oldest version
# of GLIBC.
FROM ubuntu:16.04

RUN apt-get update && apt-get install --no-install-recommends \
  make build-essential libssl-dev \
  zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev \
  liblzma-dev ca-certificates git -y

ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
ENV PYTHON_CONFIGURE_OPTS=--enable-shared
ENV POETRY_VIRTUALENVS_CREATE=false

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    cd ~/.pyenv && src/configure && make -C src

ENV PYTHON_VERSION=3.9.2

RUN pyenv install $PYTHON_VERSION && pyenv global $PYTHON_VERSION

RUN pip install poetry

WORKDIR /app/
COPY pyproject.toml poetry.lock /app/

RUN poetry install

COPY pyinstaller.spec main.py /app/

RUN eval "$(pyenv init -)" && pyinstaller pyinstaller.spec
