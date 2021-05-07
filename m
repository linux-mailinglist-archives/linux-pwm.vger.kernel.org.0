Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F583761E0
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhEGI02 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 04:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbhEGI0Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 May 2021 04:26:24 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3E1C061342
        for <linux-pwm@vger.kernel.org>; Fri,  7 May 2021 01:25:23 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:f434:20f9:aa9e:b80c])
        by xavier.telenet-ops.be with bizsmtp
        id 1kRG250080ZPnBx01kRGAE; Fri, 07 May 2021 10:25:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1levnP-003VSy-G3; Fri, 07 May 2021 10:25:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1levnP-006WUo-1f; Fri, 07 May 2021 10:25:15 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] dt-bindings: pwm: renesas,tpu-pwm: Improve json-schema
Date:   Fri,  7 May 2021 10:25:12 +0200
Message-Id: <82dcf4b87f2b2149bb2e238c7fd654ca2397230e.1620375445.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620375445.git.geert+renesas@glider.be>
References: <cover.1620375445.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

  - Include the general PWM controller schema,
  - Make clocks, power-domains, and resets properties required.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/pwm/renesas,tpu-pwm.yaml         | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index aa9a4570c9068226..3a072ee29815c695 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -58,8 +58,25 @@ required:
   - compatible
   - reg
   - '#pwm-cells'
+  - clocks
+  - power-domains
 
-additionalProperties: false
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
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.25.1

