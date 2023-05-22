c = get_config()  #noqa
c.LabApp.collaborative = True
c.LabApp.workspaces_dir = '/workspace'
c.ServerApp.allow_remote_access = True
c.ServerApp.allow_root = True
c.ServerApp.allow_origin = '*'
c.NotebookApp.allow_origin = '*'
# default service port: 8888
c.ServerApp.ip = '0.0.0.0'