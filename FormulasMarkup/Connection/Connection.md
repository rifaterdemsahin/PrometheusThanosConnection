# Setting Up Metric Collection from Thanos to Prometheus

To set up metric collection from Thanos to Prometheus, follow these steps:

## Prerequisites
- A running Prometheus instance
- A running Thanos instance

## Steps

1. **Configure Prometheus to use Thanos Sidecar:**
    - Add the Thanos Sidecar to your Prometheus configuration.
    - Update your Prometheus configuration file (`prometheus.yml`) to include the Thanos Sidecar.

    ```yaml
    - job_name: 'thanos-sidecar'
      static_configs:
         - targets: ['<thanos-sidecar-ip>:<port>']
    ```

2. **Start Thanos Sidecar:**
    - Run the Thanos Sidecar alongside your Prometheus instance.

    ```sh
    thanos sidecar \
      --tsdb.path            /path/to/prometheus/data \
      --prometheus.url       http://<prometheus-ip>:<port> \
      --grpc-address         0.0.0.0:<grpc-port> \
      --http-address         0.0.0.0:<http-port>
    ```

3. **Configure Thanos Querier:**
    - Set up Thanos Querier to query metrics from the Thanos Sidecar.

    ```sh
    thanos query \
      --http-address         0.0.0.0:<http-port> \
      --store                <thanos-sidecar-ip>:<grpc-port>
    ```

4. **Verify Configuration:**
    - Access the Thanos Querier UI to ensure metrics are being collected and queried correctly.

    ```sh
    http://<thanos-querier-ip>:<http-port>
    ```

## Additional Resources
- [Thanos Documentation](https://thanos.io/tip/thanos/getting-started.md/)
- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)

By following these steps, you should be able to set up metric collection from Thanos to Prometheus successfully.