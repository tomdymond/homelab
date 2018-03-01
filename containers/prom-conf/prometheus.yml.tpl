scrape_configs:
  - job_name: 'snmp'
    static_configs:
      - targets:
        - %SNMP_DEVICE%  # SNMP device.
    metrics_path: /snmp
    params:
      module: [if_mib]
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: %SNMP_EXPORTER_IP%:9116  # The SNMP exporter's real hostname:port.

