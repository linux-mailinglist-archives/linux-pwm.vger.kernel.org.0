Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4089408496
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Sep 2021 08:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhIMGVl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Sep 2021 02:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhIMGVk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Sep 2021 02:21:40 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADEDC061574;
        Sun, 12 Sep 2021 23:20:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y17so7799521pfl.13;
        Sun, 12 Sep 2021 23:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJZFP5k7d2O2P1gl9RWPWTU9kiXtHQ6xmLwf4B4cHAc=;
        b=dWO6Vr1w1z/Y5cyRncMP28ZhnmG8SNYRD+5cWts5t4zwKh+N3m5+jrl3Nqe6zSSis4
         KzqgKP429efnM2caaT8XS5hcH+Qo2YTKOFY37Ekz4Srvh3zR9upLXsdmuSv8Nx7X/jaF
         LPuXdbJCfMU3bZLzvRey5coKIwDIwFJ3ckoMP1tPkvWupHPJCxe0Yo2mbq7gYPpzBm39
         OQ56iT5SZmv+9r9+McdQDiBYeqQoy8dwrtCmdPofIsttfueDHztzIybGexrlfil4OY6c
         M3iyl+uXNr55VAy+KRZFUZjsvBEj/ddtMOVgibtdAXn0KXMl43nalsHDBzrNQn6CYoQp
         TiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJZFP5k7d2O2P1gl9RWPWTU9kiXtHQ6xmLwf4B4cHAc=;
        b=niEBYWDpGauQmFeHKtxuWjBrcek9WNq6q/J7Xt05RBZYdI1OW9WSWo47ZrucQK1g9B
         fBNIuizFO32DiPngeGDuwrAkWQB55Qh48HaXV8LwTAS1veWVbodY3NzSNjvRRfFQVnAs
         k/hWdM9xAZr0HgF1/ihSQ7VR1ZGDKKwg3S/2wRIIQQ+ys0mLkh0TSSZsIgkI41kxH11N
         1XeVmgaM/POJDxt8eR6YV0CTYZX4PsrItF3IBhj2aU/l+Sa0tRFSSJz3BNmINAr/cCkx
         DcrMZwLFt7M+FRKqfxNiINBSqjUc1EJwAIahDEhjFhcaIvfgG8b+AMDsrLPvKULFyYVS
         E02A==
X-Gm-Message-State: AOAM532vRxzZg11e7/JS2WS0tTTcGLb6zgYVa625mjNTld2MNAweMZ0k
        qDtEdGzqsaArwDX/YOdoNGA=
X-Google-Smtp-Source: ABdhPJxydawtyrw408aHRADdQSSQtY4CoMrjVipz31NpqSnTyslm+Mek54wUlS+h5hosr6C61V6U/w==
X-Received: by 2002:a63:7d04:: with SMTP id y4mr9854031pgc.131.1631514025291;
        Sun, 12 Sep 2021 23:20:25 -0700 (PDT)
Received: from localhost.localdomain ([111.207.172.18])
        by smtp.gmail.com with ESMTPSA id f6sm5701659pfa.110.2021.09.12.23.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 23:20:24 -0700 (PDT)
From:   zhaoxiao <long870912@gmail.com>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhaoxiao <long870912@gmail.com>
Subject: [PATCH] pwm: visconti: Simplify using devm_pwmchip_add()
Date:   Mon, 13 Sep 2021 14:15:53 +0800
Message-Id: <20210913061553.21450-1-long870912@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This allows to drop the platform_driver's remove function. This is the
only user of driver data so this can go away, too.

Signed-off-by: zhaoxiao <long870912@gmail.com>
---
 drivers/pwm/pwm-visconti.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
index af4e37d3e3a6..927c4cbb1daf 100644
--- a/drivers/pwm/pwm-visconti.c
+++ b/drivers/pwm/pwm-visconti.c
@@ -144,28 +144,17 @@ static int visconti_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	platform_set_drvdata(pdev, priv);
-
 	priv->chip.dev = dev;
 	priv->chip.ops = &visconti_pwm_ops;
 	priv->chip.npwm = 4;
 
-	ret = pwmchip_add(&priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n");
 
 	return 0;
 }
 
-static int visconti_pwm_remove(struct platform_device *pdev)
-{
-	struct visconti_pwm_chip *priv = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&priv->chip);
-
-	return 0;
-}
-
 static const struct of_device_id visconti_pwm_of_match[] = {
 	{ .compatible = "toshiba,visconti-pwm", },
 	{ }
@@ -178,7 +167,6 @@ static struct platform_driver visconti_pwm_driver = {
 		.of_match_table = visconti_pwm_of_match,
 	},
 	.probe = visconti_pwm_probe,
-	.remove = visconti_pwm_remove,
 };
 module_platform_driver(visconti_pwm_driver);
 
-- 
2.20.1

