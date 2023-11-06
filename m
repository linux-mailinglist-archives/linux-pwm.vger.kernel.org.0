Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA41F7E1D7A
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Nov 2023 10:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjKFJwM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Nov 2023 04:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFJwM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Nov 2023 04:52:12 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC291F1;
        Mon,  6 Nov 2023 01:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1699264329; x=1730800329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jd6MUcWKRJ1RmTUfwIIEw+3tKFwk7+0cW8fgrk+BS8c=;
  b=kEHMFNAz2vPiW5P2BOLKH1/bhkYuwuatBRwgIBZQYCo+5B75VpxGn/Hk
   ispph5H2OA/MKxixsmIRTWBdONOZt1FVfHwg7RGDTG5Tw3zs7j7Q3QICh
   AMQ4UbEfejrkFKE2oqi4no14utVkUQ1E/vmB+kO6njsE1WoE3x6EMxR3T
   kc0LbQhrIsRVeY1TFviTOR/UOXN7UKs0azv+ZChwyQTmJ70qdOrDgmRex
   2+AGk1bF+vgPUZs+P9PO4L4aGK5/dl3rdyppJGMXL2sejDn9Nvzx9HWuc
   X3ySm2xYhWAt+x1V01V6DT2AVo/SGpOQsL6F4qcufGIquw/WZYj4uRSJV
   Q==;
X-IronPort-AV: E=Sophos;i="6.03,281,1694728800"; 
   d="scan'208";a="33823100"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Nov 2023 10:52:05 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 34F5F280084;
        Mon,  6 Nov 2023 10:52:05 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: pwm: imx-pwm: Add constraints for #pwm-cells
Date:   Mon,  6 Nov 2023 10:52:03 +0100
Message-Id: <20231106095205.231210-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106095205.231210-1-alexander.stein@ew.tq-group.com>
References: <20231106095205.231210-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Only fsl,imx1-pwm comptabile devices use #pwm-cells = <2>. Newer SoCs
supportinverted PWM output, thus #pwm-cells needs to be set to 3.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../devicetree/bindings/pwm/imx-pwm.yaml      | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index c01dff3b7f843..59a981c0f39ab 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -9,9 +9,6 @@ title: Freescale i.MX PWM controller
 maintainers:
   - Philipp Zabel <p.zabel@pengutronix.de>
 
-allOf:
-  - $ref: pwm.yaml#
-
 properties:
   "#pwm-cells":
     description: |
@@ -74,6 +71,23 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx1-pwm
+    then:
+      properties:
+        "#pwm-cells":
+          enum: [2]
+    else:
+      properties:
+        "#pwm-cells":
+          enum: [3]
+
 examples:
   - |
     #include <dt-bindings/clock/imx5-clock.h>
-- 
2.34.1

