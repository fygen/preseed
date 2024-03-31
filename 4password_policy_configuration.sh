user=$(who | cut -d ' ' -f1)
sudo sed -i 's/password \[success=2 default=ignore\] pam_unix.so obscure sha512/password [success=2 default=ignore] pam_unix.so obscure sha512 minlen=10/' /etc/pam.d/common-password
sudo sed -i 's/pam_pwquality.so retry=3/pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 lcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root/' /etc/pam.d/common-password
echo "common-password updated?"
sudo nano /etc/pam.d/common-password

sudo sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS 30/' /etc/login.defs
sudo sed -i 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS 2/' /etc/login.defs
sudo sed -i 's/PASS_WARN_AGE\t7/PASS_WARN_AGE 7/' /etc/login.defs
# PASS_MAX_DAYS 30 > PASS_MIN_DAYS 2 > PASS_WARN_AGE 7
echo "login.defs updated?"
sudo nano /etc/login.defs
sudo chage --maxdays 30 --mindays 2 --warndays 7 $user
sudo chage --maxdays 30 --mindays 2 --warndays 7 root
# sudo reboot
chage -l $user