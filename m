Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C747D117888
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2019 22:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLIVci (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Dec 2019 16:32:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50353 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIVci (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Dec 2019 16:32:38 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ieQdw-0004TR-Lv; Mon, 09 Dec 2019 22:32:36 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ieQdv-0004JL-SA; Mon, 09 Dec 2019 22:32:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] docs: pwm split out pwm-sysfs description from the generic pwm documentation
Date:   Mon,  9 Dec 2019 22:32:32 +0100
Message-Id: <20191209213233.29574-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The two are related but still disjoint enough to justify two documents.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/index.rst     |  1 +
 Documentation/driver-api/pwm-sysfs.rst | 44 +++++++++++++++++++++++++
 Documentation/driver-api/pwm.rst       | 45 --------------------------
 3 files changed, 45 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/driver-api/pwm-sysfs.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 0ebe205efd0c..3e0230df2d64 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -91,6 +91,7 @@ available subsections can be seen below.
    phy/index
    pti_intel_mid
    pwm
+   pwm-sysfs
    rfkill
    serial/index
    sm501
diff --git a/Documentation/driver-api/pwm-sysfs.rst b/Documentation/driver-api/pwm-sysfs.rst
new file mode 100644
index 000000000000..e7da67940648
--- /dev/null
+++ b/Documentation/driver-api/pwm-sysfs.rst
@@ -0,0 +1,44 @@
+Using PWMs with the sysfs interface
+-----------------------------------
+
+If CONFIG_SYSFS is enabled in your kernel configuration a simple sysfs
+interface is provided to use the PWMs from userspace. It is exposed at
+/sys/class/pwm/. Each probed PWM controller/chip will be exported as
+pwmchipN, where N is the base of the PWM chip. Inside the directory you
+will find:
+
+  npwm
+    The number of PWM channels this chip supports (read-only).
+
+  export
+    Exports a PWM channel for use with sysfs (write-only).
+
+  unexport
+   Unexports a PWM channel from sysfs (write-only).
+
+The PWM channels are numbered using a per-chip index from 0 to npwm-1.
+
+When a PWM channel is exported a pwmX directory will be created in the
+pwmchipN directory it is associated with, where X is the number of the
+channel that was exported. The following properties will then be available:
+
+  period
+    The total period of the PWM signal (read/write).
+    Value is in nanoseconds and is the sum of the active and inactive
+    time of the PWM.
+
+  duty_cycle
+    The active time of the PWM signal (read/write).
+    Value is in nanoseconds and must be less than the period.
+
+  polarity
+    Changes the polarity of the PWM signal (read/write).
+    Writes to this property only work if the PWM chip supports changing
+    the polarity. The polarity can only be changed if the PWM is not
+    enabled. Value is the string "normal" or "inversed".
+
+  enable
+    Enable/disable the PWM signal (read/write).
+
+	- 0 - disabled
+	- 1 - enabled
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index ab62f1bb0366..8f31bcdbb631 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -69,51 +69,6 @@ All consumers should really be reconfiguring the PWM upon resume as
 appropriate. This is the only way to ensure that everything is resumed in
 the proper order.
 
-Using PWMs with the sysfs interface
------------------------------------
-
-If CONFIG_SYSFS is enabled in your kernel configuration a simple sysfs
-interface is provided to use the PWMs from userspace. It is exposed at
-/sys/class/pwm/. Each probed PWM controller/chip will be exported as
-pwmchipN, where N is the base of the PWM chip. Inside the directory you
-will find:
-
-  npwm
-    The number of PWM channels this chip supports (read-only).
-
-  export
-    Exports a PWM channel for use with sysfs (write-only).
-
-  unexport
-   Unexports a PWM channel from sysfs (write-only).
-
-The PWM channels are numbered using a per-chip index from 0 to npwm-1.
-
-When a PWM channel is exported a pwmX directory will be created in the
-pwmchipN directory it is associated with, where X is the number of the
-channel that was exported. The following properties will then be available:
-
-  period
-    The total period of the PWM signal (read/write).
-    Value is in nanoseconds and is the sum of the active and inactive
-    time of the PWM.
-
-  duty_cycle
-    The active time of the PWM signal (read/write).
-    Value is in nanoseconds and must be less than the period.
-
-  polarity
-    Changes the polarity of the PWM signal (read/write).
-    Writes to this property only work if the PWM chip supports changing
-    the polarity. The polarity can only be changed if the PWM is not
-    enabled. Value is the string "normal" or "inversed".
-
-  enable
-    Enable/disable the PWM signal (read/write).
-
-	- 0 - disabled
-	- 1 - enabled
-
 Implementing a PWM driver
 -------------------------
 
-- 
2.24.0

