cd schemas

export FILENAME_FORMAT="{kind}-{group}-{version}"
#curl --fail -SsLO https://raw.githubusercontent.com/yannh/kubeconform/master/scripts/openapi2jsonschema.py
#chmod +x openapi2jsonschema.py

rm -f *.json
kubectl get crd -o yaml > crds.yaml # maybe we could have tool for this step? Or maybe even incluing the openapi2jsonschema step

# prevent parsing issues python3.6
sed -i '' 's/^\(\s\+- \)\(=~\|=\)$/\1"\2"/' crds.yaml

python3 openapi2jsonschema.py crds.yaml

# Some schemas we make a bit stricter:
#for a in *domain*; do
#    jq '. += {"additionalProperties": false}' < "$a" > "$a.tmp" && mv "$a.tmp" "$a"
#done