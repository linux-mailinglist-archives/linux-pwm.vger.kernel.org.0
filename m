Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18608EFE2B
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 14:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388987AbfKENPW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 08:15:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52333 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388945AbfKENPF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 08:15:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id c17so13507734wmk.2;
        Tue, 05 Nov 2019 05:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFpznEDpNoqbmapZynyzmsx8KHYXXRH6cqD0i8XMxAs=;
        b=f3YD4Ug76oHoUiN2crsPXDr3EPqby4+c3lsOUMycDhYNq/6o4SNBSto4xo+qsJAwx3
         Zol/D6WTEF5MjdbCemPv4t29kj/WxcDBW7dtegaY7sCh7B2DYPqbQmm2uAAdA9PolHl3
         IgiUuJwwNkd8xpU9S2QQxN3hvuI3AbpYvrvZuZ7c6Aa8wedCqkA+lC+CfUeGCSNw4e17
         y69oRLohtZEtA5pIeBk/9WtzIaf2S0VMULc9fc+xCancs6LArLYHor6ZihYeQ3JfzkOr
         U6j3UZE8HlOxHVyMNtm8UqiUgLWd6k6oMeiy7UtLOlcSaPVbWB+ijzW8qfAAh5aIrImD
         rCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFpznEDpNoqbmapZynyzmsx8KHYXXRH6cqD0i8XMxAs=;
        b=aprZpJzAmyHRv3uPHdIAX6YdhWp0FwutXdzkiXjzYPM9HmYRM7noyIL7vUP9PxoXd7
         b4Oy1BKKNQuCLsH4LFtnr4fVSuauhmruZUQuKrdM1cTEDK7kr8Fm/y9fUXSijdlSP/5O
         8hxCXasGfYQZQPU1iD+YN+8CjyEHnV4pKOHbItNNF5En4RZbvAtygBwMDo1axdUbnkM3
         kCh78cr8090eKyMX94Zhug/tySAuj/xTF7CAKZfRkiuEgFbv3EjmK6gSWfy88Jy2ol4F
         gEu2Wc1NT5VfQfN9qSUsQI57+PIZIuqm1y6ZRBmt47m9x6wFZCV3jO1kx1lRE3CfUxPJ
         oGuA==
X-Gm-Message-State: APjAAAVbXOq/XjR77X2O+Ao947tjHP9dnaxmhOt4fcOSQMuPNrJ2juI6
        BC6utZv4G6JkX5h+qSGmo1FCUxlW6/3dUw==
X-Google-Smtp-Source: APXvYqyytLo0hQuO6sVxwOrnNs0IMG5xvWjRMfkyUlPHv/0jVyEk1u++gI1pakSzxaECVGMTFnJaFA==
X-Received: by 2002:a7b:c632:: with SMTP id p18mr4219706wmk.73.1572959702668;
        Tue, 05 Nov 2019 05:15:02 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id a6sm13549920wmj.1.2019.11.05.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:15:02 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 2/7] pwm: sun4i: Add an optional probe for reset line
Date:   Tue,  5 Nov 2019 14:14:51 +0100
Message-Id: <20191105131456.32400-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105131456.32400-1-peron.clem@gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com>
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
index 6f5840a1a82d..9ba83769a478 100644
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
+			dev_err(&pdev->dev, "get reset failed %ld\n",
+				PTR_ERR(pwm->rst));
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

