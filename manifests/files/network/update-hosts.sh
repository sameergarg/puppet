check="127.0.0.1	s7v1.scene7.com"; 
filename="/etc/hosts";
[[ -n $(grep "^$check\$" $filename) ]] && echo "entry present" || (echo >> $filename; echo "$check" >> $filename)

check="127.0.0.1	test-e2.scene7.com"; 
filename="/etc/hosts";
[[ -n $(grep "^$check\$" $filename) ]] && echo "entry present" || (echo >> $filename; echo "$check" >> $filename)
