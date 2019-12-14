### `Backup Script`

Backup script of this project is written in `backup_docker_to_s3.sh` file 

First you'll have to install [backup-docker npm backage](https://www.npmjs.com/package/backup-docker) using command `npm i -g backup-docker`

To run this in terminal: `sudo ./backup_docker_to_s3.sh container_name`

i.e `sudo ./backup_docker_to_s3.sh your_docker_container_name`

This command will create and store backup to aws s3 

### `Restore backup` 

To restore backup you need to unzip backup zip file in a folder and then open terminal in that folder and run `sudo backup-docker restore container_name` 

i.e `sudo backup-docker restore your_docker_container_name`

Make sure you have changed network ID to your docker network ID in containers/container_name.json file

### `AWS S3 Backup`

To backup to s3 you need to install `s3cmd` command line interface and add your s3 credential in it. [here](https://s3tools.org/usage) is the doc to set that.


## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.


## Authors

* **Salahudin Malik** - *Initial work* - [SalahudinMalik](https://github.com/SalahuidnMalik)

See also the list of [contributors](https://github.com/salahudinmalik/project) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details