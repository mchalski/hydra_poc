## Layout
- hydra: source snapshot c743e3738735b31803505dbe4f95ac3c17983a6c
- crypto: required keypairs (default), copied into container
- Dockerfile: overriden Dockerfile (e.g. --skip-tls-verify)
- upload-key: util for uploading keys to hydra
    - start root oauth session, convert keys PEM->JWK, upload via http API

## Integration
Instructions for overriding configuration (mainly crypto artifacts):
- OAuth-related keypairs(hydra.consent.challenge, etc.) live in /etc/hydra/, need to be inserted at runtime via upload-key (and shared with other apps)
    - hydra.openid.id-token.private.pem
    - hydra.openid.id-token.public.pem
    - hydra.consent.response.private.pem
    - hydra.consent.response.public.pem
    - hydra.consent.challenge.private.pem
    - hydra.consent.challenge.public.pem

- TLS cert
    - use a regular env var(HTTPS_TLS_KEY_PATH, HTTPS_TLS_CERT_PATH)
    - example in Makefile

- CONSENT_URL env var, example in Makefile

- root client id+secret passed via env:
    - FORCE_ROOT_CLIENT_CREDENTIALS=id:secret
    - example in Makefile

- required outside ports:
    - HTTPS 4444

- IdP consent callback is passed via the CONSENT_URL env var

What MUST be overriden for a real-life deployment (security reasons):
- all hydra.xxx keypairs
- root credentials

Note that keys must also be propagated to:
- the IdP
    - hydra.consent.challenge public key
    - hydra.response.challenge keypair

- the client web app
    - hydra.openid.id-token public key

## Notes on 'upload-key'
- lots of dependecies:
    - pip install requests
    - pip install oauthlib
    - clone pyjwkest, python setup.py install
