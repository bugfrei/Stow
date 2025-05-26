tmux kill-session -t CICDDemo
tmux new-session -d -s CICDDemo -n cicd
tmux switch-client -t CICDDemo
# tmux new-window -t CICDDemo -n cicd
tmux split-window -v -t CICDDemo:cicd
tmux split-window -h -t CICDDemo:cicd.1
tmux split-window -v -t CICDDemo:cicd.1
tmux split-window -h -t CICDDemo:cicd.4
tmux resize-pane -t CICDDemo:cicd.1 -y 1

Start-Sleep -Seconds 3
tmux send-keys -t CICDDemo:cicd.1 'title Green Black LOCAL' C-m
tmux send-keys -t CICDDemo:cicd.2 'cd /Users/carstenschlegel/temp/s41_demoapp/runners/runner1; ./run.sh' C-m
tmux send-keys -t CICDDemo:cicd.3 ' enter' C-m
tmux send-keys -t CICDDemo:cicd.5 'cd /Users/carstenschlegel/temp/s41_demoapp/s41_demoapp; vim -p ./webapp/view/View1.view.xml ./.github/workflows/node.js.yml /Users/carstenschlegel/temp/s41_demoapp/s41_demoapp/data.json /Users/carstenschlegel/temp/s41_demoapp/s41_demoapp/webapp/controller/View1.controller.js' C-m
tmux send-keys -t CICDDemo:cicd.4 'cd /Users/carstenschlegel/temp/s41_demoapp/s41_demoapp; git st' C-m



Start-Sleep -Seconds 2
tmux send-keys -t CICDDemo:cicd.3 'tmux a' C-m
tmux send-keys -t CICDDemo:cicd.5 'gt'
tmux send-keys -t CICDDemo:cicd.4 'OpenBrowser "https://sap-s41.suportis.local:44301/sap/bc/ui2/flp?sap-client=100&sap-language=EN#Shell-home" -DefaultBrowser:$true' C-m

Start-Sleep -Seconds 1
tmux send-keys -t CICDDemo:cicd.3 C-b '3'
tmux send-keys -t CICDDemo:cicd.4 'url open' C-m

tmux new-window -t CICDDemo -n git

Start-Sleep -Seconds 3
tmux send-keys -t CICDDemo:git.1 'repodel Demogit;del ~/temp/demogit/* -Re -Fo;cd ~/temp/demogit;echo "Quellcode" >app' C-m

tmux select-window -t CICDDemo:cicd
tmux select-pane -t CICDDemo:cicd.5
tmux send-keys -t CICDDemo:cicd.4 '$a = (Dir); $a += (dir -hi); $a | Sort-Object Name' C-m


