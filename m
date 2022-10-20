Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F34606403
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Oct 2022 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJTPQT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Oct 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJTPQS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2022 11:16:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E656141395
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2022 08:16:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bv10so34994738wrb.4
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2022 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQtmC5CT1BYx1wr4cDsdhyqbJnf1PNOi9nZ8obHDjYY=;
        b=VTFyI5VGtitN13E0qI7ebcaThIJga5Br0H4ijGb0xvRwlE43XkXzmyOFzR6AeRDpr5
         tgsjsHN0yanBjF+ekH+AuvtBxMJiNt5lIqdBNmHf1jVRQhz0xwsf7dkB6/FkTKbpJkO1
         ZIh5x3HGaitiP7NdmOfx1bd/xZR3NAn1zEEGjFFHU8YxTWOQFdLJmsmdhGyDgJY8ldpr
         6faAhg5m4VYdSMRWgc82RtgQw49wsBzkuPy6o6H5Gh8IawzXqtMUhbthPyie97NbM7qF
         WU9sLEu3GJQo6c9KNrc7tHwy1fo7kkP2YBmoP3H/6/5rYKwob/ImkOElN39qdz6PWDaT
         xyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQtmC5CT1BYx1wr4cDsdhyqbJnf1PNOi9nZ8obHDjYY=;
        b=JThwAZfXp+MOSGQihDD4FtVdStCODsaqX7PlWIUdxsJd0dQiqSIEMHD6AgT6R3A2SB
         HmwqpjJCh9v5jbuiHEqS5DLl/UXHsnKVMqCYuicBVg0dMLaqBTb4L1vNZvXCIF8w73Zj
         ArzZ5tSPWFCLyjGlRLubTNAaxb8vAOAYoFBVafNIRUI3IUm2GPeDW2Jt31eTDI8HEnJ8
         SI4TTAB5AjVTOEsCGZFdUnMePqj24Ue74mQ8cySzhbsipLJohUWjMxJeu/4DZopzzSu0
         zYflcECtL4xuaRX3DzrXp0VWKD8buNe1t7NiMdW8Eo759lAvI0j0H4C520DmLFMUHecT
         Nx6A==
X-Gm-Message-State: ACrzQf1E/lnuMjAU8SsbJSEN7mINVWAduuuX1rPZD9FTpb6KUwJxIjd2
        1O/IOHi+/JlFkB+3Eh8qxFj8IsMQkn7PPlSeA+xFGq64e7FcEzA4qpstQsmgd1jmW3uF2vrWwhZ
        k5mhYQtTKvbYo47VmCJLu0YOGH9BZt1de9eW4P1lzqsXib54kwMm0esrjs5AYBneaJSfhEQFqUC
        4=
X-Google-Smtp-Source: AMsMyM4b4mug2ufxEEqjlM/508NrROih3W/qYIT3N70EY7VYNDFhgOZHjQnriqgWLqeJoDcQvR60cA==
X-Received: by 2002:adf:f00b:0:b0:22e:3439:cff2 with SMTP id j11-20020adff00b000000b0022e3439cff2mr9443422wro.719.1666278974810;
        Thu, 20 Oct 2022 08:16:14 -0700 (PDT)
Received: from rainbowdash.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003c6f3e5ba42sm41362wmb.46.2022.10.20.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:16:13 -0700 (PDT)
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
Subject: [PATCH v6 01/10] dt-bindings: pwm: Document Synopsys DesignWare snps,pwm-dw-apb-timers-pwm2
Date:   Thu, 20 Oct 2022 16:16:01 +0100
Message-Id: <20221020151610.59443-2-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020151610.59443-1-ben.dooks@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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

