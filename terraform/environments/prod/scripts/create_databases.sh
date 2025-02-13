#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRESQL_USERNAME" <<-EOSQL
  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'gitea') THEN
      CREATE USER gitea WITH ENCRYPTED PASSWORD 'gitea';
    END IF;
  END
  \$\$;

  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'gitea') THEN
      CREATE DATABASE gitea OWNER gitea;
    END IF;
  END
  \$\$;

  GRANT ALL PRIVILEGES ON DATABASE gitea TO gitea;

  -- Repeat for other users and databases
  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'vault') THEN
      CREATE USER vault WITH ENCRYPTED PASSWORD 'vault';
    END IF;
  END
  \$\$;

  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'vault') THEN
      CREATE DATABASE vault OWNER vault;
    END IF;
  END
  \$\$;

  GRANT ALL PRIVILEGES ON DATABASE vault TO vault;

  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'argocd') THEN
      CREATE USER argocd WITH ENCRYPTED PASSWORD 'argocd';
    END IF;
  END
  \$\$;

  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'argocd') THEN
      CREATE DATABASE argocd OWNER argocd;
    END IF;
  END
  \$\$;

  GRANT ALL PRIVILEGES ON DATABASE argocd TO argocd;

  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'prometheus') THEN
      CREATE USER prometheus WITH ENCRYPTED PASSWORD 'prometheus';
    END IF;
  END
  \$\$;

  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'prometheus') THEN
      CREATE DATABASE prometheus OWNER prometheus;
    END IF;
  END
  \$\$;

  GRANT ALL PRIVILEGES ON DATABASE prometheus TO prometheus;

  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'grafana') THEN
      CREATE USER grafana WITH ENCRYPTED PASSWORD 'grafana';
    END IF;
  END
  \$\$;

  DO \$\$
  BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'grafana') THEN
      CREATE DATABASE grafana OWNER grafana;
    END IF;
  END
  \$\$;

  GRANT ALL PRIVILEGES ON DATABASE grafana TO grafana;
EOSQL