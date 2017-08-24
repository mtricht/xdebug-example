yum install -y httpd
systemctl enable httpd.service
sed -i 's/User apache/User vagrant/i' /etc/httpd/conf/httpd.conf
sed -i 's/Group apache/Group vagrant/i' /etc/httpd/conf/httpd.conf
sed -i 's/EnableSendfile on/EnableSendfile off/i' /etc/httpd/conf/httpd.conf
sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ { s/AllowOverride None/AllowOverride All/i }' /etc/httpd/conf/httpd.conf
sed -i 's/\/var\/www\/html/\/vagrant\/public/i' /etc/httpd/conf/httpd.conf

sed -i 's/^SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config

yum install epel-release -y
rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install yum-utils -y
yum-config-manager --enable remi-php71
yum install -y php php-pear php-devel

yum install -y gcc gcc-c++ autoconf automake
pecl install Xdebug
if [ ! -f /etc/php.d/xdebug.ini ]
then
echo "[xdebug]
zend_extension=\"/usr/lib64/php/modules/xdebug.so\"
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
xdebug.remote_host = 192.168.1.7" > /etc/php.d/xdebug.ini
fi

chcon -R -t httpd_sys_content_t /vagrant/

systemctl restart httpd