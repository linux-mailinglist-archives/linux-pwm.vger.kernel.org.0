Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F741105AB6
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 20:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKUT7P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 14:59:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40146 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUT7P (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 14:59:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id 4so2636397wro.7;
        Thu, 21 Nov 2019 11:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1zEMak1xtoZs9HRUvVQmECvIPE9sMll9E3I8uD6vEY=;
        b=IHIkZ1iMAslXuQa9H6ec1tcB+APZC/mftNboSepSSuA1bZGI69+J2TikU/ppi2RecT
         BsFECPsNTTJjOGQ7/IFkKpPiCVMlZhrS9hm/Y9pTEjMMGCeY+yJcB8/SQ3Pq8wV/vpS2
         nKVpfa4gnWP+xnMOuDa4bhatfR6gb+5Qy6p3NjnR2ce03IwXghyYi387pjGydjBVD3jJ
         2hVivdERTdBNOO515CQDxmcdUE5BFc6irrfs788rmPP061erfnt5FmgrWpXCw1wtoxsZ
         9jJ7s1jfFLkl/WWgNLb1EHxt6O+ZqJgllFasSMGzQp/qDR8kWly2N5wQFj7BNcZJpAGn
         rjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1zEMak1xtoZs9HRUvVQmECvIPE9sMll9E3I8uD6vEY=;
        b=figiTWJUowGc3kXM0B08zwXrokKwrtP5Ss4TZkHJg5b9jSSKOuMMZL8iydALvBk9cF
         Fc6uxJLDrgriCkW8Cr+jyTWbVu1HzMtUxhTGX9u/+Pa+CdiY/gngDTL1DY10U8OFzmMW
         WdhKPhVMFTEBacghLa+TN+0QAaQ2DYoUXvzT5TbOPWb06rdto1wuwFeTQZsJp01Z4ipg
         Z2rFTaXWr/UIbpbUMTDoj3EHa0QLH62sKIvCpW6mx4KYLTNMFRhsZA8sQqvRgALh+ak6
         3fWwGejM0blVPgzwelKPCzC2lnKhTOMxkF4FUPryEft76yc4p5iC6KEPNO5zrl4t8Kv+
         FLnQ==
X-Gm-Message-State: APjAAAVJ5X299YZ43JJvsiXXqVCNzPeLz5WWGuuY3cHF1BzZXJssqeHk
        pEUfdTbS0DKLe8V66spYJrc=
X-Google-Smtp-Source: APXvYqz3/DrvPeGZASwJbOfOFh0A4mf6YmcVG2Pe73Pe8o9p/hgI3xVzx2ESvMpQrzIhkFA224jtOA==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr5680748wrv.77.1574366351196;
        Thu, 21 Nov 2019 11:59:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id l4sm747124wme.4.2019.11.21.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:59:09 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v8 1/6] pwm: sun4i: Add an optional probe for reset line
Date:   Thu, 21 Nov 2019 20:58:57 +0100
Message-Id: <20191121195902.6906-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121195902.6906-1-peron.clem@gmail.com>
References: <20191121195902.6906-1-peron.clem@gmail.com>
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
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 581d23287333..e353a03ec614 100644
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
@@ -364,6 +366,22 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
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
+		dev_err(&pdev->dev, "Cannot deassert reset control: %d\n",
+			ret);
+		return ret;
+	}
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
@@ -376,19 +394,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
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

