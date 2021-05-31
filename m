Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6813139644B
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhEaPxv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 11:53:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:52281 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232093AbhEaPvc (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 11:51:32 -0400
IronPort-SDR: p26e1Z5f3/ELd9EJxyt+5dYTsqAU3hJoIMs0g3iVMR5h2WYyN34l8N/2ky3TBE1WrQz6gSG+Ls
 NreJ9VpaeGQA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="224646671"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="224646671"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 08:43:45 -0700
IronPort-SDR: bUacGGLAouai1owasPOOdITRHZvnpmAWCdt0EG9QdG3Pxa5gRgBAyu2awMYUX+yPHWJZhg5l8x
 v35RkekfrXYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="632598639"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 31 May 2021 08:43:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1D45AC5; Mon, 31 May 2021 18:44:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 1/5] docs: firmware-guide: ACPI: Add a PWM example
Date:   Mon, 31 May 2021 18:43:47 +0300
Message-Id: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
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
 .../firmware-guide/acpi/enumeration.rst       | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 9f0d5c854fa4..0813508b45b0 100644
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
+                        600000,            // <PWM period>
+                        0,                 // <PWM flags>
+                    }
+                }
+            }
+
+        })
+        ...
+
+In the above example the PWM-based LED driver references to the PWM channel 0
+of \_SB.PCI0.PWM device with initial period setting equal to 600 us (note that
+value is given in nanoseconds).
+
 GPIO support
 ============
 
-- 
2.30.2

