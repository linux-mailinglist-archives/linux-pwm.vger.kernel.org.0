Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EBF46C920
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Dec 2021 01:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbhLHAlu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Dec 2021 19:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243102AbhLHAlg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Dec 2021 19:41:36 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21B7C0617A1;
        Tue,  7 Dec 2021 16:38:05 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id g19so952974pfb.8;
        Tue, 07 Dec 2021 16:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRndETDaFJpAvn07U5V4Tg3zRU+sMtROMsLqLQ972oI=;
        b=AxgFQBlpxUn4B0mBJxB3RsZG3Bk/Q3l+D2NYDqvWP+WIbSkx5M2TJ2ML/ydSc/Yesi
         O87Ui+zpmpPyE5EOqAlWniwySxKvrIWyTEYiQyBA3TxBsjMfWLnIDp4t8uEmt6I7SuXH
         QzgUVtNM+25hc2jFOVKfPXLZXI6WWquroPmuUhSj2y8fnB06Qdh5d1jcFlXVhXyLwKPG
         Zidr9mEdR6S8enrqG+LcC0S4HTCGfr+zM7PGJl6ubfV41h6+8pUTXOQjLzNNw1+AKpnG
         T2MSKRBxb+lIajLebqT9ZgmadOGPe5MMXM1t8+9N4UMRwbop+gGCHptWDh4UzxbFfwP7
         zF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRndETDaFJpAvn07U5V4Tg3zRU+sMtROMsLqLQ972oI=;
        b=QbXgUiU7yQa/4tDoYRIGywiVSRK03MRUjCLV0VbHAxNqT0+xB4TQ4xTt/WRPAWgn09
         9SmH1UIHP/ulEF+3TJkakZw2JREasLrnYkTPLXkAM6lBpvV4d84P6e3AFuilpmMS+AOb
         Szh3E+4Qocj+ErMECNmBlaq4NntndmULTOjHfU/1KL6VdsNO1sHQNyrujFPQzfGsxCU/
         H5eslHc3jzQsEYoHmCdd9P6FLSG/GxK3M+H8tLVdQPtO2jrP/1fGWD4xp0l4jyiMsViK
         R9c5mXZ6evVDbZ8QDrbjQgXwJmcZIY5LTRbDE7jqcteVPyANXke0XbOA7EO73bEtbT+Z
         /w8g==
X-Gm-Message-State: AOAM533+wl5GojxBsENUVu46pHPCMyQIRPkMBbxirUmJHunMlaoKABpx
        oV6BVDl9OlY7JrXTWhOP8hOEI47bCqQ=
X-Google-Smtp-Source: ABdhPJyoCwSxRqyXY8EfioXpQCIoHqdJyEYsq5GNngaPzBvNK9upB3sQ4spTSyQHZDMyRRxVI15yag==
X-Received: by 2002:a63:2a81:: with SMTP id q123mr27278911pgq.510.1638923884875;
        Tue, 07 Dec 2021 16:38:04 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:38:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER
        GENERATOR CORE),
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH v3 09/15] dt-bindings: interrupt-controller: Convert Broadcom STB L2 to YAML
Date:   Tue,  7 Dec 2021 16:37:20 -0800
Message-Id: <20211208003727.3596577-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the Broadcom STB L2 generic Level 2 interrupt controller Device
Tree binding to YAML to help with validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../interrupt-controller/brcm,l2-intc.txt     | 31 --------
 .../interrupt-controller/brcm,l2-intc.yaml    | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
deleted file mode 100644
index 021cf822395c..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Broadcom Generic Level 2 Interrupt Controller
-
-Required properties:
-
-- compatible: should be one of:
-	      "brcm,hif-spi-l2-intc" or
-	      "brcm,upg-aux-aon-l2-intc" or
-	      "brcm,l2-intc" for latched interrupt controllers
-              should be "brcm,bcm7271-l2-intc" for level interrupt controllers
-- reg: specifies the base physical address and size of the registers
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an
-  interrupt source. Should be 1.
-- interrupts: specifies the interrupt line in the interrupt-parent irq space
-  to be used for cascading
-
-Optional properties:
-
-- brcm,irq-can-wake: If present, this means the L2 controller can be used as a
-  wakeup source for system suspend/resume.
-
-Example:
-
-hif_intr2_intc: interrupt-controller@f0441000 {
-	compatible = "brcm,l2-intc";
-	reg = <0xf0441000 0x30>;
-	interrupt-controller;
-	#interrupt-cells = <1>;
-	interrupt-parent = <&intc>;
-	interrupts = <0x0 0x20 0x0>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
new file mode 100644
index 000000000000..c197c85084d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,l2-intc.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Generic Level 2 Interrupt Controller
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,hif-spi-l2-intc
+              - brcm,upg-aux-aon-l2-intc
+          - const: brcm,l2-intc
+      - items:
+          - enum:
+              - brcm,bcm2711-l2-intc
+          - const: brcm,l2-intc
+      - items:
+          - const: brcm,bcm7271-l2-intc
+      - items:
+          - const: brcm,l2-intc
+
+  reg:
+    maxItems: 1
+    description: >
+      Specifies the base physical address and size of the registers
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupts: true
+
+  interrupt-names:
+    maxItems: 1
+
+  brcm,irq-can-wake:
+    type: boolean
+    description: >
+      If present, this means the L2 controller can be used as a wakeup source
+      for system suspend/resume.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+examples:
+  - |
+    hif_intr2_intc: interrupt-controller@f0441000 {
+      compatible = "brcm,l2-intc";
+      reg = <0xf0441000 0x30>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+      interrupt-parent = <&intc>;
+      interrupts = <0x0 0x20 0x0>;
+    };
-- 
2.25.1

