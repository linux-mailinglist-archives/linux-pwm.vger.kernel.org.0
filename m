Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9634B5245
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 14:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354692AbiBNN4n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 08:56:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354666AbiBNN4l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 08:56:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73167B6B;
        Mon, 14 Feb 2022 05:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644846994; x=1676382994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UmflVMW1wi6gLsKsd8h3yAY2Rc3GU+Tr+EkBhqS8x6M=;
  b=ubO3DwnAdNbi3NPn9Gn1Dr+BAPz8gUGbl3dprhMlhxbpcyco4hQIwH6H
   98K6bhm8k1u1tPrK9ORcpg8VrttVjJi06LGhAIWnDkRD9VOf2bPlLkx00
   DvbgBVW9lYK5r7+nxFwepUeGv5ToEl1Vz1CnyngSqnsmtvLvb3p6G0yIV
   DKDy869sdaOXfRuqfNA2YUu1fTwWzj4N7MXKcU5kecT28lCizK0RT0raF
   6nkFzzNItYsDUAUlkqlitcaFiuTz80pjUk6iIfp2O1S1m1P0jM0/V2pRe
   6Zy6iElwdno6HpFD6qVNWEztf2AEjeoB1iYpl2dC1Ky6mtwaeosXQO6h/
   g==;
IronPort-SDR: wsWP+cXMNk//TH2wOX2suvAZexUeW0dvVf3GsXtzSo2q+XGN071f7gJDbYI0T2ehIbJbp31TOA
 PZpcqElnrUxoDUVxxBBaaphZGPlUzHI+/iYfuiuvZib4MaDIhogK+J5AWSEKjH6QBVB/W9fAYz
 bD7xa+hfXun6hk2IcgJf71us3Oktdt3zSrP8PrrS4FjU863DoZ59WEpfr0qtN/5EF/Rv1nL9Rr
 OSpsIcEog28Ln/CzAMwYjUfBBMkh8H7nNeAUxOxnwoGePVdP7eVBL5R/NA70wYOfyY682p7iVl
 tJq0JI60hBko+BcFgLPpaFn0
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="162154139"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2022 06:56:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 14 Feb 2022 06:56:32 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 14 Feb 2022 06:56:27 -0700
From:   <conor.dooley@microchip.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert@linux-m68k.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <lewis.hanly@microchip.com>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <ivan.griffin@microchip.com>,
        <atishp@rivosinc.com>, Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v7 05/11] dt-bindings: pwm: add microchip corepwm binding
Date:   Mon, 14 Feb 2022 13:58:35 +0000
Message-ID: <20220214135840.168236-6-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214135840.168236-1-conor.dooley@microchip.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add device tree bindings for the Microchip fpga fabric based "core" PWM
controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../bindings/pwm/microchip,corepwm.yaml       | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
new file mode 100644
index 000000000000..a7fae1772a81
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/microchip,corepwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip IP corePWM controller bindings
+
+maintainers:
+  - Conor Dooley <conor.dooley@microchip.com>
+
+description: |
+  corePWM is an 16 channel pulse width modulator FPGA IP
+
+  https://www.microsemi.com/existing-parts/parts/152118
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: microchip,corepwm-rtl-v4
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+  microchip,sync-update-mask:
+    description: |
+      Depending on how the IP is instantiated, there are two modes of operation.
+      In synchronous mode, all channels are updated at the beginning of the PWM period,
+      and in asynchronous mode updates happen as the control registers are written.
+      A 16 bit wide "SHADOW_REG_EN" parameter of the IP core controls whether synchronous
+      mode is possible for each channel, and is set by the bitstream programmed to the
+      FPGA. If the IP core is instantiated with SHADOW_REG_ENx=1, both registers that
+      control the duty cycle for channel x have a second "shadow"/buffer reg synthesised.
+      At runtime a bit wide register exposed to APB can be used to toggle on/off
+      synchronised mode for all channels it has been synthesised for.
+      Each bit of "microchip,sync-update-mask" corresponds to a PWM channel & represents
+      whether synchronous mode is possible for the PWM channel.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+  microchip,dac-mode-mask:
+    description: |
+      Optional, per-channel Low Ripple DAC mode is possible on this IP core. It creates
+      a minimum period pulse train whose High/Low average is that of the chosen duty
+      cycle. This "DAC" will have far better bandwidth and ripple performance than the
+      standard PWM algorithm can achieve. A 16 bit DAC_MODE module parameter of the IP
+      core, set at instantiation and by the bitstream programmed to the FPGA, determines
+      whether a given channel operates in regular PWM or DAC mode.
+      Each bit corresponds to a PWM channel & represents whether DAC mode is enabled
+      for that channel.
+
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@41000000 {
+      compatible = "microchip,corepwm-rtl-v4";
+      microchip,sync-update-mask = /bits/ 32 <0>;
+      clocks = <&clkcfg 30>;
+      reg = <0x41000000 0xF0>;
+      #pwm-cells = <2>;
+    };
-- 
2.35.1

