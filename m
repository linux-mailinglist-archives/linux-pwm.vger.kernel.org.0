Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1310A378ED7
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 15:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhEJNcE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbhEJM01 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 08:26:27 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC27BC061344
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 05:18:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:f937:4595:45ff:bcbf])
        by andre.telenet-ops.be with bizsmtp
        id 30Jd2500Z4jQ7kl010JeH3; Mon, 10 May 2021 14:18:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lg4rt-004QlD-Du; Mon, 10 May 2021 14:18:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lg4rs-00HQPm-VX; Mon, 10 May 2021 14:18:36 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] dt-bindings: pwm: renesas,tpu-pwm: Improve json-schema
Date:   Mon, 10 May 2021 14:18:34 +0200
Message-Id: <d36e3690ce8c5a1e53d054552e4fd8b90d6a5478.1620648868.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620648868.git.geert+renesas@glider.be>
References: <cover.1620648868.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

  - Include the general PWM controller schema,
  - Make clocks, power-domains, and resets properties required.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Keep additionalProperties, as pwm.yaml doesn't add any other
    properties.
---
 .../bindings/pwm/renesas,tpu-pwm.yaml           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index aa9a4570c9068226..7c99e42ad780c2cd 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -58,6 +58,23 @@ required:
   - compatible
   - reg
   - '#pwm-cells'
+  - clocks
+  - power-domains
+
+allOf:
+  - $ref: pwm.yaml#
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,tpu-r8a73a4
+                - renesas,tpu-r8a7740
+    then:
+      required:
+        - resets
 
 additionalProperties: false
 
-- 
2.25.1

