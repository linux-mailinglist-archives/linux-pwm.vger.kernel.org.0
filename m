Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4655B580659
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Jul 2022 23:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbiGYVWJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Jul 2022 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbiGYVWI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Jul 2022 17:22:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F22A1DA56
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jul 2022 14:22:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v5so7624198wmj.0
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jul 2022 14:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHmQZHpGxawao/KUr1/i4POaZ94konia4hXkNONDx+E=;
        b=F9QqMeFjwu9yp0G6OthtTiaWgsDTaInPT1jusgqebeA1i42DdZBHHbgnP/bmbU21UI
         c1q/8HfdyO3tvMeYxa35NtjAU3a+ob49vBVNqrXXKNa8CYt/aM3ZvYxDhFvYLRTYOQ7S
         6+uouSSvnWt4BfBUWO30jtKEouRDkDqmAEKv6ZRB1PzJwd+6S1Y+y/dKt0HjjyD6YxWw
         +VWJ6fJ2PSInuY1J8uW0sz9hJLl8IwLoDdTqFrucLbjjUWBzFnLLgrPpfc1ts8UK/o09
         rub3yUepDoN3n/+U7R9WO1s8DjEMubKtZbOiE7FD2L/vElsNpJGa4GEJgI6YpHqmHRbC
         fUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHmQZHpGxawao/KUr1/i4POaZ94konia4hXkNONDx+E=;
        b=L7ke0wliPKLcgBEIPiAwhsTAcDIpgnCyPVtI6zdv6eQ2KSGRGrYCgary5PgfSkJKof
         ROg0Z/FHiKbhNsrb173G5FlJ68rMg6rXdMRyX8DVtMLoLnFfrossVbHyk4Rg4puUV82C
         7FjOTEGZhe2VmnlA/bwTeMf78HQi0IVnd1slaLypbGKD4KHsC6VIKmM1wNHElKY/SI2W
         wUve66Cn6YAkovEX1QaNXEkFyn6oOdysUCTENFym0/bUwycblIWQlRNhEaMiBCKILOB/
         eA/KdZpG9rERSGqijWVj0Sf+bryVUbeX/Y3mNAhihInoQQ23OQsQCWiB1T/0+VREDVC7
         MPjA==
X-Gm-Message-State: AJIora9KEWGlDTtwJgUshwcC2BCeqnEcFCXCi6+2niR3lAKBTiITlx3a
        0fZq4BuNghOplTAc//MekJ/BtiK4qlj3PA==
X-Google-Smtp-Source: AGRyM1tPzYAZV+4e7woXtPhacFgFJ+VXWN2jfK/7TOtlfqroKnrLVBR3acothJfB5hGOvWG9er+Hrg==
X-Received: by 2002:a05:600c:1d92:b0:3a3:2167:b8e5 with SMTP id p18-20020a05600c1d9200b003a32167b8e5mr22220881wms.24.1658784125739;
        Mon, 25 Jul 2022 14:22:05 -0700 (PDT)
Received: from localhost.localdomain (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600011cd00b0021d6924b777sm12656348wrx.115.2022.07.25.14.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:22:05 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [[PATCH v2] 1/9] dt-bindings: pwm: Document Synopsys DesignWare snps,pwm
Date:   Mon, 25 Jul 2022 22:21:32 +0100
Message-Id: <20220725212140.741644-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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
--
v2:
- fix #pwm-cells to be 3
- fix indentation and ordering issues
---
 .../devicetree/bindings/pwm/snps,pwm.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/snps,pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/snps,pwm.yaml b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
new file mode 100644
index 000000000000..594085e5e26f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/snps,pwm.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/snps,pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys PWM controller
+
+maintainers:
+  - Ben Dooks <ben.dooks@sifive.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: snps,pwm
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
+required:
+  - "#pwm-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
-- 
2.35.1

