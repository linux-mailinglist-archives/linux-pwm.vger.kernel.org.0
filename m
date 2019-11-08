Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7B6F4269
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfKHIpb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 03:45:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46179 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfKHIpa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 03:45:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so5994270wrs.13;
        Fri, 08 Nov 2019 00:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QB9cDt6fQFRk5SFMea9eu/ALXFa2Va/mC6ymi+w/Cs=;
        b=XAIZ3SDFz73VRt8TZCqiOw69FrFZzRA1dTXc1hz0ORCz+jktoeMrothomPqIFQnMX/
         zXyXRHN5y/AOcEwPSMzCu1ucukhVGog6MOeheYacZR9kWZc4zYpImP1NmndcN/7OPHOo
         xpsr6JYrl4Lt7gC1iuvuA+cojKhG0Zhk+SndYQCpyrKrISaaubKr+9LL7/bIV9keknYJ
         pk3O4dJCG7kgfcX2HK8D2cJesxBVmihhqFZVUGJNkN5PQSJmtk4hl9zh6utMONSE1e0H
         VvZEIPGHrezzqSrg6HYEJF7ayIb4arDg3BA3A7hbfceyczL1rswg/VN08wgDRfX7MXsL
         vhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QB9cDt6fQFRk5SFMea9eu/ALXFa2Va/mC6ymi+w/Cs=;
        b=g/sJs1oPKQrSOaPZ26UmsqDxjWfhmTBhnwG0BHLydtNsQ8ddyM4PLFXubIVHciiSGO
         u+hF6zWAnCH+pNWTMg0F2gD+JkaxDHaJQr5nPalxm4h5pEICIut2GQ/UXvpGGPZ+KHI/
         19Z3czVCKCa7jNzu4Zco4LSdarpwPzucNXT7o48kAG2m0Oe4BAMo5L8uxWbAe5NI1338
         dICBr5AbnZ78dFhzeuqpDrrBjUFLrL7A/p88g9vrfuJsDhE4Lr8PB7qd6eMapbir6UwK
         S9GVtC5CKKUK9UhyHPAkYHM1/bsv9sqIxm8Vyd91cuYbVGvw/EKRujsETIL9CvwWmrzx
         tCnA==
X-Gm-Message-State: APjAAAWCTBIGu++CPWotlkTX/YXUTthT6IuRrueVwwvxmrpxnMgOplJc
        S8YcIc6t6gdDcYW9ryNKbnYl+qT4+gw=
X-Google-Smtp-Source: APXvYqxd907rYnKrigSrYCn3h6dEANybH8eRG+Xwv2u3fyvd4zj6zcYXc+0Y4jkia+vCViGcSMYgog==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr7396315wrw.129.1573202728267;
        Fri, 08 Nov 2019 00:45:28 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id q25sm6662665wra.3.2019.11.08.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:45:27 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 2/7] pwm: sun4i: Add an optional probe for reset line
Date:   Fri,  8 Nov 2019 09:45:12 +0100
Message-Id: <20191108084517.21617-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108084517.21617-1-peron.clem@gmail.com>
References: <20191108084517.21617-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 PWM core needs deasserted reset line in order to work.

Add an optional probe for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6f5840a1a82d..2b9a2a78591f 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -16,6 +16,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/time.h>
@@ -78,6 +79,7 @@ struct sun4i_pwm_data {
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
 	struct clk *clk;
+	struct reset_control *rst;
 	void __iomem *base;
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
@@ -365,6 +367,21 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
+	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	if (IS_ERR(pwm->rst)) {
+		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "get reset failed %pe\n",
+				pwm->rst);
+		return PTR_ERR(pwm->rst);
+	}
+
+	/* Deassert reset */
+	ret = reset_control_deassert(pwm->rst);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot deassert reset control\n");
+		return ret;
+	}
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
@@ -377,19 +394,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		return ret;
+		goto err_pwm_add;
 	}
 
 	platform_set_drvdata(pdev, pwm);
 
 	return 0;
+
+err_pwm_add:
+	reset_control_assert(pwm->rst);
+
+	return ret;
 }
 
 static int sun4i_pwm_remove(struct platform_device *pdev)
 {
 	struct sun4i_pwm_chip *pwm = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&pwm->chip);
+	if (ret)
+		return ret;
+
+	reset_control_assert(pwm->rst);
 
-	return pwmchip_remove(&pwm->chip);
+	return 0;
 }
 
 static struct platform_driver sun4i_pwm_driver = {
-- 
2.20.1

