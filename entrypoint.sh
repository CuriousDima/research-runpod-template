#!/usr/bin/env bash

if [ -n "$RUNPOD_SECRET_hf_token" ]; then
    hf auth login --token "$RUNPOD_SECRET_hf_token" --add-to-git-credential \
        || echo "Warning: hf auth login failed; continuing without HuggingFace login" >&2
fi

if [ -n "$RUNPOD_SECRET_kaggle_token" ]; then
    mkdir -p /root/.kaggle
    printf '%s' "$RUNPOD_SECRET_kaggle_token" > /root/.kaggle/access_token
    chmod 600 /root/.kaggle/access_token
fi

if [ -n "$RUNPOD_SECRET_sakana_api_key" ]; then
    curl -fsS -o /dev/null \
        -H "Authorization: Bearer $RUNPOD_SECRET_sakana_api_key" \
        https://api.sakana.ai/v1/models \
        || echo "Warning: Sakana API key validation failed; Pi may not work with sakana/* models" >&2
fi

exec /opt/nvidia/nvidia_entrypoint.sh "$@"
