FROM squidfunk/mkdocs-material

RUN pip install --no-cache-dir \
  mkdocs-print-site-plugin

ENTRYPOINT ["/sbin/tini", "--", "mkdocs"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
