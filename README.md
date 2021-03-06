# R Packages Index
Solution to a coding exercise given by XXX company.

## Development
I recommend running this project with docker. To get started, follow the instructions bellow.

### Prerequisites

 1. **Docker**

    Install docker following the instructions from the [official docker page](https://docs.docker.com/engine/installation/):
      - [For Mac](https://docs.docker.com/docker-for-mac/install)
      - [For Windows](https://docs.docker.com/docker-for-windows/install)

 And that's it!

### Running the app
#### 1. Clone the repository

```bash
> git clone git@github.com:ammancilla/r-packages-index-coding-exercise.git
```

#### 2. Go to the project folder

```bash
> cd /path/to/project-folder
```

#### 3. Build the project docker image

```bash
> docker/build
```

#### 5. Start the application

```bash
docker/server
```

#### 6. Run the migrations

```bash
docker/migrate
```

#### 7. Have fun!

Visit [localhost:3000](http://localhost:3000) in your prefered browser.

### Testing
To run the test suite execute:

```bash
docker/rspec
```
