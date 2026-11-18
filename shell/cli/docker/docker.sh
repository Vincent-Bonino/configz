# TODO

drr() {
    # Docker run
    docker run -v "$HOME/bashrc_docker:/root/.bashrc" "$@"
}

dr_bash() {
    drr -it --entrypoint /bin/bash "$@"
}
