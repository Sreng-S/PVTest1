#!/bin/bash

# ~ 10/28/2017 ~
# ~ Sreng S. ~

#network issue handle
    ping -q -c 1 -W 1 google.com >/dev/null
    if [[ $? -eq 0 ]]; then
        echo ">>> Network status is OK!"
    else
        echo ">>> Sorry, please check your network connection!"
    fi

#generating a new ssh
    if [ ! -f ~/.ssh/id_rsa ]; then
        ssh-keygen -t rsa -b 4096 -C "srengtrecom@yahoo.com"
        eval $(ssh-agent -s)
        ssh-add ~/.ssh/id_rsa
        clip < ~/.ssh/id_rsa.pub
        cat ~/.ssh/id_rsa.pub
    else
        echo ">>> Already generated the ssh."
    fi

#export public key into PEM
    if [ ! -f ~/.ssh/id_rsa.pub.pem ]; then
        echo ">>> Exporting the public key into PEM..."
        openssl rsa -in ~/.ssh/id_rsa -pubout > ~/.ssh/id_rsa.pub.pem
        cat ~/.ssh/id_rsa.pub.pem
    else
        echo ">>> Already exists the public key PEM."
    fi

#upload the encryted file to gist
    git clone git@gist.github.com:54b63ccdc92df99f9e7496dfbf6712b0.git

    ## encrypt the file
    cat original.json | openssl rsautl -encrypt -pubin -inkey ~/.ssh/id_rsa.pub.pem > 54b63ccdc92df99f9e7496dfbf6712b0/original.json.enc
    if [ $? -eq 0 ]; then
        echo ">>> Succeed the file encrypting!"
    else
        echo ">>> Fail the file encrypting!"
    fi

    ## push the commit
    cd 54b63ccdc92df99f9e7496dfbf6712b0
    git add .
    git commit -m "better..."
    git push origin master

    ## delete temp folder
    cd ..
    DIR=$PWD/54b63ccdc92df99f9e7496dfbf6712b0
    if [ -d "$DIR" ]; then
        echo ">>> Removing the temp folder..."
        rm -rf "$DIR"
    else
        echo ">>> Not exists the temp!"
    fi

# download the encrypted file from gist
    if [ ! -f gist_enc/original.json.enc ]; then
        git clone git@gist.github.com:54b63ccdc92df99f9e7496dfbf6712b0.git gist_enc
        if [ $? -eq 0 ]; then
            echo ">>> Succeed the file download from GIST!"
        else
            echo ">>> Fail the file download from GIST!"
        fi
    else
        echo ">>> Already exists the encrypted file."
    fi

# decrypt the file
    if [ -f gist_enc/original.json.enc ]; then

        # cat gist_enc/original.json.enc | openssl rsautl -decrypt -inkey ~/.ssh/id_rsa
        # if [ $? -eq 0 ]; then
        #     echo ">>> Correctly matching the pub key!"
        # else
        #     echo ">>> Invalid the pub key!"
        # fi

        if [[ -z "${TESTFILE}" ]]; then
            echo ">>> TESTFILE is undefined. Please run 'expert TESTFILE=x123'"
            cat gist_enc/original.json.enc | openssl rsautl -decrypt -inkey ~/.ssh/id_rsa > gist_enc/original.json
            echo ">>> Decrypted the file /gist_enc/original.json"
        else
            cat gist_enc/original.json.enc | openssl rsautl -decrypt -inkey ~/.ssh/id_rsa > gist_enc/Static-$TESTFILE.json
            echo ">>> Decrypted and renamed the file, /gist_enc/Static-$TESTFILE.json"
        fi
        

        echo ">>> Decrypted data:"
        cat gist_enc/original.json.enc | openssl rsautl -decrypt -inkey ~/.ssh/id_rsa

        echo ">>> Thank you for your running."
    fi

