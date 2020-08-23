Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C2D24EE63
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Aug 2020 18:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHWQRj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Aug 2020 12:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgHWQRV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 23 Aug 2020 12:17:21 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79BBE2072D;
        Sun, 23 Aug 2020 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598199440;
        bh=CnRSnps+AJEG/CNxkZZ3JT+RUcAXLf0eIGA4Cov4d+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auHjhuwkCd7pI2CH8VXG0d4rXiAOTn7549CnoGcR0isa3OD6lmhUbuPzOQeSVZ2Ih
         qVsrJdktxrWBmkpSbH+5Sl4u13xqmc1p6yFv6zxyhnjr+kO/H8kNuaJDzjtVUDoAr3
         09SCTA+NPhmxWpLwgijMlDyTnp+5VG7+YvKvAKes=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 18/22] arm64: dts: imx8mq-zii-ultra: Add hog suffixes to GPIO hogs
Date:   Sun, 23 Aug 2020 18:15:46 +0200
Message-Id: <20200823161550.3981-18-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
References: <20200823161550.3981-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

According to device tree specification, device node names should be
somewhat generic and reflecting the function of the device so add the
"hog" suffixes to all GPIO hog nodes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 0d1088dcaa02..fa7a041ffcfd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -229,28 +229,28 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
-	usb-emulation {
+	usb-emulation-hog {
 		gpio-hog;
 		gpios = <10 GPIO_ACTIVE_HIGH>;
 		output-low;
 		line-name = "usb-emulation";
 	};
 
-	usb-mode1 {
+	usb-mode1-hog {
 		gpio-hog;
 		gpios = <11 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "usb-mode1";
 	};
 
-	usb-pwr {
+	usb-pwr-hog {
 		gpio-hog;
 		gpios = <12 GPIO_ACTIVE_LOW>;
 		output-high;
 		line-name = "usb-pwr-ctrl-en-n";
 	};
 
-	usb-mode2 {
+	usb-mode2-hog {
 		gpio-hog;
 		gpios = <13 GPIO_ACTIVE_HIGH>;
 		output-high;
-- 
2.17.1

