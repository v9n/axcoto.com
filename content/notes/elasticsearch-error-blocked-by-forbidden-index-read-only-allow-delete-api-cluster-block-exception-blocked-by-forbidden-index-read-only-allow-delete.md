+++
date = "2019-10-18T11:26:50-07:00"
title = "elasticsearch error: blocked by: [FORBIDDEN/12/index read-only / allow delete (api)];: [cluster_block_exception] blocked by: [FORBIDDEN/12/index read-only / allow delete"
draft = false

tags = []
+++

Today when I saved a visualization in Kiabana, it throws this error

```
isualization Editor: blocked by: [FORBIDDEN/12/index read-only / allow
delete (api)];: [cluster_block_exception] blocked by:
[FORBIDDEN/12/index read-only / allow delete
```

Kibana stores its configuration in ElasticSearch. So this is an error
caused by ElasticSearch.

When operating elasticsearch, at certain point you may hit this error.
It means that elasticsearch has entered read-only mode.

This problem is cause by an ElasticSearch config: *cluster.routing.allocation.disk.watermark.flood_stage*

According to document:


  Controls the flood stage watermark. It defaults to 95%, meaning that
  Elasticsearch enforces a read-only index block
  (index.blocks.read_only_allow_delete) on every index that has one or
  more shards allocated on the node that has at least one disk exceeding
  the flood stage. This is a last resort to prevent nodes from running out
  of disk space. The index block must be released manually once there is
  enough disk space available to allow indexing operations to continue.

Once this kicked in, even if you manually cleanup ElasticSearch they
still not be able to reset to write-able mode. You need to manually
reset it:

```
PUT _settings
    {
    "index": {
    "blocks": {
    "read_only_allow_delete": "false"
    }
    }
    }
```

or for a specific index:

```
PUT /twitter/_settings
{
  "index.blocks.read_only_allow_delete": null
}
```
