Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC58ED49C
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 21:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfKCUdu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 15:33:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37393 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfKCUdt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 Nov 2019 15:33:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id q130so13971227wme.2;
        Sun, 03 Nov 2019 12:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dFi/U1rLrNtYEF4KWCZeapP9LyQz1KrI3hNiOLuNA64=;
        b=ZQUt1nmRM2FUbzYRthgFhs63Yvguqcf4AMFDBlwueb4W6j6t/ov+SAwCrRETGaIJQE
         t7Fj0TE4wHI7gocR1i1BJNL7a6SwNfgkKR0cDFXrjf1/uhjbGDCusfI4cvftb9xaYGJb
         robrcVE2VFFshdyIr2+0902/9v7nl3r6Scx+q/dyZ34o5XhdT+a8GKrGkfdFLxJgOrQs
         BzHAjQVpbkqQxpoyrKCY0QiTW9Odv8Rng1REsj4TmtILsOlr2Lf1HX6TYEtJ1EMrYS4k
         CnLlgDEGHSyG80fmMk4Xzn5ytEbV8EOmE/abaBCZrjWpTsrx/uk0Q230j39/7fFA3h9O
         rqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dFi/U1rLrNtYEF4KWCZeapP9LyQz1KrI3hNiOLuNA64=;
        b=SKZgwWgAn0ikvOMVv1NcY4YZlcay5xE6C0O85yc+8TnkLElyW4+UiY6q15a8PfD8LS
         tgbu6KYGnMLh3xPXh3dVkMEDveuK32X9BOMJ96MUcaDbbF4GyAkrbHh0pR4CcJAI9cw8
         JUrBH3ORnuaA+YjVja45OtwHaTd2hu85FOR3aD09G1XB+g+JAV70MwMqTWN/klAysFtq
         tBqUNhIqLhCDsqzZwCIdQp2iI5J9M3n8niGy8jAV4obPoDbsBsomqHiyYGY9bht4Q2JX
         lbrDhRrIQ9ED99YQtxcWV1LbnxI+q8hECdyAQYtIKfhCvxBSsXXpXkly8hPEZ9FsDune
         O7ew==
X-Gm-Message-State: APjAAAVFrWjSDssvTkIsmW8rLxzFUarczBEKOLunYeBAjgW3h9qaHSrF
        AZBnSS1fYLAOgm2IdkkIqRs=
X-Google-Smtp-Source: APXvYqyHGuQGzFLqWSs1hRl/bS7UtXf/0vTeNiNDZ0Jn7ft1yhN53cmPZImc/ucvSmsNoFapr7/39w==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr19936742wmj.121.1572813227311;
        Sun, 03 Nov 2019 12:33:47 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id x16sm13644026wrp.91.2019.11.03.12.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:33:46 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 2/7] pwm: sun4i: Add an optional probe for reset line
Date:   Sun,  3 Nov 2019 21:33:29 +0100
Message-Id: <20191103203334.10539-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191103203334.10539-1-peron.clem@gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com>
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
 drivers/pwm/pwm-sun4i.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6f5840a1a82d..d194b8ebdb00 100644
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
@@ -365,6 +367,20 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
+	pwm->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(pwm->rst)) {
+		if (PTR_ERR(pwm->rst) == -EPROBE_DEFER)
+			return PTR_ERR(pwm->rst);
+		dev_info(&pdev->dev, "no reset control found\n");
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
@@ -377,19 +393,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
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

