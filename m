Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C1B58AE62
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Aug 2022 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbiHEQut (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Aug 2022 12:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiHEQur (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Aug 2022 12:50:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0826F1C129
        for <linux-pwm@vger.kernel.org>; Fri,  5 Aug 2022 09:50:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso4240991wme.0
        for <linux-pwm@vger.kernel.org>; Fri, 05 Aug 2022 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9JYdpth5RmfS3EJypo1rTclGHef1NaLLFmN2AxjOh40=;
        b=lHYMIHAF31vYCzNvEQ97uO10D2+YE23yHf+ECBSCU17szTlwH1Hkvz0vwYZKFZnkOF
         +4BFhC8tSMH+Lt42TJh1yUXKzj+XqUP6tbZ6rqzuxqLTOlP1LE8XQg29icJ2gzRGD9iq
         Ll7ZCVeNf1liG0SLhLq3svWLHbIuxDW11jHwwuqHlb3AKtpR59mKeYyCa7HVzuhjyEiJ
         FPJ/9pq3B2tM6IVu2Mr7+JvH9+DHIrmyXdrGmfIZmJrUpj36CbQajB4o6hlxIUsy2FoW
         74HBtRQeyZH/3D5AnaY7a3vhrbXVpkXB9mX9PoE0zVllx+oCz8rv0a9kGGNmEPNdH364
         TBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9JYdpth5RmfS3EJypo1rTclGHef1NaLLFmN2AxjOh40=;
        b=2fa1KmVbvMCR1f2iP9cn2UJ2cnxVsmHC2ipUHVR+sbm5VVlPgWD0MjBdOtsRSmCmPr
         9OcB5S53bamLaheNQMvkIDHpe5tt9ADiwad0ce/OCaJ0N3nuxUpy8HafeaS039FzGgRQ
         Vji1wc3j583D5ZfLwmpRj5s0tm95DKWE5JrW79DWYqqEeHPdfX9eGAhty4PcycOXPBmS
         kQc+3r6QpMEc9T4SSbKC7dDwJ6KEg2HT+U0XSTc04OtEG14NqrqnvtB4qddjhCZ+k0Ye
         H8RpG5PA3uFbNQV2r4tWnAoWZIRPktgd/PvvSoaDo9esH2viBHyKYaZFJLkfGLLLnyo6
         9ekQ==
X-Gm-Message-State: ACgBeo2za+EMqYJdGlkyIktO7cYEhm5hi+apmQkXxa/rOy98y/zsyHpm
        A4X1SSDAAiyVXy8ylr5PEHDs0QIDnv+Cut1X
X-Google-Smtp-Source: AA6agR4Mi0UPWTL1T47WzzTxVOC58jhj7r9VoEL7DRotfy/iJGjyA/sHbaZ+DJT6H/TU7vAhG9O3Xw==
X-Received: by 2002:a05:600c:22c1:b0:3a3:170a:7ae1 with SMTP id 1-20020a05600c22c100b003a3170a7ae1mr10077337wmg.192.1659718244364;
        Fri, 05 Aug 2022 09:50:44 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:44 -0700 (PDT)
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
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 1/8] dt-bindings: pwm: Document Synopsys DesignWare snps,pwm-dw-apb-timers-pwm2
Date:   Fri,  5 Aug 2022 17:50:26 +0100
Message-Id: <20220805165033.140958-2-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805165033.140958-1-ben.dooks@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
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
v3:
 - add description and example
 - merge the snps,pwm-number into this patch
 - rename snps,pwm to snps,dw-apb-timers-pwm2
v2:
 - fix #pwm-cells to be 3
 - fix indentation and ordering issues
---
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml

diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
new file mode 100644
index 000000000000..a81f2c2e485c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/snps,dw-apb-tiners-pwm2.yaml#
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

