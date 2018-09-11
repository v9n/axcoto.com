k := kubectl
tls:
	$(k) -n axcoto delete secret axcoto-tls || true
	$(k) -n axcoto create secret tls axcoto-tls --key ~/.acme.sh/axcoto.com/axcoto.com.key --cert ~/.acme.sh/axcoto.com/fullchain.cer
