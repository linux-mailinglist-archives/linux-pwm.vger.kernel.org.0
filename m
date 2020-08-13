Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F0243A20
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Aug 2020 14:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgHMMtx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Aug 2020 08:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgHMMs6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Aug 2020 08:48:58 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5CDC061385;
        Thu, 13 Aug 2020 05:48:58 -0700 (PDT)
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6C73623E4D;
        Thu, 13 Aug 2020 14:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1597322936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kUSNqf4fbfPjkB54pTr5T1ff03Hc79GXuyMcgsK+vRk=;
        b=PcwPtAe8KEdr8U+7Zc9qyEQGlEk7fZE0VdyXTxFCFg38da+nYo6i2NJ/+ZirAyA0E9vM8a
        LBnF17d491pMYn5CVvKYiP7U04dFrGyRE05wOaWn2/YSktEG275DneWYMCFM3RcfoCtxZI
        6gbkAHZq2IPrQkabnsv/WlJu/GsNDgY=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v8 11/13] arm64: dts: freescale: sl28: enable LED support
Date:   Thu, 13 Aug 2020 14:48:30 +0200
Message-Id: <20200813124832.17349-12-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200813124832.17349-1-michael@walle.cc>
References: <20200813124832.17349-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Now that we have support for GPIO lines of the SMARC connector, enable
LED support on the KBox A-230-LS. There are two LEDs without fixed
functions, one is yellow and one is green. Unfortunately, it is just one
multi-color LED, thus while it is possible to enable both at the same
time it is hard to tell the difference between "yellow only" and "yellow
and green".

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v7:
 - use new "function" and "color" properties instead of a label
 - added default-on trigger for the power-led

Changes since v6:
 - none

Changes since v5:
 - changed the label, suggested by Pavel Machek

Changes since v4:
 - none

Changes since v3:
 - see cover letter

 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
index 4b4cc6a1573d..dd516c0efd8b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
@@ -11,11 +11,29 @@
 
 /dts-v1/;
 #include "fsl-ls1028a-kontron-sl28-var4.dts"
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "Kontron KBox A-230-LS";
 	compatible = "kontron,kbox-a-230-ls", "kontron,sl28-var4",
 		     "kontron,sl28", "fsl,ls1028a";
+
+	leds {
+		compatible = "gpio-leds";
+
+		alarm-led {
+			function = LED_FUNCTION_ALARM;
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&sl28cpld_gpio0 0 0>;
+		};
+
+		power-led {
+			linux,default-trigger = "default-on";
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&sl28cpld_gpio1 3 0>;
+		};
+	};
 };
 
 &enetc_mdio_pf3 {
-- 
2.20.1

