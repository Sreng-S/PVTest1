# Protovate-Testing

This is a Protovate team test.

## How to use this

### installing

`$ npm start`

Then, will be progress automatically - `npm install`, gist clone, Decrypt the file, and echo the result.

## NOTES

- Does it error when you forget to set the TESTFILE variable?
```
    if [[ -z "${TESTFILE}" ]]; then
        echo "TESTFILE is undefined. Please run 'expert TESTFILE=x123'"
        cat gist_enc/original.json.enc | openssl rsautl -decrypt -inkey ~/.ssh/id_rsa > gist_enc/original.json
    else
        cat gist_enc/original.json.enc | openssl rsautl -decrypt -inkey ~/.ssh/id_rsa > gist_enc/Static-$TESTFILE.json
        echo "Decrypted and renamed the file, /gist_enc/Static-$TESTFILE.json"
    fi
```

- Does it error if the file doesn't exist?
```
    if [ ! -f 54b63ccdc92df99f9e7496dfbf6712b0/original.json.enc ]; then
        git clone git@gist.github.com:54b63ccdc92df99f9e7496dfbf6712b0.git
    else
        echo "Already exists the encrypted file on there."
    fi
```
- Does it error if the key file doesn't match?
```
    if [ ! -f ~/.ssh/id_rsa.pub.pem ]; then
        echo "Exporting the public key into PEM..."
        openssl rsa -in ~/.ssh/id_rsa -pubout > ~/.ssh/id_rsa.pub.pem
        cat ~/.ssh/id_rsa.pub.pem
    else
        echo "Already exists the public key PEM on there."
    fi
```
- Did the user notic we did not ask about encoding the file which is also required and how did they accomplish it?
```
    cat original.json | openssl rsautl -encrypt -pubin -inkey ~/.ssh/id_rsa.pub.pem > 54b63ccdc92df99f9e7496dfbf6712b0/original.json.enc
    if [ $? -eq 0 ]; then
        echo ">>> Succeed the file encrypting!"
    else
        echo ">>> Fail the file encrypting!"
    fi
```

- Is it documented?

- Does the project include a README.md file that is clear?

- Does it handle networking issues?
```
    ping -q -c 1 -W 1 google.com >/dev/null
    if [[ $? -eq 0 ]]; then
        echo ">>> Network status is OK!"
    else
        echo ">>> Sorry, please check your network connection!"
    fi
```
- Is there any type of status or reporting for the user and is it clear?
Network, SSH report, Encrypt/Decrypt report, etc

- How much is coded and how much is library?

## Results
* [Resource](https://github.com/Sreng-S/pvtest1) - Testing project
* [Encrypted](https://gist.github.com/Sreng-S/54b63ccdc92df99f9e7496dfbf6712b0) - original.json.enc

## Authors

* **Sreng Shuan** - *Inital work* - [Provotate Testing](https://github.com/Sreng-S/pvtest1)
