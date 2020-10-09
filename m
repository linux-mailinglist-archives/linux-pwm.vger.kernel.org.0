Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD9C288CAA
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Oct 2020 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389307AbgJIPaw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Oct 2020 11:30:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:34414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389135AbgJIPat (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 9 Oct 2020 11:30:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B52CAAD63;
        Fri,  9 Oct 2020 15:30:47 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        wahrenst@gmx.net,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: pwm: Add binding for RPi firmware PWM bus
Date:   Fri,  9 Oct 2020 17:30:28 +0200
Message-Id: <20201009153031.986-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009153031.986-1-nsaenzjulienne@suse.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM bus controlling the fan in RPi's official PoE hat can only be
controlled by the board's co-processor.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 21 +++++++++++++++++++
 .../pwm/raspberrypi,firmware-pwm.h            | 13 ++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-pwm.h

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index a2c63c8b1d10..dcaf00e8602e 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -64,6 +64,22 @@ properties:
       - compatible
       - "#reset-cells"
 
+  pwm:
+    type: object
+
+    properties:
+      compatible:
+        const: raspberrypi,firmware-pwm
+
+      "#pwm-cells":
+        const: 1
+        description: >
+          The argument is the PWM bus number.
+
+    required:
+      - compatible
+      - "#pwm-cells"
+
     additionalProperties: false
 
 required:
@@ -87,5 +103,10 @@ examples:
             compatible = "raspberrypi,firmware-reset";
             #reset-cells = <1>;
         };
+
+        pwm: pwm {
+            compatible = "raspberrypi,firmware-pwm";
+            #pwm-cells = <1>;
+        };
     };
 ...
diff --git a/include/dt-bindings/pwm/raspberrypi,firmware-pwm.h b/include/dt-bindings/pwm/raspberrypi,firmware-pwm.h
new file mode 100644
index 000000000000..27c5ce68847b
--- /dev/null
+++ b/include/dt-bindings/pwm/raspberrypi,firmware-pwm.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Nicolas Saenz Julienne
+ * Author: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ */
+
+#ifndef _DT_BINDINGS_RASPBERRYPI_FIRMWARE_PWM_H
+#define _DT_BINDINGS_RASPBERRYPI_FIRMWARE_PWM_H
+
+#define RASPBERRYPI_FIRMWARE_PWM_POE		0
+#define RASPBERRYPI_FIRMWARE_PWM_NUM		1
+
+#endif
-- 
2.28.0

