
FILES="ansible-hosts Vagrantfile master.sh node.sh ceph-install.sh"
sed -i "s/100.64.11.11/100.64.11.11/" $FILES
sed -i "s/100.64.11.12/100.64.11.12/" $FILES
sed -i "s/100.64.11.13/100.64.11.13/" $FILES
sed -i "s/100.64.11.14/100.64.11.14/" $FILES
sed -i "s/100.64.11.15/100.64.11.15/" $FILES
sed -i "s/100.64.11.16/100.64.11.16/" $FILES

vagrant up --provision
