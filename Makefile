default: run

build:
	sudo docker build -t mendersoftware/hydra .

run: build
	sudo docker run -it \
		--name=hydra \
		-p 4444:4444 \
		-e "CONSENT_URL=https://localhost:15555/auth" \
		-e "HTTPS_TLS_CERT_PATH=/etc/hydra/cert.pem" \
		-e "HTTPS_TLS_KEY_PATH=/etc/hydra/key.pem" \
		-e "HTTPS_TLS_KEY_PATH=/etc/hydra/key.pem" \
		-e "FORCE_ROOT_CLIENT_CREDENTIALS=2993d234-d46c-4202-9dda-507d20ba1975:lDAkLGMdy>sSalZ=" \
		mendersoftware/hydra
