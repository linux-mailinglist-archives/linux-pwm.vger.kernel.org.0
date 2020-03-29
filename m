Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D4196CA6
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2020 12:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgC2KtE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Mar 2020 06:49:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35724 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgC2KtE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 06:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:To:From:References:In-Reply-To
        :Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FIhy4sqBq+sE5SE/l6Fqg9Ig3bzmfn+3BSxVo4JGEjg=; b=s6gmbyy0re2ZBa05B4xYvZ/sFc
        +pBuFoACtn2czoTK0vTP6/vnw5ErI4VsuMVWreTOwV7mZ2PgyNEpwdEhk40SuNmuIm5bjhsctGfSy
        S7Yw4xD7qkWBoMzZkr+qsKZeNvTO+c1nEb7wz1W21I5e1ejGJPWPqpQyV13ZXtUMqLgdtfYAip+Aj
        d/M3iSu3ZInibuYKHmh6gDJANeB5UYK0B+Jj16TMfunLu6xQWcPiAd9dYZXLlkWpwlRRP3N2ojelg
        NtSbp1RUx7e566s+efmZ0G132Cphp8AOsHnnh3hVYk7l6VszGGoMU6eRpix16EjN+q1UMn2JnASaB
        3sYtjF4g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37656 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1jIVUS-0004W2-To; Sun, 29 Mar 2020 11:48:29 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1jIVUP-0005hc-6g; Sun, 29 Mar 2020 11:48:25 +0100
In-Reply-To: <20200329104549.GX25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Uwe Kleine-Konig" <u.kleine-koenig@pengutronix.de>
Subject: [PATCH RFC 5/6] arm64: dts: clearfog-gt-8k: add pwm-fan
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1jIVUP-0005hc-6g@rmk-PC.armlinux.org.uk>
Date:   Sun, 29 Mar 2020 11:48:25 +0100
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add pwm-fan support for controlling the fan speed.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index dc531d136273..a514ae51ccbf 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -31,6 +31,11 @@
 		ethernet2 = &cp1_eth2;
 	};
 
+	pwm {
+		compatible = "pwm-fan";
+		pwms = <&cp0_gpio2 16 40000>;
+	};
+
 	v_3_3: regulator-3-3v {
 		compatible = "regulator-fixed";
 		regulator-name = "v_3_3";
-- 
2.20.1

