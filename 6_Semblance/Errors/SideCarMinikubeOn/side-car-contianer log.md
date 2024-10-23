monitoring    thanos-sidecar-68996566c8-g7cbb    0/1     CrashLoopBackOff   6 (2m11s ago)   7m48s
monitoring    thanos-sidecar-7f9bb547b-7zdrc     0/1     ImagePullBackOff   0               7m48s

To show the logs for the `thanos-sidecar-7f9bb547b-7zdrc` pod, you can use the following command:

```sh
kubectl logs thanos-sidecar-7f9bb547b-7zdrc -n monitoring
kubectl logs thanos-sidecar-68996566c8-g7cbb -n monitoring
```

@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl logs thanos-sidecar-7f9bb547b-7zdrc -n monitoring
Error from server (BadRequest): container "thanos-sidecar" in pod "thanos-sidecar-7f9bb547b-7zdrc" is waiting to start: trying and failing to pull image

@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl logs thanos-sidecar-68996566c8-g7cbb -n monitoring
ts=2024-10-23T11:50:37.40157461Z caller=sidecar.go:139 level=info msg="no supported bucket was configured, uploads will be disabled"
ts=2024-10-23T11:50:37.404684639Z caller=sidecar.go:215 level=info msg="successfully loaded prometheus version"
ts=2024-10-23T11:50:37.406308728Z caller=sidecar.go:238 level=info msg="successfully loaded prometheus external labels" external_labels={}
ts=2024-10-23T11:50:37.406505143Z caller=main.go:145 level=error err="no external labels configured on Prometheus server, uniquely identifying external labels must be configured; see https://thanos.io/tip/thanos/storage.md#external-labels for details.\nmain.runSidecar\n\t/app/cmd/thanos/sidecar.go:249\nmain.registerSidecar.func1\n\t/app/cmd/thanos/sidecar.go:104\nmain.main\n\t/app/cmd/thanos/main.go:143\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650\npreparing sidecar command failed\nmain.main\n\t/app/cmd/thanos/main.go:145\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650"

