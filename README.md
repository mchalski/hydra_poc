## Layout
- hydra: source snapshot c743e3738735b31803505dbe4f95ac3c17983a6c
- crypto: required keypairs (default), copied into container
- Dockerfile: overriden Dockerfile (e.g. --skip-tls-verify)

## Integration
Instructions for overriding configuration (mainly crypto artifacts):
- OAuth-related keypairs(hydra.consent.challenge, etc.) live in /etc/hydra/, mount a volume to override
    - hydra.openid.id-token.private.pem
    - hydra.openid.id-token.public.pem
    - hydra.consent.response.private.pem
    - hydra.consent.response.public.pem
    - hydra.consent.challenge.private.pem
    - hydra.consent.challenge.public.pem

- TLS cert
    - use a regular env var(HTTPS_TLS_KEY_PATH, HTTPS_TLS_CERT_PATH)
    - example in Makefile

- root client id+secret passed via env:
    - FORCE_ROOT_CLIENT_CREDENTIALS=id:secret

- required outside ports:
    - HTTPS 4444

- IdP consent callback is passed via the CONSENT_URL env var

What MUST be overriden for a real-life deployment (security reasons):
- all hydra.xxx keypairs
- root credentials

Note that these changes must also be propagatedto:
- the IdP
    - hydra.consent.challenge public key
    - hydra.response.challenge keypair

- the client web app
    - hydra.openid.id-token public key
