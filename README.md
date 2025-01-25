[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

<!-- PROJECT HEADER -->
<br />
<p align="center">
  <!-- https://github.com/stefanjudis/github-light-dark-image-example -->
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.github.com/Good-Games-Munich/assets/main/logos/GGM_logo_white.png">
    <img alt="Logo" src="https://raw.github.com/Good-Games-Munich/assets/main/logos/GGM_logo_black.png" height="150">
  </picture>

  <h3 align="center">🎮 dwc-server</h3>

  <p align="center">
    ·
    <a href="https://github.com/Good-Games-Munich/dwc-server/issues">Report Bug</a>
    ·
    <a href="https://github.com/Good-Games-Munich/dwc-server/issues">Request Feature</a>
    ·
  </p>
</p>

<!-- ABOUT THE PROJECT -->

## About The Project

Custom multiplayer server for a number of nintendo games based on [dwc_network_server_emulator](https://github.com/barronwaffles/dwc_network_server_emulator) and [dwc-docker](https://github.com/TheForcer/dwc-docker).

## Setup

> [!WARNING]
> This setup is meant to be run on a local network only on a dedicated server. It maps port 80 and 53 to its host and uses unsecure HTTP.

1. Follow the [Customization](#customization) section.
2. Start up the container `docker-compose up --build`.

### Customization

Create a environment file `touch .env`. Override variables in the `{variable name}={variable value}` format.

| Variable                | Description                         | Default value |
| ----------------------- | ----------------------------------- | ------------- |
| `HOST_IP`               | IP of the docker host used for DNS. | none          |
| `DWC_ADMIN_USERNAME`    | DWC admin page username.            | none          |
| `DWC_ADMIN_PASSWORD`    | DWC admin page password.            | none          |
| `PRIMARY_FORWARD_DNS`   | Primary forward DNS.                | 8.8.8.8       |
| `SECONDARY_FORWARD_DNS` | Secondary forward DNS.              | 8.8.4.4       |

## Port mapping

| Protocol | Port  | Service                    |
| -------- | ----- | -------------------------- |
| TCP      | 80    | WebServer                  |
| TCP      | 8000  | StorageServer              |
| TCP      | 9000  | NasServer                  |
| TCP      | 9001  | InternalStatsServer        |
| TCP      | 27500 | GameSpyManager             |
| TCP      | 28910 | GameSpyServerBrowserServer |
| TCP      | 29900 | GameSpyProfileServer       |
| TCP      | 29901 | GameSpyPlayerSearchServer  |
| TCP      | 29920 | GameSpyGamestatsServer     |
| UDP      | 27900 | GameSpyQRServer            |
| UDP      | 27901 | GameSpyNatNegServer        |
| TCP      | 9003  | Dls1Server                 |
| TCP      | 9009  | AdminPage                  |
| TCP      | 9998  | RegisterPage               |


## Further documentation

https://github.com/barronwaffles/dwc_network_server_emulator/wiki

<!-- CONTRIBUTING -->

## Contributing

Follow [contributing](https://github.com/Good-Games-Munich/.github/wiki/workflows#contributing).

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/Good-Games-Munich/dwc-server.svg?style=flat-square
[contributors-url]: https://github.com/Good-Games-Munich/dwc-server/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Good-Games-Munich/dwc-server.svg?style=flat-square
[forks-url]: https://github.com/Good-Games-Munich/dwc-server/network/members
[stars-shield]: https://img.shields.io/github/stars/Good-Games-Munich/dwc-server.svg?style=flat-square
[stars-url]: https://github.com/Good-Games-Munich/dwc-server/stargazers
[issues-shield]: https://img.shields.io/github/issues/Good-Games-Munich/dwc-server.svg?style=flat-square
[issues-url]: https://github.com/Good-Games-Munich/dwc-server/issues
