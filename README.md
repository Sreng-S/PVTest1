This is a Protovate team test.

## How to use this

- install

$ npm start

Then, to run 'npm install', gist clone, Decrypt the file, and echo the result.

## NOTES

- Does it error when you forget to set the TESTFILE variable?

- Does it error if the file doesn't exist?

# download the file from gist
if [ ! -f 54b63ccdc92df99f9e7496dfbf6712b0/original.json.enc ]; then
    git clone git@gist.github.com:54b63ccdc92df99f9e7496dfbf6712b0.git
else
    echo "Already exists the encrypted file on there."
fi

- Does it error if the key file doesn't match?

#export public key into PEM
if [ ! -f ~/.ssh/id_rsa.pub.pem ]; then
    echo "Exporting the public key into PEM..."
    openssl rsa -in ~/.ssh/id_rsa -pubout > ~/.ssh/id_rsa.pub.pem
    cat ~/.ssh/id_rsa.pub.pem
else
    echo "Already exists the public key PEM on there."
fi

- Did the user notic we did not ask about encoding the file which is also required and how did they accomplish it?

- Is it documented?

- Does the project include a README.md file that is clear?

- Does it handle networking issues?

- Is there any type of status or reporting for the user and is it clear?

- How much is coded and how much is library?