Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A802CFF65
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 22:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgLEVxz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Dec 2020 16:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLEVxy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 16:53:54 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2734C0613CF
        for <linux-pwm@vger.kernel.org>; Sat,  5 Dec 2020 13:53:13 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u9so7110863lfm.1
        for <linux-pwm@vger.kernel.org>; Sat, 05 Dec 2020 13:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QF69uECAamzOWlaEn481WwcLAj1MiwOW4Kz1BWJF03c=;
        b=sk+uNyFpdF8kFEyAikqH4AiCJGjXpLNtWAl9qFtzzlEztUc08zLWQZCjWj69QqimhS
         seXY4BOhWswrOvthyWUsxiB4VVub+N+xDJ/Qw6f6QIqwblwcF92I0bgLOwFNaP7PiWb1
         0ym0p7Ckg4hdc9CRXoDIP2NsVuqorZYcWU9fnW8HA6cBWdridf3jBqUGewZkg5XJO8Ck
         nbswraXgNc0Igx0gr2Ky92QMGKHFEAISjFF5ausWQcE5Q8ZpX0BLG2Mk+abyLMY7qAgX
         juIkjwK2CozSX1o1lg6qkqEdxvCfJMeJSl+xN9sFksOOeBgSose70zh9rX1kTaFnMey9
         xImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QF69uECAamzOWlaEn481WwcLAj1MiwOW4Kz1BWJF03c=;
        b=aQDZ68ZkJtxoskChvETIuxgYGo1fHPlReKCS6U8LVcV5aB2vCLB66KsXWo2iiPIF0J
         jV6WVqApR5idQj+szORcO9yUcBeWy2ky+vd6/EDqBAuyOR31VykLV7lxlnC8gz/G3nEa
         Ftyfk0E4DYA8FBmaQ9P3BeyeW44xQebmeAf7idO0PbHbunYnhflKaYwSP1VPeFqn3g3l
         xsIifSccWsHv0Puxzg0OA5hE1hjGGDZx6WSk4zbWydueZwa3MYBRNjqkzch7apFOKjxM
         rNMrYxfI4aiYHT1lKVq7zAfLg9Cb/XRrgMCEbdEhK6OuuaullAMvD4To0xM8ce7VTmmY
         ZtAg==
X-Gm-Message-State: AOAM532fg3Vp7vnBB6Oq8hrt6Wogs7IOvFpQuqH6RepQd/wmfS9eDlrE
        vONfh1uY/0zIPR8OCf2AnIOg75LvyM0yjQ==
X-Google-Smtp-Source: ABdhPJyrJA35HZahJpUIotKL61vnffBX2y/xEMuxzmvxKf4Zx/nDUO63CEjsLV45O2xmHK/la92/rg==
X-Received: by 2002:a19:8207:: with SMTP id e7mr5693520lfd.372.1607205192256;
        Sat, 05 Dec 2020 13:53:12 -0800 (PST)
Received: from einstein.dilieto.eu (einstein.dilieto.eu. [188.68.43.228])
        by smtp.gmail.com with ESMTPSA id u4sm2530851lju.47.2020.12.05.13.53.11
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Dec 2020 13:53:11 -0800 (PST)
Date:   Sat, 5 Dec 2020 22:53:08 +0100
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     linux-pwm@vger.kernel.org
Subject: [PATCH 2/2] pwm: pwm-gpio: Add DT bindings
Message-ID: <20201205215308.aczsyoclhi4qfhbw@einstein.dilieto.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Added Documentation/devicetree/bindings/pwm/pwm-gpio.yaml

Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-gpio.yaml          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
new file mode 100644
index 000000000000..2e021ac6ff4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic software PWM for modulating GPIOs
+
+maintainers:
+  - Nicola Di Lieto <nicola.dilieto@gmail.com>
+
+properties:
+  "#pwm-cells":
+    description: |
+      It must be 2. See pwm.yaml in this directory for a
+      description of the cells format.
+    const: 2
+
+  compatible:
+    const: pwm-gpio
+
+  gpios:
+    description:
+      GPIO to be modulated
+    maxItems: 1
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    pwm0 {
+        #pwm-cells = <2>;
+        compatible = "pwm-gpio";
+        gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.11.0

