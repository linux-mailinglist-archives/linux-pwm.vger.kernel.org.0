Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D78D65522C
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Dec 2022 16:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiLWPi2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Dec 2022 10:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiLWPi1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Dec 2022 10:38:27 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F82C37F9B
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a17so4878538wrt.11
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtWGiVmifJ/p5NoM/SB2O4ZTTUxKNKwZjVeO5da62YQ=;
        b=eoViL67CheerY/GJogWInFCx8oEhaNaDJ48UxfpAPT6Yx1Y3wpgYmwCqQY/xro+8Nk
         H9dXTVmTUgsTw2FmT5LZlxfSMFMWIbXtJ4RYhSeeTeo1PP2XjumDJ2sAHQ+I+wY72ZTB
         kOWuDIydGIx04Z0lWdp7/qceGwBiUhEMZlalMIiXHPCKQjvpjB/QmpiVSGGOncGFzvxV
         cimB5EyTLlFkGxKuQiDyQ9TgimBARZj86hcn8gCvF6k/+IXAFtB53QDSYj3sRTbI+Ajt
         ManLmmEbaMQIgpLPmLUrgLhSxuRUakauAa8DMaeKWu65TnEteoditriEs6unm9um9EGN
         kMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtWGiVmifJ/p5NoM/SB2O4ZTTUxKNKwZjVeO5da62YQ=;
        b=uTPwA+zcV/4s4K5M3DbbSVKKFB+uaDCDuaFpcirfGaS42atGzK/XxqdGMFeIQWVGev
         AC78L43v6LiDg8M2/c/Eg/PtpqG0heFUW9ZXnz9euIKODORQ1hiZ9SSzurevhz6XoUCX
         AWR+XPTy9VntgNtUywlP7r9yIcgNPhtSg0eDzuKt+lZmoOoaju8m9s1r8+/ibm+decFK
         NugsjPgved0v8TeVTjGAhRMYY+6Ok5PqQN45QjrRvEq89D83hdzWGU7jl2ksPGYBuoZh
         LeLjpFH4kCDGK5HbDh8u9H4V4n2GyRjYI9x0CSm6QZ2v/hu3hYWKkSDl7lfl7/HzYG8j
         upVQ==
X-Gm-Message-State: AFqh2kroax+LIthrPtaFsMTGl0s3VdV+jiKnf0c8V2vedmQHCWhjF+Wo
        h730VPyBjg9oVYbV/DPM8fXvg8BJXmB/cpgwv0m8z9qzO588BkBrrGZu09p8tP1Zn2E6vkAGDXj
        DVL+3nQxEXE9QwcBFAHCYQbQK8yH4/KO1kJeHjycuENqE08h67c7txJqfBgEOxPeXWhsIaTMolO
        v66w==
X-Google-Smtp-Source: AMrXdXsvyUizrp/5r9cTIoO918Nf7mGbUC58pP5NYbsh3QY2qzUAyosHyR6+vtJwjBjRFlLuAnqMCQ==
X-Received: by 2002:adf:eb08:0:b0:242:e73:f636 with SMTP id s8-20020adfeb08000000b002420e73f636mr7834154wrn.4.1671809904392;
        Fri, 23 Dec 2022 07:38:24 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:38:24 -0800 (PST)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 01/10] dt-bindings: pwm: Document Synopsys DesignWare snps,pwm-dw-apb-timers-pwm2
Date:   Fri, 23 Dec 2022 15:38:11 +0000
Message-Id: <20221223153820.404565-2-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223153820.404565-1-ben.dooks@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add documentation for the bindings for Synopsys' DesignWare PWM block
as we will be adding DT/platform support to the Linux driver soon.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
v5:
 - fixed order of properties
 - corrected clock to two items
v4:
 - fixed typos, added reg
v3:
 - add description and example
 - merge the snps,pwm-number into this patch
 - rename snps,pwm to snps,dw-apb-timers-pwm2
v2:
 - fix #pwm-cells to be 3
 - fix indentation and ordering issues
---
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml

diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
new file mode 100644
index 000000000000..9aabdb373afa
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/snps,dw-apb-timers-pwm2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DW-APB timers PWM controller
+
+maintainers:
+  - Ben Dooks <ben.dooks@sifive.com>
+
+description:
+  This describes the DesignWare APB timers module when used in the PWM
+  mode. The IP core can be generated with various options which can
+  control the functionality, the number of PWMs available and other
+  internal controls the designer requires.
+
+  The IP block has a version register so this can be used for detection
+  instead of having to encode the IP version number in the device tree
+  comaptible.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: snps,dw-apb-timers-pwm2
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  clocks:
+    items:
+      - description: Interface bus clock
+      - description: PWM reference clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: timer
+
+  snps,pwm-number:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of PWM channels configured for this instance
+    enum: [1, 2, 3, 4, 5, 6, 7, 8]
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm: pwm@180000 {
+      compatible = "snps,dw-apb-timers-pwm2";
+      reg = <0x180000 0x200>;
+      #pwm-cells = <3>;
+      clocks = <&bus>, <&timer>;
+      clock-names = "bus", "timer";
+    };
-- 
2.35.1

