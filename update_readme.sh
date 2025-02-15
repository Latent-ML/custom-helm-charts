#!/usr/bin/env bash

# Define the README file
README_FILE="README.md"

# Define the charts directory (assumes current directory is the repo root)
CHARTS_DIR="$(pwd)"

# Header for README
cat >"$README_FILE" <<EOL
# Custom Helm Charts Repository

This repository contains forked and customized Helm charts for Latent hosted applications.  
Helm repo address: [https://latent-ml.github.io/custom-helm-charts](https://latent-ml.github.io/custom-helm-charts)

## Included Charts

| Date       | Chart  | Version |
|------------|--------|---------|
EOL

# Find all directories that contain a Chart.yaml file (identifying them as Helm charts)
CHARTS=$(find "$CHARTS_DIR" -mindepth 1 -maxdepth 1 -type d -exec test -f "{}/Chart.yaml" \; -print | sort)

# Append each chart to the README
if [ -z "$CHARTS" ]; then
	echo "| - | No Helm charts found | - |" >>"$README_FILE"
else
	for chart in $CHARTS; do
		CHART_NAME=$(basename "$chart")
		CHART_FILE="$chart/Chart.yaml"

		# Extract version from Chart.yaml
		CHART_VERSION=$(grep -E '^version:' "$CHART_FILE" | awk '{print $2}')
		[ -z "$CHART_VERSION" ] && CHART_VERSION="Unknown"

		# Get the last modification date of Chart.yaml
		if [[ "$OSTYPE" == "darwin"* ]]; then
			# macOS
			CHART_DATE=$(stat -f "%Sm" -t "%Y-%m-%d" "$CHART_FILE")
		else
			# Linux
			CHART_DATE=$(stat -c %y "$CHART_FILE" | cut -d' ' -f1)
		fi

		echo "| $CHART_DATE | [$CHART_NAME](./$CHART_NAME) | $CHART_VERSION |" >>"$README_FILE"
	done
fi

# Output completion message
echo "README.md has been updated."
