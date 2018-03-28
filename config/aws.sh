unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  export AWS_VAULT_BACKEND=secret-service
fi
