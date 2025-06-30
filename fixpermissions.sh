#!/bin/bash
echo "Fixing vhosts permissions"
echo "================================"

for domain_dir in /var/www/vhosts/*/; do
    if [ -d "$domain_dir" ]; then
        domain_name=$(basename "$domain_dir")

        if [[ "$domain_name" != "chroot" && "$domain_name" != "default" && "$domain_name" != "fs" && "$domain_name" != "system" && "$domain_name" != "." && "$domain_name" != ".." ]]; then
            if [[ "$domain_name" =~ ^[a-zA-Z0-9.-]+$ ]]; then
                echo "Fixing: $domain_name"
                plesk repair fs -vhosts "$domain_name" -y
                
                if [ $? -eq 0 ]; then
                    echo "✓ $domain_name Success"
                else
                    echo "✗ $domain_name ERROR!"
                fi
                echo "---"
            else
                echo "Skipping (unvalidated format): $domain_name"
            fi
        else
            echo "Skipping (system folder): $domain_name"
        fi
    fi
done

echo "================================"
echo "Done!"
