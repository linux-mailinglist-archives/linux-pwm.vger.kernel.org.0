Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD1C2A621F
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Nov 2020 11:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgKDKkC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 05:40:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:58730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729785AbgKDKkA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Nov 2020 05:40:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0319ACE5;
        Wed,  4 Nov 2020 10:39:58 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com, Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 09/11] dt-bindings: pwm: Add binding for RPi firmware PWM bus
Date:   Wed,  4 Nov 2020 11:39:35 +0100
Message-Id: <20201104103938.1286-10-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104103938.1286-1-nsaenzjulienne@suse.de>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM bus controlling the fan in RPi's official PoE hat can only be
controlled by the board's co-processor.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
 - Update bindings to use 2 #pwm-cells

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 20 +++++++++++++++++++
 .../pwm/raspberrypi,firmware-pwm.h            | 13 ++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-pwm.h

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index a2c63c8b1d10..8029ce958c48 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -64,6 +64,21 @@ properties:
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
+        # See pwm.yaml in this directory for a description of the cells format.
+        const: 2
+
+    required:
+      - compatible
+      - "#pwm-cells"
+
     additionalProperties: false
 
 required:
@@ -87,5 +102,10 @@ examples:
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
2.29.1

