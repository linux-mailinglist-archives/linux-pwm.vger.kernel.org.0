Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5612C145
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfL2IHj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:07:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38412 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfL2IGj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id f20so13505641plj.5;
        Sun, 29 Dec 2019 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pe7z29fRNe5SM3JyqTcr+ajpELEpJ4s61Kvtp+b3jfk=;
        b=E6kKDc1ccDfUno5iuV2/36t1tRGyzcoCrbrGkA48JnmLme4WYttoT2natZ0DS1wKBy
         jQlL7uYK0gxMbTMdSW/ouKjGvg6uGzW4AACMSO73e89dnkNh/b+8vCGyVE6wHArrA4qg
         rZJ9hH3uoB9wDdCAPwZl3jfrY021ZsUga0LMCTHRNs2mMJ6/g/QHoWb9fxu0jB7+xZTd
         Z/kGz/BRPgLl6OIG9cjDx3g30glFXrSoW1KmlRnOJSWs7dfGvv3J1lgYNQWKvPJMKP5w
         0LVM9WywgdkNgbxEYjhxa05BF3g9PfZ5tsAKHZrLXeRxyEx3GOnbmeNcKzu61Se8a+ib
         KWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pe7z29fRNe5SM3JyqTcr+ajpELEpJ4s61Kvtp+b3jfk=;
        b=EMuCeO0wHKcPlICYFXqT5jHXjfJKLdGou6UfyZC1WZ+oyjjPJk33qo7JiU8g7aFtL4
         vdaS8VaWRvtKtlO6XXJfjsdsX1UGkXiwSaPDhV/x29xSiyYatmPzO7DJvsyM0sNUhKTT
         UwgjTqpSC8Xk4pUGFFF+zgpBH8QmuN4V/5dlDBxwcvJ/YQsMtFOE09ygcVhVsthocIEf
         Mut/CNL46V3yP/2U3PcBsOOLDgW7rbMuIWdKPAQ5pRwxSrl51DuML18oUFuh135jW1Xh
         SBSHANpwkgcHvO+L+MphEWNpxXkb1OZ0C1fyTyevAQpv1jBcWdiJrLrlw9fD2H2Ex/7Y
         Mjkg==
X-Gm-Message-State: APjAAAVv4cx5ZFzoLrWhYt8FZgxtX3MyMUedow92O8Fk/vZIPC5AZJ8T
        HK66MPpz9u9uhbY1CExZOy4=
X-Google-Smtp-Source: APXvYqxIMYpEGxMzLdsKYBj8rpDkpOr4YQd01fkuyPBNDQ089lxGYTs+RS+KP+qyyW8xims4wb9VOQ==
X-Received: by 2002:a17:90a:5d95:: with SMTP id t21mr38920834pji.31.1577606798522;
        Sun, 29 Dec 2019 00:06:38 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id q7sm20290229pjd.3.2019.12.29.00.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:37 -0800 (PST)
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
Subject: [PATCH 20/32] pwm: imx: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:58 +0000
Message-Id: <20191229080610.7597-20-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-imx1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index f8b2c2e001a7..1a60bfd7d659 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -136,7 +136,6 @@ MODULE_DEVICE_TABLE(of, pwm_imx1_dt_ids);
 static int pwm_imx1_probe(struct platform_device *pdev)
 {
 	struct pwm_imx1_chip *imx;
-	struct resource *r;
 
 	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (!imx)
@@ -168,8 +167,7 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-- 
2.17.1

