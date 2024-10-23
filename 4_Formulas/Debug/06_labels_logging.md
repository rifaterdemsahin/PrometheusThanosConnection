@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $    kubectl logs thanos-sidecar-68996566c8-mkjpq -n monitoring
ts=2024-10-23T13:20:14.995363692Z caller=sidecar.go:139 level=info msg="no supported bucket was configured, uploads will be disabled"
ts=2024-10-23T13:20:14.997256664Z caller=sidecar.go:215 level=info msg="successfully loaded prometheus version"
ts=2024-10-23T13:20:14.998489892Z caller=sidecar.go:238 level=info msg="successfully loaded prometheus external labels" external_labels={}
ts=2024-10-23T13:20:14.998581122Z caller=main.go:145 level=error err="no external labels configured on Prometheus server, uniquely identifying external labels must be configured; see https://thanos.io/tip/thanos/storage.md#external-labels for details.\nmain.runSidecar\n\t/app/cmd/thanos/sidecar.go:249\nmain.registerSidecar.func1\n\t/app/cmd/thanos/sidecar.go:104\nmain.main\n\t/app/cmd/thanos/main.go:143\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650\npreparing sidecar command failed\nmain.main\n\t/app/cmd/thanos/main.go:145\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650"
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ git pull; git add . && git commit -m "Refine task priorities in copilot" && git push;clear.exe git pull; git add . && git commit -m "Refine task priorities in copilot" && git push;clear.exe 
Already up to date.
[main 7c1f8ae] Refine task priorities in copilot
 Author: Erdem <rifaterdemsahin@gmail.com>
 2 files changed, 59 insertions(+)
 create mode 100644 6_Semblance/Errors/SideCarMinikubeOn/multifile_context_semblance_check.md
Enumerating objects: 16, done.
Counting objects: 100% (16/16), done.
Delta compression using up to 4 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (9/9), 2.76 KiB | 2.76 MiB/s, done.
Total 9 (delta 6), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (6/6), completed with 6 local objects.
To https://github.com/rifaterdemsahin/PrometheusThanosConnection
   9a4142b..7c1f8ae  main -> main
bash: clear.exe: command not found
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean