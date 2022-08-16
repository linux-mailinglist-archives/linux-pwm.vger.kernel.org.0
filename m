Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBBB596450
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Aug 2022 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiHPVPC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 16 Aug 2022 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbiHPVPB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Aug 2022 17:15:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7403E7E328
        for <linux-pwm@vger.kernel.org>; Tue, 16 Aug 2022 14:14:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay12so5830604wmb.1
        for <linux-pwm@vger.kernel.org>; Tue, 16 Aug 2022 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LvSKUVtr5Gp4BgmH/TzQ81b8EX2DhTfAUAFDUiW03kI=;
        b=bRWLm4TI/Y2cCF3vuQE23DoT1UwUjndleUK28KJkWmBRPnO0LnyaE6mhqZxkLqJqaV
         E8IpyM62YSpJlid86sYrQUMi72m7iM4g821qxkCnx3aNmk0b6AX8SvFlyXI4TI6opng9
         fEAIdhShwdMHA0818rzk7NpGSXqW2ru4e+I0Yq4F+w1DsWjH1XacMNVuGYdGuYKV3UlK
         1LK8sYwd8aDHAD1cGExKH23bxORx4AAm9e21Ad9QC3niM413zTIvbz7N1oEP4T+fpPhP
         rG5bEwkTTbiK2XRIolrzxtBc/AGW4kGpPqfjo1DR8+wqWbgOdnNDclPU3Y6/hJ73atI9
         ytpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LvSKUVtr5Gp4BgmH/TzQ81b8EX2DhTfAUAFDUiW03kI=;
        b=BjlaSKkyGDi3VC0xbyigh4cIaVsdxq1HtmPe5HLwXnvPLDFF0KLWTB9m2mbCZKrwA5
         FeC2KHpceVoobETOkFw73WKU5YKpdEWvhFlllWFw6puvRgC6GpyLjXHcqCJ4ZtkuR9Xn
         Jc6/F9XEvEmfOhp1Qrce/rq0rjOEKjv1abni3hO+KJ7sfPO8EA9S8PhMQCgBsp9WAZ1/
         alBd4/pUXrvu6GGmolpKKZRdQvWAEI2JhgzJCBTkTTTAqTjaAD3nUZxFGo2AXP9uk5KV
         uXSbXPpMjDI+foPDKC56/N2vi7Ssoo3GUPu7oCW112qKtpwSdznGQ4djbUcpHe/YHAjU
         jdfQ==
X-Gm-Message-State: ACgBeo0k8wVgYPK6Z2Mupzzqdw4vcfqIc95pnsVyfXsIXUwWYr91qkNO
        Nl3edC06M3m52Fh0JGwrR0GC0iBjGz6dlQ==
X-Google-Smtp-Source: AA6agR7WU2umVyZku64Rq1qUALdsgHptgVygp32cUgOiAnp2l1mktYWFst85Ti0DAjmfA66iEX6z0w==
X-Received: by 2002:a05:600c:206:b0:3a5:41f1:aa23 with SMTP id 6-20020a05600c020600b003a541f1aa23mr215637wmi.31.1660684497606;
        Tue, 16 Aug 2022 14:14:57 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:14:57 -0700 (PDT)
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
        Ben Dooks <ben.dooks@sifive.com>
Subject: [RFC v4 01/10] dt-bindings: pwm: Document Synopsys DesignWare snps,pwm-dw-apb-timers-pwm2
Date:   Tue, 16 Aug 2022 22:14:45 +0100
Message-Id: <20220816211454.237751-2-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add documentation for the bindings for Synopsys' DesignWare PWM block
as we will be adding DT/platform support to the Linux driver soon.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
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
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml

diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
new file mode 100644
index 000000000000..e7feae6d4404
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
@@ -0,0 +1,69 @@
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
+  reg:
+    maxItems: 1
+
+required:
+  - "#pwm-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+
+examples:
+  - |
+    pwm: pwm@180000 {
+      #pwm-cells = <3>;
+      compatible = "snps,dw-apb-timers-pwm2";
+      reg = <0x180000 0x200>;
+      clocks = <&bus &timer>;
+      clock-names = "bus", "timer";
+    };
-- 
2.35.1

