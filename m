Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B69243A03
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Aug 2020 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgHMMtQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Aug 2020 08:49:16 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:45109 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHMMtA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Aug 2020 08:49:00 -0400
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D79CB23E4E;
        Thu, 13 Aug 2020 14:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1597322937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scfh2Kvik6gQvEIpEm2pPDYNo2I8IIi2eKTQ88yDCYc=;
        b=acsJDnf1WLPsKCuWArwtXeP8tGWXq69pN6VC9yOe/oRZppSxu58JprPqFLffx1HgzfR3M6
        iTFLVmgT0zOxeSw5fOAUyu8Lm8Y8GSPVvu/rYmTPB5OjLlvtq21LU3Ui9ATAag9Jw8YCm1
        zYn9bpPiTI+69wPmq1mADkvfWvX7TtM=
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
Subject: [PATCH v8 12/13] arm64: dts: freescale: sl28: enable fan support
Date:   Thu, 13 Aug 2020 14:48:31 +0200
Message-Id: <20200813124832.17349-13-michael@walle.cc>
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

Add a pwm-fan mapped to the PWM channel 0 which is connected to the
fan connector of the carrier.

Signed-off-by: Michael Walle <michael@walle.cc>
---
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

 .../dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
index 0973a6a45217..c45d7b40e374 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
@@ -15,6 +15,15 @@
 	compatible = "kontron,sl28-var3-ads2", "kontron,sl28-var3",
 		     "kontron,sl28", "fsl,ls1028a";
 
+	pwm-fan {
+		compatible = "pwm-fan";
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		#cooling-cells = <2>;
+		pwms = <&sl28cpld_pwm0 0 4000000>;
+		cooling-levels = <1 128 192 255>;
+	};
+
 	sound {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.20.1

