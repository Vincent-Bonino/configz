# Environment variables
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

export PYTHON_STD_SOURCES="$HOME/.pyenv/versions/3.12.5/lib/python3.12/"

# Aliases
alias py='python'
alias pyhton='python'

# Pytest
alias pytest-vanilla='pytest --no-cov -n 0'
alias pytest-doctest='pytest --no-cov -n 0 --doctest-modules --doctest-ignore-import-errors'

# Libraries sources
alias pysrc='subl $( get_py_sources )'
alias pystdsrc='subl $PYTHON_STD_SOURCES'
