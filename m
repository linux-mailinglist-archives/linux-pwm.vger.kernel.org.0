Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B59C25DD77
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Sep 2020 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgIDPZ6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 11:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbgIDPZB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 4 Sep 2020 11:25:01 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942D02074D;
        Fri,  4 Sep 2020 15:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233100;
        bh=Pq6AMCutClAdC1MVlFH4CnQL+gGmRAYhCy6R3i2GV1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjis33CzlE4L8H5Hnvz2sDPU+++Cix7kCoiPDA0FaQM0iuGrWZ141pW18vBqPfqaT
         Umi3jXeYOqFfHssMDCjdXC2mY1bme+uWigxNZiQQXnN/iI1NQK5KMKoaigEUqADwJK
         6PFcpRACCzgdaObvVFzjEiaKq6yu/d9JATDLwVWQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 09/14] dt-bindings: mfd: rohm,bd71847-pmic: Correct clock properties requirements
Date:   Fri,  4 Sep 2020 17:23:59 +0200
Message-Id: <20200904152404.20636-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904152404.20636-1-krzk@kernel.org>
References: <20200904152404.20636-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The input clock and number of clock provider cells are not required for
the PMIC to operate.  They are needed only for the optional bd718x7
clock driver.

Add also clock-output-names as driver takes use of it.

This fixes dtbs_check warnings like:

    arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: pmic@4b: 'clocks' is a required property
    arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: pmic@4b: '#clock-cells' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/mfd/rohm,bd71847-pmic.yaml       | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
index 77bcca2d414f..5d531051a153 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
@@ -38,6 +38,9 @@ properties:
   "#clock-cells":
     const: 0
 
+  clock-output-names:
+    maxItems: 1
+
 # The BD71847 abd BD71850 support two different HW states as reset target
 # states. States are called as SNVS and READY. At READY state all the PMIC
 # power outputs go down and OTP is reload. At the SNVS state all other logic
@@ -116,12 +119,14 @@ required:
   - compatible
   - reg
   - interrupts
-  - clocks
-  - "#clock-cells"
   - regulators
 
 additionalProperties: false
 
+dependencies:
+  '#clock-cells': [clocks]
+  clocks: ['#clock-cells']
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.17.1

