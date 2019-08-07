Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97675853C8
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2019 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbfHGTlJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Aug 2019 15:41:09 -0400
Received: from vern.gendns.com ([98.142.107.122]:43666 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389465AbfHGTlE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Aug 2019 15:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JZcnPzar3TAVprcml8r+efuLQk5t0pInzE4jZWaXCBk=; b=XXGPKLB2Mm4mjXRvx8gH2vX9Q
        VLCywFtIlZubPg6sogAXy7XWrvWth5acPhOUfP8OFXdsBdZ3QTpi7U1OvQKGNcV6og0GnTUPh2/wp
        h7Qhwbqvj89S52YfAKOU2juuCZ4cbwfxuKOqyEDDMLTNQOcoK4DcZhQJBnHHNSbZ9I+lK7iRsAmH6
        Mi/PRO3UMsrkHunn/LEiXC+QMDZV6cDBU6QuLAjlYRKGxWyoQOTvO1ditorowhxBTxyOF4OEh12qr
        tmdnByzhoywqjF3AausbXT6hj3P8u+a7DWcGV3Bx2ojP1vG2zWRahZTMl6Q/qfFJI0lnswHHS6zGP
        JxxaHGGEQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60292 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hvRnx-00006r-V4; Wed, 07 Aug 2019 15:41:02 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v2 2/5] dt-bindings: counter: new bindings for TI eQEP
Date:   Wed,  7 Aug 2019 14:40:20 -0500
Message-Id: <20190807194023.15318-3-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807194023.15318-1-david@lechnology.com>
References: <20190807194023.15318-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This documents device tree binding for the Texas Instruments Enhanced
Quadrature Encoder Pulse (eQEP) Module found in various TI SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes:
- convert to .yaml format
- rename clock to "sysclkout"

 .../devicetree/bindings/counter/ti-eqep.yaml  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/ti-eqep.yaml

diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
new file mode 100644
index 000000000000..8f8b2e87e5c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/ti-eqep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Enhanced Quadrature Encoder Pulse (eQEP) Module
+
+maintainers:
+  - David Lechner <david@lechnology.com>
+
+properties:
+  compatible:
+    const: "ti,am3352-eqep"
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: The eQEP event interrupt
+    maxItems: 1
+
+  clocks:
+    description: The clock that determines the SYSCLKOUT rate for the eQEP
+                 peripheral.
+    maxItems: 1
+
+  clock-names:
+    const: sysclkout
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    eqep0: eqep@180 {
+        compatible = "ti,am3352-eqep";
+        reg = <0x180 0x80>;
+        clocks = <&l4ls_gclk>;
+        clock-names = "sysclkout";
+        interrupts = <79>;
+    };
+
+...
-- 
2.17.1

