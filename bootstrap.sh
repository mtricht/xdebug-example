yum install -y httpd
systemctl enable httpd.service
sed -i 's/User apache/User vagrant/i' /etc/httpd/conf/httpd.conf
sed -i 's/Group apache/Group vagrant/i' /etc/httpd/conf/httpd.conf
sed -i 's/EnableSendfile on/EnableSendfile off/i' /etc/httpd/conf/httpd.conf
sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ { s/AllowOverride None/AllowOverride All/i }' /etc/httpd/conf/httpd.conf

rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install -y php70w

yum install -y gcc gcc-c++ autoconf automake php70w-pear php70w-devel
pecl install Xdebug
if [ ! -f /etc/php.d/xdebug.ini ]
then
echo "[xdebug]
zend_extension=\"/usr/lib64/php/modules/xdebug.so\"
xdebug.remote_enable = 1
xdebug.remote_autostart = 1" > /etc/php.d/xdebug.ini
fi

ln -fs /vagrant /var/www

systemctl restart httpd