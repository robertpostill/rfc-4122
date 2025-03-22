#lang racket/base

(require mock
         mock/rackunit
         racket/function
         rackunit
         rackunit/text-ui
         rfc-4122/node)

(define IFCONFIG-OUTPUT
  "lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384\n\toptions=1203<RXCSUM,TXCSUM,TXSTATUS,SW_TIMESTAMP>\n\tinet 127.0.0.1 netmask 0xff000000\n\tinet6 ::1 prefixlen 128 \n\tinet6 fe80::1%lo0 prefixlen 64 scopeid 0x1 \n\tnd6 options=201<PERFORMNUD,DAD>\ngif0: flags=8010<POINTOPOINT,MULTICAST> mtu 1280\nstf0: flags=0<> mtu 1280\nen3: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500\n\toptions=460<TSO4,TSO6,CHANNEL_IO>\n\tether 12:34:56:78:9a:bc\n\tmedia: autoselect <full-duplex>\n\tstatus: inactive\nen4: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500\n\toptions=460<TSO4,TSO6,CHANNEL_IO>\n\tether 82:68:2d:a1:5c:04\n\tmedia: autoselect <full-duplex>\n\tstatus: inactive\nen1: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500\n\toptions=460<TSO4,TSO6,CHANNEL_IO>\n\tether 82:68:2d:a1:5c:01\n\tmedia: autoselect <full-duplex>\n\tstatus: inactive\nen2: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500\n\toptions=460<TSO4,TSO6,CHANNEL_IO>\n\tether 82:68:2d:a1:5c:00\n\tmedia: autoselect <full-duplex>\n\tstatus: inactive\nbridge0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500\n\toptions=63<RXCSUM,TXCSUM,TSO4,TSO6>\n\tether 82:68:2d:a1:5c:01\n\tConfiguration:\n\t\tid 0:0:0:0:0:0 priority 0 hellotime 0 fwddelay 0\n\t\tmaxage 0 holdcnt 0 proto stp maxaddr 100 timeout 1200\n\t\troot id 0:0:0:0:0:0 priority 0 ifcost 0 port 0\n\t\tipfilter disabled flags 0x0\n\tmember: en1 flags=3<LEARNING,DISCOVER>\n\t        ifmaxaddr 0 port 7 priority 0 path cost 0\n\tmember: en2 flags=3<LEARNING,DISCOVER>\n\t        ifmaxaddr 0 port 8 priority 0 path cost 0\n\tmember: en3 flags=3<LEARNING,DISCOVER>\n\t        ifmaxaddr 0 port 5 priority 0 path cost 0\n\tmember: en4 flags=3<LEARNING,DISCOVER>\n\t        ifmaxaddr 0 port 6 priority 0 path cost 0\n")

(define tests
  (test-suite
   "node id tests"
   (test-suite
    "node-id?"
    (test-case
        "the node-id is good"
      (check-true (node-id? "00a0c91e6bf6")))
    (test-case
        "the node-id is blank"
      (check-false (node-id? "")))
    (test-case
        "the node-id is bad"
      (check-false (node-id? "bad")))
    (test-case
        "the node-id is not a string"
      (check-false (node-id? #f))))
   (test-suite
    "generate-node-id"
    (test-case
        "it generates a valid node-id string"
      (check-true (node-id? (generate-node-id)))))
   (test-suite
    "get-mac-address"
    (test-case
        "it generates a mac from the os using ifconfig"
      (define system-mock (mock #:behavior (const IFCONFIG-OUTPUT)))
      (get-mac-address #:ifconfig-invoker system-mock)
      (check-mock-called-with? system-mock (arguments 'foo))

      )
    (test-case
        "it generates a psuedo mac when no address is available"))))

(module+ test
  (void
   (run-tests tests)))
