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
		mendersoftware/hydra
