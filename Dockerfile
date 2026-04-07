# syntax=docker/dockerfile:1
# Based on https://github.com/effytech/freshservice_mcp
# Original authors: Gopi Krishnan, Maanaesh Swamy, Vijay Ragunath (effy.co.in)
# Docker Hub: https://hub.docker.com/r/madjohn/freshservice-mcp

FROM python:3.13-slim

LABEL org.opencontainers.image.title="Freshservice MCP Server" \
      org.opencontainers.image.description="MCP server for Freshservice ITSM integration. Based on https://github.com/effytech/freshservice_mcp" \
      org.opencontainers.image.source="https://github.com/effytech/freshservice_mcp" \
      org.opencontainers.image.authors="Gopi Krishnan <gopi@effy.co.in>, Maanaesh Swamy <maanaesh.s@effy.co.in>, Vijay Ragunath <vijay.r@effy.co.in>" \
      org.opencontainers.image.licenses="MIT"

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY pyproject.toml ./
COPY src ./src
COPY entrypoint.py ./

RUN pip install --no-cache-dir .

# Default values (override via -e flags)
ENV FASTMCP_HOST=0.0.0.0
ENV FASTMCP_PORT=8012
ENV FRESHSERVICE_DOMAIN=""
ENV FRESHSERVICE_APIKEY=""

EXPOSE 8012

ENTRYPOINT ["python", "entrypoint.py"]
