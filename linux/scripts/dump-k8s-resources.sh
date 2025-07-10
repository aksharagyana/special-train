#!/bin/bash

# Exit on error
set -e

# Check for namespace argument
if [ -z "$1" ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

NAMESPACE="$1"
OUTPUT_DIR="./k8s-dump-$NAMESPACE"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "Fetching resources from namespace: $NAMESPACE"

# Get all resource types that support `get` in the namespace
RESOURCE_TYPES=$(kubectl api-resources --verbs=list,get --namespaced -o name)

# Loop through each resource type
for RESOURCE in $RESOURCE_TYPES; do
  # Get list of resource names
  NAMES=$(kubectl get "$RESOURCE" -n "$NAMESPACE" -o jsonpath="{range .items[*]}{.metadata.name}{'\n'}{end}")

  for NAME in $NAMES; do
    KIND=$(kubectl get "$RESOURCE" "$NAME" -n "$NAMESPACE" -o jsonpath="{.kind}")
    FILE_NAME="${KIND,,}-$NAME.yaml"  # lowercase kind
    echo "Dumping $KIND/$NAME to $FILE_NAME"
    kubectl get "$RESOURCE" "$NAME" -n "$NAMESPACE" -o yaml > "$OUTPUT_DIR/$FILE_NAME"
  done
done

echo "All resources saved to: $OUTPUT_DIR"
