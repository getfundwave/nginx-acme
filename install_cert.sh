function create_cert {
    chown -R root:101 /etc/nginx/certs/ && chmod -R 770 /etc/nginx/certs/

    local -a params_issue_arr
    local -a params_install_arr
    params_issue_arr+=(-w /usr/share/nginx/html/ -d "$VIRTUAL_HOST")
    params_install_arr+=(-d $VIRTUAL_HOST \
            --key-file /etc/nginx/certs/ssl_certificate.key \
            --fullchain-file /etc/nginx/certs/ssl_certificate.crt \
            --ca-file /etc/nginx/certs/chain.pem)
    [[ "${1:-}" == "--force-renew" ]] && params_issue_arr+=(--force)
    if [[ ! -z $STAGING ]] 
    then
        params_issue_arr+=(--staging)
        params_install_arr+=(--staging) 
    else
        params_issue_arr+=(--server letsencrypt) 
    fi

    cd /etc/nginx/certs/
    
    if [[ "${1:-}" == "--force-renew" ]] 
    then 
        acme.sh --issue  "${params_issue_arr[@]}" && \
        acme.sh --install-cert "${params_install_arr[@]}"
    fi    

    if [[ ! -f /etc/nginx/certs/ssl_certificate.key && ! -f /etc/nginx/certs/ssl_certificate.key ]]
    then
        acme.sh --register-account -m $ACME_EMAIL
        acme.sh --issue  "${params_issue_arr[@]}" && \
        acme.sh --install-cert "${params_install_arr[@]}" 
        if [[ $? -eq 0 ]]
        then
            cat /fwacme/ssl.conf > "/etc/nginx/conf.d/ssl.conf"
        fi
    fi
   }
