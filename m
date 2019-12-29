Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1D12C123
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfL2IHG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:07:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37160 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfL2IGw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so13500631plz.4;
        Sun, 29 Dec 2019 00:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47el5Owup02YUbMebGEaPI3XvpkPXD+FFtHlPrEyxFA=;
        b=MIXP/grZx6mWbEPfFXoqRs3JDVjT04SNhSSWru67t/m2eIdF2cqFP0yxHw3B0ADWzA
         Mj3R/G2Hv0hE88wKCIVgrmJUyZU1RwbGy8FRZe4fVCKonv6vI4DRiJPdpxqydIsjM3Ll
         MCKmGePOPt3QMQPqZx5luh3T2jxYbH9ahKrCYeSs4sO6/eCjeQcZxqD6zWnTnfkm1VFm
         4VeDCHj74to92KPKBIPeT1p5Tr6sWXUDo8dBqmrioiHBkpdcY169L96miePLUYBE4YgA
         TCVBtRbuC058Y/EY2qJFGEXH571X/xpG8vWrH0jA9cQoeT147Yy9P95L7fSgzdeip8Gu
         i2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47el5Owup02YUbMebGEaPI3XvpkPXD+FFtHlPrEyxFA=;
        b=YTchNnC5dRazcfYwZQnWEGE/HSMM8bcTquPkOgZrgZwHK+okdqPWctUgpJn3pii7d+
         20fUId15gILbjYR3Hy36hTPyCEVhuHCRbCwaO+ByHQt3jVCoeyLj9yMTYqCffZjBcR8d
         MlDSVDYyL8WJIo7vM+x1PmT/gb5ssj5eCIAqCgpXkefGkQXhkXosxy0PHa6h0GHUWfZQ
         V4Fxg2ESC4E8g1BDOaM6EpTE3Ld2GKf9ygNf7aN4Do0v6El/2eFYmlKRiCPZihi/lzCw
         2EHGq34gMzXfQ5OBmgj16zW1uYbPNujpYFSiNzxpiGcviM0OgyjouxdQermPdDMluymv
         JMOQ==
X-Gm-Message-State: APjAAAUf2x+RHVbVPZ2d53ITY4njq6E68bAAt+jf8RNne/HzmGy5fJQZ
        LM/6NRAl5i0rbds7NWk4caI=
X-Google-Smtp-Source: APXvYqx0/m9vcRiiE8VyrTjc7rP0/kHdHXJwPeS5Tef1XK44wL7jcNW0xwmNSTXH2Pe6rwcBvhW0LA==
X-Received: by 2002:a17:90a:3763:: with SMTP id u90mr38493406pjb.107.1577606811634;
        Sun, 29 Dec 2019 00:06:51 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id a26sm37945389pfo.27.2019.12.29.00.06.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:51 -0800 (PST)
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
Subject: [PATCH 32/32] pwm: atmel: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:10 +0000
Message-Id: <20191229080610.7597-32-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-atmel.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 9ba733467e26..86cc5ccaa46c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -340,7 +340,6 @@ MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm;
-	struct resource *res;
 	int ret;
 
 	atmel_pwm = devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
@@ -351,8 +350,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->data = of_device_get_match_data(&pdev->dev);
 	atmel_pwm->updated_pwms = 0;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	atmel_pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	atmel_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(atmel_pwm->base))
 		return PTR_ERR(atmel_pwm->base);
 
-- 
2.17.1

