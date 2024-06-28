Return-Path: <linux-pwm+bounces-2634-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE4D91B738
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 08:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A15E1F24C7F
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jun 2024 06:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE56F2F3;
	Fri, 28 Jun 2024 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mW03+Smu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8645D299
	for <linux-pwm@vger.kernel.org>; Fri, 28 Jun 2024 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556543; cv=none; b=cwZbgdSrTMj91rFSigg+sosMrmIYOFrYTBhKfSstZm32+iuZLCeC/hw+OvtLhpqX/EOTJnX7iIy1r6gb5Fqu2ptNT4TQv5E+BGJ4kLAe5pJ31wcqsgviJbwZybBtqfDnp33L13GF6Ub/XdP016Mq3AFKd1DIyITh0+2dkflb3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556543; c=relaxed/simple;
	bh=87/dG3jexQmz5+T0cC7pfhCQFwWDm3M0fKcLB+sF11w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OmtokvhxhCo0ZodffQgzfhtOOK2My/JNw5/hwS06zxSwoW3KGRsvexWYIA17h88TW0Sw5qpppGwWkcxcROCEj58fxGDVsjl0wIOpjbXIWasMKJVVOErauK11qRA8ZbeAt8hPn7pb5BoaoNZ7qFN4MvEuY0v5MZqEGCpoFbUK/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mW03+Smu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a724598cfe3so30410666b.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719556538; x=1720161338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cxGk+4YqqsWozGTNKL2A0eZoKoj+wj1wN0F9i8w3Ggs=;
        b=mW03+SmuJDumou3XMrSdQP9zs7MFfwghe7AtQ1dkEnfnJ9Aw40z0Jca3OgdleC2UDO
         TJCIZYxckAM4qEpmpq6wdGLcqOg9ZUVxWEpZLhAd7E+unpsAJcc4VBpUwuUR04P/Ay6e
         NV4r8apkbwIKwxt8yySq3Ur7wd3bA/93pckKwlQMXPb7iT+BVnXbLBiyqWLErxxUF75O
         QYt1P/dcS/Qd1f3C9ButlynZXreOLuCfTHM3X+fnWYJufN+tyeiUB+MBHmKBrXUctu02
         jB1erKmLjmrqGZAcmQ0VoNTaJMvHXNAD+Dp1OaTlGN+w7Sr/IeVrtTDqvascReeU15Lt
         GV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556538; x=1720161338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxGk+4YqqsWozGTNKL2A0eZoKoj+wj1wN0F9i8w3Ggs=;
        b=eF7qqwQE5NgdLITpGVtRhtq0ThKmPMunmUFSPc0qv6TjDGsGb6g+qPdsVJqpCNqZUr
         jPO1IQmZCl6H4/XG1u6baofsr0LINo85IYkmCDq1rfKID3bWT5DDYnoiaat/bWR5v28O
         Uz5W51jMpZ01XrzkyizYYp9xGJ+NVxOLKwTbL5hK0gxEK+6mbEUYGELdqzlAlCURjD+r
         VVmMTI+1BwpitPHakjXx9XWu4UG0ID9a5kkq+Pa5WCmdqq0SbyFxavabwLwkEyx+VXbt
         wHofe1PtV8qCRTwcSq37ZXuJZnFtte7D8kEANqcopiE3IhRlmSU/+4MiVWYWEaN26J2j
         5UqA==
X-Forwarded-Encrypted: i=1; AJvYcCVOE9LARb3vAAEVWKwmr+YQafkThlIkQhwFC7BIY6hlJfFA62nhXjPIe4cjeylojdzhXBcYXm70zfwq5zC18J9u37LJLMhNN/7b
X-Gm-Message-State: AOJu0YyHb3oo4WlprUaggZKjXsTzyV3fxALOB/OS2rHZbUMx/nAKcFC4
	CwVm5OGABl2+XOnVAwdglY/NXky0jXK5b3340JxhOzdnuK9wq7zVnMS81vrhSowS8+pnwQPWbrt
	XJtE=
