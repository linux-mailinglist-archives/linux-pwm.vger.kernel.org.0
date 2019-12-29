Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B711D12C170
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfL2IGR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:17 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52295 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfL2IGQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:16 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so6625563pjh.2;
        Sun, 29 Dec 2019 00:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7MOyAvsl7hLR/NAAZrg0Tl8RxNJ8Thj3NWHXJac8tOY=;
        b=HP8//w3mq738Q5i6Q/DrOq/tt/pMGuyna/50i2l4s22Wp5mSV/k2J7Lw+zUpJlKOrs
         x+XWIYzJOmeQL8ZlkFtfkeDNPjOYMJLS9zSLk96rUNqyhp9COeYjn8Bao0nb7z85XBfW
         l4aEeA/eo5p5eVD6913J6G/q+3T2K2hTIjnRZc47vG8eDe71vh5wTVJ50hB6pG3lE6Rg
         gjrRHZ1PqFZVuFh1Ut/d7YLLeNggOcsedUutRgUmvVrwJeURTw10shPjYshyoI1HfWKh
         7W0+4PPCk+U6TwrVcLh35ENDH0pdw0m6Ag11Jx51+trV1pGjZbjlMVgiQJx6l2rJeRRc
         YXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7MOyAvsl7hLR/NAAZrg0Tl8RxNJ8Thj3NWHXJac8tOY=;
        b=onhPBXaPAZq0md/jT0oMTTSSXsmTpOlmoRt51k7gi+Gh1UraYBpZlXddCF47KsmEhD
         r97O6Hnk9QLzmNBQ499/AS9gJDT1Yq+Kj477Lce87ydq50TWzJkLBGVElXrHtp44g/uV
         SN/rclqIvOyoIVtyXyVpBfJWfyLighc5uiCI2Mbl6EZnDxUid9AzgdG91aJCcxBhB/Ur
         6W+ewwYBHWmeIOMP8R7dTwsefyS8a7E6xtH3AQze8fXOo1IOCbz8ClBDmaaAk0pDfYO4
         BzagveBCxY/dSFTPyZ6OcV1NnT++WIhYL/uXuRxKLJFq5dS21YOoIRrrT4iVPjOo0/7K
         XieA==
X-Gm-Message-State: APjAAAWxbbJWW75m1Kt29MrDxhqLykShWCS23h42iweiTiaalENuQ3lL
        2V9gHUfQVf6PxU+4HIynaaY=
X-Google-Smtp-Source: APXvYqy1wTVcUu2x5AnMvZHhJ0jjpIHWbLntN+XhT5/06mRyCVTdV4J50yCposjgMKZ8TFMY1wyN4A==
X-Received: by 2002:a17:902:ff13:: with SMTP id f19mr7303920plj.306.1577606775718;
        Sun, 29 Dec 2019 00:06:15 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id r30sm45735077pfl.162.2019.12.29.00.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:15 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        nsaenzjulienne@suse.de, shc_work@mail.ru, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, vz@mleia.com, slemieux.tyco@gmail.com,
        khilman@baylibre.com, matthias.bgg@gmail.com, heiko@sntech.de,
        palmer@dabbelt.com, paul.walmsley@sifive.com, mripard@kernel.org,
        wens@csie.org, jonathanh@nvidia.com, linux@prisktech.co.nz,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 02/32] pwm: fsl-ftm: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:40 +0000
Message-Id: <20191229080610.7597-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229080610.7597-1-tiny.windzz@gmail.com>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 59272a920479..2a6801226aba 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -399,7 +399,6 @@ static const struct regmap_config fsl_pwm_regmap_config = {
 static int fsl_pwm_probe(struct platform_device *pdev)
 {
 	struct fsl_pwm_chip *fpc;
-	struct resource *res;
 	void __iomem *base;
 	int ret;
 
@@ -412,8 +411,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->soc = of_device_get_match_data(&pdev->dev);
 	fpc->chip.dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.17.1

