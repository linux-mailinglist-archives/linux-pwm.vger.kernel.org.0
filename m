Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9CB2D7C53
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 18:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394108AbgLKRFq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 12:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394304AbgLKRFe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Dec 2020 12:05:34 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783EC061794
        for <linux-pwm@vger.kernel.org>; Fri, 11 Dec 2020 09:04:53 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id m13so11670137ljo.11
        for <linux-pwm@vger.kernel.org>; Fri, 11 Dec 2020 09:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OwHqg57GlDAoclGyeL6iYG8nzqPXgd+yPbAk0eDc4sw=;
        b=jx74jHUu77ODGSMpojWqQGPtILpTYHI+GKHUETXAdaVvZIxJqAFCZ56ebqU4+oCtBk
         9haKORyD3aRpYEqdlisB8MOIjJPjjjtRR47v15iImI1Ls0vPVczrZeIaZsaFsj7aUBqu
         3+w29geyUoRCkOpYtsifpjFS98HsEWp8EbDG8LIjfDLqTQWBMhFR7EAIKsAhxfMMNVTh
         tp1ikcPxT5mTp9sR5zu5P6D703o/4B5dvhIdmZzlcYD3Uhj7S3gkb8y3Ue2lEYSma3HW
         1tZO7J4s3AiZtb4WLklJeiCfdfy6jsNXI0dMZxB6jnfPD1l71COQPp3BvPj9f0tiE6uJ
         MaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OwHqg57GlDAoclGyeL6iYG8nzqPXgd+yPbAk0eDc4sw=;
        b=dnX9pA2nclnlolbMqZngZfS9x3NnfcFsYu9575z7jiiY4ZBCRYxeDLzCrXzMGDVDbL
         /m3MKq86Tuw+mV/3WzHCVxK9nf+7Y8K+VcmbW7pGotJ6fsmhMKqbLb2tMBUQBW7ARwfK
         Hxaw4vgy2Lt/0cmMRkf6cpvjtepzxAqY8TrwDPTW9PkmvD6UEIG28ZUywNX30YV6zc0t
         /vYkuxst32405fRcVpaF6LZcu2gQMKn9FT/q8wOH1HGsFvuesmTaIZLMofeShBIxEss2
         RJ4ajv9Iurec4HysBw+0O4oh8zPEC81W+bVPF3F7/UIusIDk3M+EIo9Y6F+uV9UkataJ
         f0wQ==
X-Gm-Message-State: AOAM5339XsEeM5g77+5mwvnBvUAl6GQPWwuhE57pkfCyBKHCBgxOTNVJ
        PNfAGWyVgRkczPxaJwTOidWmOUJdECQEEhSI4pC3Xw==
X-Google-Smtp-Source: ABdhPJxzyNm+EtYMUzNTfA9kKrj1G5hM26bC6hDHeIWxGLNwlIB6Y3ucYkDODPloVK2zivxcfEaWRA==
X-Received: by 2002:a2e:8548:: with SMTP id u8mr5450698ljj.17.1607706291411;
        Fri, 11 Dec 2020 09:04:51 -0800 (PST)
Received: from einstein.dilieto.eu (einstein.dilieto.eu. [2a03:4000:17:6e2::1000])
        by smtp.gmail.com with ESMTPSA id c4sm944809lfh.94.2020.12.11.09.04.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 09:04:51 -0800 (PST)
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     linux-pwm@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] pwm: pwm-gpio: Add DT bindings
Date:   Fri, 11 Dec 2020 18:04:32 +0100
Message-Id: <20201211170432.6113-3-nicola.dilieto@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201211170432.6113-1-nicola.dilieto@gmail.com>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
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
index 000000000000..e681b2b1c229
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
+      It should be 3. See pwm.yaml in this directory for a
+      description of the cells format.
+    const: 3
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
+        #pwm-cells = <3>;
+        compatible = "pwm-gpio";
+        gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.11.0

