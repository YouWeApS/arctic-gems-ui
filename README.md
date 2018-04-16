# Arctic Core API gem

This gem is used by the arctic receivers to interact with and send data to the
arctic core API.

## Documentation

The documentation is generated from the slate-app in the documentation folder, and is available here: https://youweaps.github.io/arctic-gems-core

### Publishing documentation

First make sure that all code is tested and committed to the Github master branch.

The deploy the documentation to github pages:

```bash
cd documentation && ./deploy.sh && cd -
```

### Running documentation server locally

To run the documentation slate app locally:

```bash
cd documentation
bundle install
bundle exec middleman server # http://localhost:4567
```
