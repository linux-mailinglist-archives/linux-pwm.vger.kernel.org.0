Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5246F12C16D
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfL2IGW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39766 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfL2IGW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so10549760plp.6;
        Sun, 29 Dec 2019 00:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nA6GTFWnPYD1qaFXEcR2M91m1jofmHZ10xgJuVtHDf4=;
        b=EoJ20ykzty4LDXb464VSekkPU78MYEIXpid7/8bd/VwMGSGiE4zgDkUKpwKxKieTds
         CTH964cbdpQG2yrkwaDcNEQ9JFz0Yblm6OekguaCnkqmF8WjH3VhQyxeWt7PUF2cQBCK
         xWNMIid/vQhbtwPTHrm56VMbV9kEnRugE0/DWNZ/w7jZIc/xIxFB4MhLkvXpRSW0ReUe
         DiwUT2BXf4mkWXxiGdj79xEVkQSL5k1TaJpc+/Ap419iCR9L3njXec/P2Npjj2RIU/Wc
         hj4Z565yL7f5pqcs0SkowL/QQAOKW2nU1ACYgMMW6NYduMKkgIR6fgjzKIanVruKQA+m
         ZtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nA6GTFWnPYD1qaFXEcR2M91m1jofmHZ10xgJuVtHDf4=;
        b=X71kt46MAu8AmxqEE2p6Z+8RcArLLItLWspbcVQ2iRrIYLDfwZVwUGCLlsLJUeh+nx
         NKRxU3kyr7LAa4yLGoT94Op/G5eeTB256Fu0lIcnsKI9xgU8diMBySTGdtjJYoo7NVWg
         4cJomW/dP7jmwjGhwM3Z3S1BlzMDH5E+KdT2pWULbpfj0SrEZ+ZhkvraJlDr//g6si0d
         tfnGbHy1muFq2Rlzt/OYBsq/CWoV7fbAOE8mnjnrA2iP4SCkzTTv237r30DuuLCmUrh+
         XaORBPLKp/+J2BIGARAG66huDY6kzL3+7NRpYd3WX4EhTot4OHDVOMSYdis73KMipOs+
         cuaQ==
X-Gm-Message-State: APjAAAXBGXzCqNzVVxBICz1Ng8dU9lXlMNbnttdsx5iYGcvjqBMfa+1o
        q+Kg3LKfHDlC+BROPlIPjiI=
X-Google-Smtp-Source: APXvYqxiuA860xAI7DlETD65hf7fsheQt96c2h3gdtB5uY98twAIIIJUm/SIgtNjjfbaqGCDo+0p5w==
X-Received: by 2002:a17:90a:974b:: with SMTP id i11mr37927812pjw.47.1577606781207;
        Sun, 29 Dec 2019 00:06:21 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id 133sm46245208pfy.14.2019.12.29.00.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:20 -0800 (PST)
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
Subject: [PATCH 05/32] pwm: ep93xx: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:43 +0000
Message-Id: <20191229080610.7597-5-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-ep93xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 4bab73073ad7..c9fc6f223640 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -169,15 +169,13 @@ static const struct pwm_ops ep93xx_pwm_ops = {
 static int ep93xx_pwm_probe(struct platform_device *pdev)
 {
 	struct ep93xx_pwm *ep93xx_pwm;
-	struct resource *res;
 	int ret;
 
 	ep93xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*ep93xx_pwm), GFP_KERNEL);
 	if (!ep93xx_pwm)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ep93xx_pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	ep93xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep93xx_pwm->base))
 		return PTR_ERR(ep93xx_pwm->base);
 
-- 
2.17.1

