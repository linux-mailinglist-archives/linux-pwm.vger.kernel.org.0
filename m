Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF9010844F
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2019 18:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKXRaE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Nov 2019 12:30:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKXRaE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 Nov 2019 12:30:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so14667584wrj.8;
        Sun, 24 Nov 2019 09:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYFwEIE1V4FYviy3HfGWOu1YC137BU6qFV2JCNaspsM=;
        b=R4nVdGmbxb/sU9t4pMb9ieOCb0Ig3onMEUMKW67rm055djQFNNus9F8m6tppSUZrKf
         7k1DLC0T1bLyQAvrNNYM7A3w8a/7USxIeMNo+2zv3Sznhunnkxz9IAtkXkqbJJMBH+mI
         GKbvmeFuf+wwge4w4XFh+Ycuh7Adx5t3+Etr0qgz5WRDb81N3CJ07M+/lzuL5t1y5q6E
         ERyec0nPt5gDm90ld+tuD8rtRoPJpb9eEDMt1uHwbSw4fu/0rl9deUSLH5YcT8OtErfS
         qJbExGUdP0ZbHFoDoyhu5xK/mPSty0f3qtIeHxEFYk6RpO+LYRob54X/OJD1bBnX6gk7
         zUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYFwEIE1V4FYviy3HfGWOu1YC137BU6qFV2JCNaspsM=;
        b=pZ/Pz0OYBzXrqrQUXp7srzPn+v7hoecgVxorJC4V55lOlmBtlZPTZry+MNm9Rvmhy1
         6YLlCQxurKa0O2zeDIKP1d0cKJTXr1CNBc/+r7YNyLpS+131zkGqnwwTEZHXAtmnrJvN
         MNGUSMkJOeVskBLrA49soP/x2+/pvBGRFh2ddpDrGBZ9wlUOMWOu5JBGNK1Rw9+VWZYD
         2HmPOI1SUQFk+3ZfKSGIGcHEFopi5wF0EDMOvaI7aKuM1KpS/J3ILi1BJCKVZk/5QeyC
         ejiQMQdpc7zMNnYnQVHvYOvtAHPCuIvsFdeNZPhOv5dRF855F5EFZmDk/CNb4RykSZez
         IRmw==
X-Gm-Message-State: APjAAAXorelkV+02IAHgtOwae2isi8r4jWGIlzdRsVTnf3uZC7lLLi49
        lUpYUfQedIwQh3oG2efDeYE=
X-Google-Smtp-Source: APXvYqy28wuYUH31pkTeF6gqI821J6tzCh9ACuT8BpF1tD5bYMQvaf6TVGG/7ORii+bAKQDExzXHmQ==
X-Received: by 2002:adf:e550:: with SMTP id z16mr4175991wrm.315.1574616601645;
        Sun, 24 Nov 2019 09:30:01 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id n13sm5537275wmi.25.2019.11.24.09.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 09:30:01 -0800 (PST)
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
Subject: [PATCH v9 1/6] pwm: sun4i: Add an optional probe for reset line
Date:   Sun, 24 Nov 2019 18:29:03 +0100
Message-Id: <20191124172908.10804-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191124172908.10804-1-peron.clem@gmail.com>
References: <20191124172908.10804-1-peron.clem@gmail.com>
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
index 581d23287333..487899d4cc3f 100644
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
+		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
+			ERR_PTR(ret));
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

