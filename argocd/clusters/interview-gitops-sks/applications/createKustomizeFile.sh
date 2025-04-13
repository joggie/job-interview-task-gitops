SCRIPT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

(cd $SCRIPT_DIR && rm -f kustomization.yaml && kustomize create --autodetect --recursive)