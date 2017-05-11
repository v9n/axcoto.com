+++
date = "2017-05-11T12:55:05-07:00"
title = "rest api with clojure"
draft = true

+++

Let's build an api to store podcast in Clojure.

```
lein new compojure minicast
```

We'll use MySQL, JSON so let's update project.cli to include those
dependencies


```clojure
                 [ring/ring-json "0.3.1"]
                 [korma "0.3.0-RC5"]
                 [blackwater "0.0.9"]
                 [mysql/mysql-connector-java "5.1.6"]]
```

We also want to track minicastormance with newrelic, so let's add them as well:

```
:java-agents [[com.newrelic.agent.java/newrelic-agent "3.38.0"]]
```

The whole file loosk like this:

```
(defproject minicast "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :min-lein-version "2.0.0"
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [compojure "1.5.1"]
                 [ring/ring-defaults "0.2.1"]
                 [ring/ring-json "0.3.1"]
                 [korma "0.3.0-RC5"]
                 [blackwater "0.0.9"]
                 [mysql/mysql-connector-java "5.1.6"]]

  :java-agents [[com.newrelic.agent.java/newrelic-agent "3.38.0"]]

  :plugins [[lein-ring "0.9.7"]]
  :ring {:handler minicast.handler/app}
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        [ring/ring-mock "0.3.0"]]}})
```

`lein` will generate the app with a single file `handler.clj` in src/minicast/handler.clj where
we will define our router and handle.

Since we want to return JSON and want this to handle seamslessly, we need some middleware and macro

```
(ns perf.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]

            [ring.middleware.json :as json]
            [ring.util.response :refer [response]]
            [perf.query :refer :all]
            ))

(defroutes app-routes
  (GET "/" [] "Hello World")
  (GET "/morgos/api/user/:id/filtered_content_match" {params :params}
    (response (get-advice params)))
    ;(response (get-advice (Integer/parseInt id))))

  (route/not-found "Not Found"))


(def app
  (-> (wrap-defaults app-routes site-defaults)
      (json/wrap-json-params)
      (json/wrap-json-response)))
```


# NewRelic

To start with newrelic, you will need to download the newrelic agent, we can put them into
a folder call vendor or something and invoke lein like this:

```
NEWRELIC_APP_NAME=Minicast NEWRELIC_LICENSE_KEY=lic lein ring headless-server
```


