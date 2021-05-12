Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A75D37CFC2
	for <lists+linux-pwm@lfdr.de>; Wed, 12 May 2021 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhELRRy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 13:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbhELQa3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 12:30:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A074DC08EACF;
        Wed, 12 May 2021 09:03:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id p20so6276044ljj.8;
        Wed, 12 May 2021 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5a3LpSMEA2FyBM0XUI5BkccXTFTL84Xmwv8wTBlzfM=;
        b=mr/g/PwBPVeExTjtiZC+qX8HbljZsXXFQpRTFHmFENuSx7iLcL4ulhU2K2nbToesaV
         FM436fFeJbW6OP1Agi7rENm91cnFQiSmN4hE79wgZoFRoxh7frZ6SMcuxC5SNqjT677x
         jFIzMQSNGijLC5wO0W7OIfXicS5i9JY/VEuX5RttgbEmXB++EqsZdkTGfI2VsaSCoE9t
         2EGlDt6nzTTID3RjVW+eC206NKN75z0N/Y+EFJhtDQgikkfXr+JWvNo6LzLN9g0KVyk9
         aUQeJ326qMk1vWFBAKIqA41fjJcYancb3l/UX9Dy1UJiwAYwIjZQQvOQwHoLBODmyVna
         +Pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m5a3LpSMEA2FyBM0XUI5BkccXTFTL84Xmwv8wTBlzfM=;
        b=HbnnxRX3NLF4kni8BJbPGn4Ml1OBaVevFJw93uQLrATI8sZe8gZtu4QUQaKdKaOurK
         kH34b2Y+EE7wXckgNpAY7l1MDgrnx5ceEkDx+SpwAkSCxRjGhy7s2sWSJeFG2gZ5Pi+m
         v4IXp/G52uVp9sNAZQss37gP/Fq1rJBg4vhbqdTKNFKjyT9CbBDyweq94sBPD12HiX/T
         C/8Mqb9h0GMTQR7mWXCF9OTIuPh32ImXnX5Z6owaSrgeBQawEM009EIzYWn1DlW/jKxu
         vDQ1NB1vsDsXdEMmxP5JQtd2SCact3n+AqcHFrSBTTHsH46coEbzLXr6VaZN+he2sCYY
         Je0Q==
X-Gm-Message-State: AOAM530WR+2B0xjsdYn9lbW2BSqYEe3Z1TqQ4GYKfqQZPHVQiq/0EWTa
        BSbIik0E70hSsSd+d7JjJXc=
X-Google-Smtp-Source: ABdhPJwbfi+Iv9VSTgBMtpTqyMbSw1fieIjoLW3VHjdo1A4uK4xe3NoyvdsrwxdLRI3Xj+FV5+L1dQ==
X-Received: by 2002:a2e:9c01:: with SMTP id s1mr29260574lji.402.1620835394404;
        Wed, 12 May 2021 09:03:14 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a6sm32646ljp.76.2021.05.12.09.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 09:03:13 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: pwm: brcm,iproc-pwm: convert to the json-schema
Date:   Wed, 12 May 2021 18:02:53 +0200
Message-Id: <20210512160253.15000-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/pwm/brcm,iproc-pwm.txt           | 21 ---------
 .../bindings/pwm/brcm,iproc-pwm.yaml          | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
deleted file mode 100644
index 655f6cd4ef46..000000000000
--- a/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Broadcom iProc PWM controller device tree bindings
-
-This controller has 4 channels.
-
-Required Properties :
-- compatible: must be "brcm,iproc-pwm"
-- reg: physical base address and length of the controller's registers
-- clocks: phandle + clock specifier pair for the external clock
-- #pwm-cells: Should be 3. See pwm.yaml in this directory for a
-  description of the cells format.
-
-Refer to clocks/clock-bindings.txt for generic clock consumer properties.
-
-Example:
-
-pwm: pwm@18031000 {
-	compatible = "brcm,iproc-pwm";
-	reg = <0x18031000 0x28>;
-	clocks = <&osc>;
-	#pwm-cells = <3>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
new file mode 100644
index 000000000000..218ab06c34d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/brcm,iproc-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom iProc PWM controller
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+description:
+  This controller has 4 channels.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: brcm,iproc-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: external clock
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+unevaluatedProperties: false
+
+required:
+  - reg
+  - clocks
+
+examples:
+  - |
+    pwm@18031000 {
+        compatible = "brcm,iproc-pwm";
+        reg = <0x18031000 0x28>;
+        clocks = <&osc>;
+        #pwm-cells = <3>;
+    };
-- 
2.26.2