X-Google-Smtp-Source: AGHT+IGNyT3nClEBTHYQMeDvWkm+Sfii1qsZ3JbUNupryrA2bafFHa28Vuxz44XUGZRQd87uAkJ1HQ==
X-Received: by 2002:a17:907:104c:b0:a72:455f:e8b with SMTP id a640c23a62f3a-a724599a00cmr1154233166b.0.1719556538014;
        Thu, 27 Jun 2024 23:35:38 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:2d35:3c3:59a:94a4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1bd30sm46024066b.12.2024.06.27.23.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:35:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Michal Simek <michal.simek@amd.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: xilinx: Simplify using devm_ functions
Date: Fri, 28 Jun 2024 08:35:23 +0200
Message-ID: <20240628063524.92907-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=87/dG3jexQmz5+T0cC7pfhCQFwWDm3M0fKcLB+sF11w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmflmsZwEH0eEUQHX2tPaAjYOpHdyns2iHZP3nG QOQw2Xu71iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZn5ZrAAKCRCPgPtYfRL+ TmniCAC4TiW6H0gfqvXle1C8o1sDN05IPP4qLm85XpsCRU9cFuopDd+00IAyZIL4mfNRW/P7G41 EY+KncVfp3XItAsYBADlOgTQ57JWcFntuhM3LWrU0Slo/pVdaAHyHN8H6S9+kEqBHHs6IBfKbxa Vv+/edBlUnJNoCAQz+n+jju0SD2pyPJcG/kySczLZEkWb1sY8eP+1rSKHejlj47zVD020q3sRAM o90cOOBjmwMfcLY8vnb1ZQNIDRwxS/FQuvyToZTg1cK40d+RTO6VjtB76PoVpIBBcXW+QjTtphm TG6vv4fzJ8UfsJT2iaViqStwOZmyJ2ztWQP6kuaaEWMxIly6
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There are devm variants for clk_prepare_enable() and pwmchip_add(); and
clk_prepare_enable() can be done together with devm_clk_get(). This
allows to simplify the error paths in .probe() and drop .remove()
completely.

With the remove callback gone, the last user of platform_get_drvdata()
is gone and so the call to platform_set_drvdata() can be dropped, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-xilinx.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
index 3a7deebb0d0c..52c241982807 100644
--- a/drivers/pwm/pwm-xilinx.c
+++ b/drivers/pwm/pwm-xilinx.c
@@ -224,7 +224,6 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	priv = xilinx_pwm_chip_to_priv(chip);
-	platform_set_drvdata(pdev, chip);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -263,37 +262,24 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	 * alas, such properties are not allowed to be used.
 	 */
 
-	priv->clk = devm_clk_get(dev, "s_axi_aclk");
+	priv->clk = devm_clk_get_enabled(dev, "s_axi_aclk");
 	if (IS_ERR(priv->clk))
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "Could not get clock\n");
 
-	ret = clk_prepare_enable(priv->clk);
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk);
 	if (ret)
-		return dev_err_probe(dev, ret, "Clock enable failed\n");
-	clk_rate_exclusive_get(priv->clk);
+		return dev_err_probe(dev, ret,
+				     "Failed to lock clock rate\n");
 
 	chip->ops = &xilinx_pwm_ops;
-	ret = pwmchip_add(chip);
-	if (ret) {
-		clk_rate_exclusive_put(priv->clk);
-		clk_disable_unprepare(priv->clk);
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
 		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
-	}
 
 	return 0;
 }
 
-static void xilinx_pwm_remove(struct platform_device *pdev)
-{
-	struct pwm_chip *chip = platform_get_drvdata(pdev);
-	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
-
-	pwmchip_remove(chip);
-	clk_rate_exclusive_put(priv->clk);
-	clk_disable_unprepare(priv->clk);
-}
-
 static const struct of_device_id xilinx_pwm_of_match[] = {
 	{ .compatible = "xlnx,xps-timer-1.00.a", },
 	{},
@@ -302,7 +288,6 @@ MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
 
 static struct platform_driver xilinx_pwm_driver = {
 	.probe = xilinx_pwm_probe,
-	.remove_new = xilinx_pwm_remove,
 	.driver = {
 		.name = "xilinx-pwm",
 		.of_match_table = of_match_ptr(xilinx_pwm_of_match),

base-commit: 642a16ca7994a50d7de85715996a8ce171a5bdfb
-- 
2.43.0


