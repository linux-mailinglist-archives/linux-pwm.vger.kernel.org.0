Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A661B2697F9
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Sep 2020 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgINVpA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Sep 2020 17:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgINVoR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2020 17:44:17 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC545C06178C;
        Mon, 14 Sep 2020 14:44:08 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 94C2723E47;
        Mon, 14 Sep 2020 23:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1600119847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+VVp1S1/1mEp4bh4MChiZeax7qY5irCWr9wzBp6vkg=;
        b=m3Y1PIBnAJ7ZfyFUZboU6MLBZZDJXJspu+LTPNMyNz4ajDAdQbjof3iwju3FBcbgGdxPxP
        7YJO69Dx551zJPh21R22e57XZvJBwWbGllumHe7aqly8EIR/gJwEeJW8kvgW/rJRFLRSSz
        Sr78xtxAfdER3VpJkyHO4enZOiPN9VA=
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
Subject: [PATCH v10 10/13] arm64: dts: freescale: sl28: map GPIOs to input events
Date:   Mon, 14 Sep 2020 23:43:38 +0200
Message-Id: <20200914214341.14268-11-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914214341.14268-1-michael@walle.cc>
References: <20200914214341.14268-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Now that we have support for GPIO lines of the SMARC connector, map the
sleep, power and lid switch signals to the corresponding keys using the
gpio-keys and gpio-keys-polled drivers. The power and sleep signals have
dedicated interrupts, thus we use these ones. The lid switch is just
mapped to a GPIO input and needs polling.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v9:
 - none

Changes since v8:
 - none

Changes since v7:
 - none

Changes since v6:
 - none

Changes since v5:
 - none

Changes since v4:
 - none

Changes since v3:
 - see cover letter

 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 5fdf4ec8b39f..f46eb47cfa4d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -9,6 +9,8 @@
 /dts-v1/;
 #include "fsl-ls1028a.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Kontron SMARC-sAL28";
@@ -23,6 +25,36 @@
 		spi1 = &dspi2;
 	};
 
+	buttons0 {
+		compatible = "gpio-keys";
+
+		power-button {
+			interrupts-extended = <&sl28cpld_intc
+					       4 IRQ_TYPE_EDGE_BOTH>;
+			linux,code = <KEY_POWER>;
+			label = "Power";
+		};
+
+		sleep-button {
+			interrupts-extended = <&sl28cpld_intc
+					       5 IRQ_TYPE_EDGE_BOTH>;
+			linux,code = <KEY_SLEEP>;
+			label = "Sleep";
+		};
+	};
+
+	buttons1 {
+		compatible = "gpio-keys-polled";
+		poll-interval = <200>;
+
+		lid-switch {
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			gpios = <&sl28cpld_gpio3 4 GPIO_ACTIVE_LOW>;
+			label = "Lid";
+		};
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-- 
2.20.1

