TAG=${1:-'alpine'}

GITHUB_USERNAME=$(git config user.email)
echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin
docker push  ghcr.io/getfundwave/nginx-acme:$TAG