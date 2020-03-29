Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A14196C9C
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2020 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgC2Ksa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Mar 2020 06:48:30 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35648 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgC2Ksa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 06:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:To:From:References:In-Reply-To
        :Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fDxFOVlMCyOGehYYYAC/qV8jV1DTDosFgHZObj8sD4E=; b=jF9Yd5vVNjmTFZW9qQ2dGkTrEs
        rzEbH3EM1ym7PA0E4cHPnC7/kcQ6/XV6b1JTJdj9OxK72Hxkm/EB8JPylLx8poD8dl8KqBDQ88yXT
        82h7IgE07i/0esOAmpCPRxOOlU2phodccMmacYHTyDKjdZTGwLACjE4l4dr95vPrIX7XjOXQMSnKJ
        qKcX4t8HP/4OPyew+u3j/9Q96BH7/i5wFaTiHLd+opj0RvpqmnkA7ZV8xSqAN+NoBAET+tSk+8SX9
        XKPULaM0MRF/1wMq/EHujOvnUWNGVZWO++Ao19qFmdLm9nF3CdnOTld8Zr9gDuhm+eQXB4aMkTjQK
        xMdwdrQA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37650 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1jIVUB-0004Ve-3L; Sun, 29 Mar 2020 11:48:11 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1jIVU9-0005h4-QU; Sun, 29 Mar 2020 11:48:09 +0100
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
Subject: [PATCH RFC 2/6] gpio: mvebu: honour EPROBE_DEFER for devm_clk_get()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1jIVU9-0005h4-QU@rmk-PC.armlinux.org.uk>
Date:   Sun, 29 Mar 2020 11:48:09 +0100
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Honour deferred probing for devm_clk_get() so that we can get the clock
for PWM.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpio/gpio-mvebu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index fa5641615db6..ee13b11c5298 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1132,6 +1132,9 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	}
 
 	mvchip->clk = devm_clk_get(&pdev->dev, NULL);
+	if (mvchip->clk == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+
 	/* Not all SoCs require a clock.*/
 	if (!IS_ERR(mvchip->clk))
 		clk_prepare_enable(mvchip->clk);
-- 
2.20.1

