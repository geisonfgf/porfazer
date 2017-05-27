CREATE TABLE lists_todolist (
    id integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title varchar(128) NOT NULL,
    created_at datetime NOT NULL,
    creator_id integer NULL
    REFERENCES auth_user (id)
);

CREATE TABLE lists_todo (
    id integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    description varchar(128) NOT NULL,
    created_at datetime NOT NULL,
    finished_at datetime NULL,
    is_finished bool NOT NULL,
    creator_id integer NULL REFERENCES auth_user (id), todolist_id integer NOT NULL
    REFERENCES lists_todolist (id)
);

CREATE TABLE django_content_type (
    id integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    app_label varchar(100) NOT NULL,
    model varchar(100) NOT NULL
);

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id integer NOT NULL REFERENCES auth_user (id),
    permission_id integer NOT NULL REFERENCES auth_permission (id)
);

CREATE TABLE auth_user_groups (
    id integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id integer NOT NULL REFERENCES auth_user (id),
    group_id integer NOT NULL REFERENCES auth_group (id)
);

CREATE TABLE auth_user (
    id integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    password varchar(128) NOT NULL,
    last_login datetime NULL,
    is_superuser bool NOT NULL,
    first_name varchar(30) NOT NULL,
    last_name varchar(30) NOT NULL,
    email varchar(254) NOT NULL,
    is_staff bool NOT NULL,
    is_active bool NOT NULL,
    date_joined datetime NOT NULL,
    username varchar(150) NOT NULL UNIQUE
);

CREATE TABLE auth_permission (
    id integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    content_type_id integer NOT NULL REFERENCES django_content_type (id),
    codename varchar(100) NOT NULL,
    name varchar(255) NOT NULL
);

CREATE TABLE auth_group_permissions (
    id integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    group_id integer NOT NULL REFERENCES auth_group (id),
    permission_id integer NOT NULL REFERENCES auth_permission (id));

CREATE TABLE auth_group (
    id integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(80) NOT NULL UNIQUE
);