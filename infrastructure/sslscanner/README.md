Build/Run with **Docker**

    docker build -t sslscanner .
    docker run -it --rm sslscanner


Container with a version of openssl that support ssl2 and ssl3. Useful to run ssl scans.

Tools

    sslscan
    testssl
    sslyze

bashrc/zshrc alias:

alias testssl="docker run -it --rm --entrypoint testssl sslscanner"
alias sslscan="docker run -it --rm --entrypoint sslscan sslscanner"