Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56A39687B
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 21:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhEaTvV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 15:51:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:32368 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231418AbhEaTvS (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 15:51:18 -0400
IronPort-SDR: FwF/s4PBsTufMwmPP8C3JKsKh27fNOun/vVBJ4ztz0s6/DtSiwQk363B+U28EngKyDYjG9+C7Z
 E5Q66H05+Jdg==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="200396761"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="200396761"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 12:49:30 -0700
IronPort-SDR: tr++MuEQ1FbwlylOLS9zb64sl8VUaVMcrSnE/6dTPNGmaBGbVPW8w5SPq0ag1DsK9ymEYeWRHf
 fPUWwjnf2p+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="482206806"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 31 May 2021 12:49:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F326F11D; Mon, 31 May 2021 22:49:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/7] docs: firmware-guide: ACPI: Add a PWM example
Date:   Mon, 31 May 2021 22:49:41 +0300
Message-Id: <20210531194947.10770-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When PWM support for ACPI has been added into the kernel, it missed
the documentation update. Hence update documentation here.

Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: updated example to use 600 ms instead of 600 us (looks saner)
 .../firmware-guide/acpi/enumeration.rst       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 9f0d5c854fa4..f588663ba906 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -258,6 +258,38 @@ input driver::
 		.id_table	= mpu3050_ids,
 	};
 
+Reference to PWM device
+=======================
+
+Sometimes a device can be a consumer of PWM channel. Obviously OS would like
+to know which one. To provide this mapping the special property has been
+introduced, i.e.::
+
+    Device (DEV)
+    {
+        Name (_DSD, Package ()
+        {
+            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+            Package () {
+                Package () { "compatible", Package () { "pwm-leds" } },
+                Package () { "label", "alarm-led" },
+                Package () { "pwms",
+                    Package () {
+                        "\\_SB.PCI0.PWM",  // <PWM device reference>
+                        0,                 // <PWM index>
+                        600000000,         // <PWM period>
+                        0,                 // <PWM flags>
+                    }
+                }
+            }
+
+        })
+        ...
+
+In the above example the PWM-based LED driver references to the PWM channel 0
+of \_SB.PCI0.PWM device with initial period setting equal to 600 ms (note that
+value is given in nanoseconds).
+
 GPIO support
 ============
 
-- 
2.30.2

