Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C16215D9C
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2020 19:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgGFR5u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Jul 2020 13:57:50 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:44823 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbgGFR5k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 13:57:40 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A1DB423076;
        Mon,  6 Jul 2020 19:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594058258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaJTib0El6RuCqem4ff+qm2uIBnrMR78QamdeJxxetg=;
        b=PI1rsLYwJehgdpqwbXSJvkqoSb4GMDxGR1x7/ZwKjFv8gBuqW1sw/K2jh96pWheyBUBBrg
        ZEkesL1gLIHlvrwSJRW81iIJ2x8Vqqq7vTbQM+KNsdKlE9jHY2pU4/gftpIl3hW3d0xua2
        dNR72mAuUB33kOJTaVcn40vms8emoE8=
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
        Michael Walle <michael@walle.cc>
Subject: [PATCH v5 12/13] arm64: dts: freescale: sl28: enable LED support
Date:   Mon,  6 Jul 2020 19:53:52 +0200
Message-Id: <20200706175353.16404-13-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706175353.16404-1-michael@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
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
Changes since v4:
 - none

Changes since v3:
 - see cover letter

 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
index 4b4cc6a1573d..49cf4fe05c80 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
@@ -16,6 +16,20 @@
 	model = "Kontron KBox A-230-LS";
 	compatible = "kontron,kbox-a-230-ls", "kontron,sl28-var4",
 		     "kontron,sl28", "fsl,ls1028a";
+
+	leds {
+		compatible = "gpio-leds";
+
+		user_yellow {
+			label = "s1914:yellow:user";
+			gpios = <&sl28cpld_gpio0 0 0>;
+		};
+
+		user_green {
+			label = "s1914:green:user";
+			gpios = <&sl28cpld_gpio1 3 0>;
+		};
+	};
 };
 
 &enetc_mdio_pf3 {
-- 
2.20.1

