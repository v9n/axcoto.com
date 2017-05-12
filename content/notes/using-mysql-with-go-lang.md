+++
date = "2017-05-17T21:21:48-07:00"
title = "using mysql with go lang"
draft = true

tags = [ "hugo", "haproxy", "ssl", "letencrypt" ]
categories = [
  "Development",
]
+++

We'll start with the most popular one: "github.com/go-sql-driver/mysql". 

First, let's create a package to handle/maintain connection.


```
package db

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
	"time"
)

var Conn *sql.DB

func init() {
	var err error
	Conn, err = sql.Open("mysql", "db")
	checkErr(err)

	Conn.SetMaxOpenConns(10)
	Conn.SetMaxIdleConns(10)
	Conn.SetConnMaxLifetime(time.Duration(1800) * time.Second)
}

func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}
```

Now we can create a handler to query it:

```
type Row struct (
	ID `json:"id"`
	Name `json:"name"`
)

func Find(q string) {
	var rows []*Rows

	rows, err := db.Conn.Query(q)
	if err != nil {
		return nil, err
	}

	for rows.Next() {
		a := Row{}
		rows.Scan(&a.ID, &a.Name)
		advices = append(advices, &a)
	}
	rows.Close()
}
```

However, after awhile with Benchmark, I realize the performanc wasn't that great.

Let's enter https://github.com/gocraft/dbr. DBR promise to give better perfomance.


Optionally, we can hook into its with a event logger for metric
instrument

```
package db

import (
	"log"
)

type ELog struct {
}

// Event receives a simple notification when various events occur
func (n *ELog) Event(eventName string) {
	log.Println(eventName)
}

// EventKv receives a notification when various events occur along with
// optional key/value data
func (n *ELog) EventKv(eventName string, kvs map[string]string) {
	log.Println(eventName, kvs)
}

// EventErr receives a notification of an error if one occurs
func (n *ELog) EventErr(eventName string, err error) error {
	log.Println(eventName, err)
	return err
}

// EventErrKv receives a notification of an error if one occurs along with
// optional key/value data
func (n *ELog) EventErrKv(eventName string, err error, kvs map[string]string) error {
	return err
}

// Timing receives the time an event took to happen
func (n *ELog) Timing(eventName string, nanoseconds int64) {
	log.Println(eventName, " take ", nanoseconds)
}

// TimingKv receives the time an event took to happen along with optional key/value data
func (n *ELog) TimingKv(eventName string, nanoseconds int64, kvs map[string]string) {
	log.Println(eventName, " take ", nanoseconds, kvs)
}
```

This does nothing fancy but log the time so we can easily do benchmark in dev modes as a quick and dirty way


