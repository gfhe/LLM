c = get_config()  #noqa
c.NotebookApp.notebook_dir = '/workspace'
c.ServerApp.allow_remote_access = True
c.ServerApp.allow_root = True
c.ServerApp.allow_origin = '*'
c.NotebookApp.allow_origin = '*'
# default service port: 8888
c.ServerApp.ip = '0.0.0.0'
c.NotebookApp.password = 'argon2:$argon2id$v=19$m=10240,t=10,p=8$Ve/dYyj5TsZVh7G0j+vDkw$Yy3hpl+YiK8p23YSSO9dJw1qKL1QfJJYqHoTMmV/QwA'
