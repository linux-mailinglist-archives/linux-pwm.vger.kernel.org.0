Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAD85100345
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 12:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfKRLBR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 06:01:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38352 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKRLAo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 06:00:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so18897809wro.5;
        Mon, 18 Nov 2019 03:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFDrmtiB5h/Zr80zbuCGUX75SrtWuuQxETq8orGACdo=;
        b=rvyNyMqc1D+jPRurNAmZ1sgzsaQbzJ6wBBEgsy5D62mpDk+XyXG1TxGfzXo+McCZcK
         +NcIA9co9Xqvh9g01D673oDyHFpJH79a0edKgNXuqb3wExDS+/BUX2arhQ4IKS9sm3oI
         QYR1xDwpYxJ5EabIT7IGZibDN1zGNcEi9R/Jc+bFsSuSRFlA1ZCVpXFVOyNLAjou90JX
         JJlXlJd3biqLgGfo6CzTzaXpw3qZfAm7TlyjVglBdd93dZaTnCIPQ9hljWAM3YUbmHFH
         2MTNDC/4JxaDfN0yA/p2GYPjIrktq56S2KV7+CsxGYI0tPHdgYqFM2GNmSZ487AkFbAg
         fK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFDrmtiB5h/Zr80zbuCGUX75SrtWuuQxETq8orGACdo=;
        b=WxlJBPi60IvpPZNmUzLnAx+ig/ab/DxjMzmEVjZgZ9y5SCakgildK+mCk9t2ecItLU
         /3mYoZNQQLY4pCI+AYDg0EEKsnWxCNUVMgsWKeE/v/AVSnhJmy+bYmVXdzlGP/Q/LdEB
         TsB1ENEcqlcnkMpzQ7wcFp1TRiXhGg8xLrWQhKbdw02sSTqYCiyRDAuON9A5x0vk1ysS
         TaRw4LSS3L4o9NWSAqMPcnkSMvkynR4NXNiRIZ/+wUnBZYEvFnP6mXNx/GQdRXYV0hlh
         fW/YTnJeH+XgUvxDBlIsodYV46w5fF3g0bXr+C/G15cuIhvwmhAciXMuGu1h32wTRy5X
         MO/g==
X-Gm-Message-State: APjAAAWdzQ7MtPQhfh3nWMyMHSHciC6MSVgFG0/f3oCNLDUvcmtR7yMF
        DKvjL0dtsp9yGTwaKggMjbJqhLe4MGIaeA==
X-Google-Smtp-Source: APXvYqx75gEPB0FteaYS2yHGOP2I2/utQyuuZOScnt6LFmIebZFYgGAW1ROUtA2x2X9B7RfWT43kyg==
X-Received: by 2002:a5d:558e:: with SMTP id i14mr28728525wrv.140.1574074841156;
        Mon, 18 Nov 2019 03:00:41 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f67sm19873313wme.16.2019.11.18.03.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:00:40 -0800 (PST)
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
Subject: [PATCH v6 2/8] pwm: sun4i: Add an optional probe for reset line
Date:   Mon, 18 Nov 2019 12:00:28 +0100
Message-Id: <20191118110034.19444-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118110034.19444-1-peron.clem@gmail.com>
References: <20191118110034.19444-1-peron.clem@gmail.com>
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
 drivers/pwm/pwm-sun4i.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 581d23287333..c17935805690 100644
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
@@ -364,6 +366,21 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
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
@@ -376,19 +393,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
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

