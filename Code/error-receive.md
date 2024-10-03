ts=2024-10-03T14:05:45.816871766Z caller=main.go:77 level=debug msg="maxprocs: Leaving GOMAXPROCS=[2]: CPU quota undefined"
ts=2024-10-03T14:05:45.817760511Z caller=main.go:145 level=error err="unsupported format for label 'receive_replica=\"myreplicalabel\"'\nmain.parseFlagLabels\n\t/app/cmd/thanos/config.go:276\nmain.registerReceive.func1\n\t/app/cmd/thanos/receive.go:66\nmain.main\n\t/app/cmd/thanos/main.go:143\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650\nparse labels\nmain.registerReceive.func1\n\t/app/cmd/thanos/receive.go:68\nmain.main\n\t/app/cmd/thanos/main.go:143\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650\npreparing receive command failed\nmain.main\n\t/app/cmd/thanos/main.go:145\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650"



The error message indicates that there's an issue with the format of the label `receive_replica="myreplicalabel"`. It seems the label format is not supported. Here's how you can fix it:

1. **Correct the Label Format**: The label should be formatted correctly without the extra quotes. Try updating your command to:
   ```sh
   --label=receive_replica=myreplicalabel
   ```

2. **Update Docker Compose File**: If you're using a Docker Compose file, make sure the label is correctly formatted there as well.

3. **Restart the Container**: After making the changes, restart the container to apply the new configuration.

Here's the updated command for reference:
```sh
/bin/thanos receive --http-address=0.0.0.0:10902 --grpc-address=0.0.0.0:10941 --remote-write.address=0.0.0.0:19291 --log.level=debug --label=receive_replica=myreplicalabel
```

Give this a try and let me know if it resolves the issue!