for i in $(oc get clusteroperators --no-headers=true | awk '{print $1}')
do
    echo -n "$i  "; oc get clusteroperator $i -o=jsonpath='{range .status.conditions[*]}{.type}{" "}{.status}{" "}{.message}{"\n"}{end}' | grep Available
    #oc get clusteroperator $i -o=jsonpath='{range .status.conditions[*]}{.type}{" "}{.status}{" "}{.message}{"\n"}{end}' | grep Available | grep False
done
