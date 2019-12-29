Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F017112C167
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfL2IIF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:08:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40511 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfL2IG1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so10760771plr.7;
        Sun, 29 Dec 2019 00:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r7yBzrky9isIDkwNYOWcYiIFvp7DVOIxh9G5y1D9XBQ=;
        b=usDW8hFUshmn8eVuGWMqg4B7C5LZWw/Wg2QrmoaVjXbM3JBFZmrOz+FqgQWJq5+t7I
         YaPOcvdt/Rc3MbjJkx99C+FtSfajrWtGzCd/3gbzr0KZp6KvpKNvprnBd4HU6xgN7bT1
         5SCxjsdAzmnCsn+WiD17WX6ysc8TcTre0+AFmaPbc0LoD94t8RCUm3HjhLI+BrMZVIpH
         whp5b7QAyhA1W8kNSbSqEOufLVVU8fVlpOP/zwpOiW1dW47fAxkbNwjchxDAhzTlpxnH
         fkdeALLLaMn6u4k7kzJ50g2XIIG8E965SJ8uIu0lNHDc6fV045vrCjEaWXgnanmHJJZY
         TeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r7yBzrky9isIDkwNYOWcYiIFvp7DVOIxh9G5y1D9XBQ=;
        b=BP/dVEuaqDKL6QOR0DdnTAHkOnv/XK2PzUNlzJd8m24QQPKJXJ9Fvcb3WFhPzWNIS6
         FL/Jv8m4QUT/DKJSeGQ5pWAvuhQCVviDt5YBMBGyAXBGxcqj0HRzvekZC8/gjGONsTxc
         ulpmufR9nr5zhnstFgZC3hZB/MJMfhZLVzxyqsyq+NNV7IdyKYJx90+LXdaCQV00TdkI
         jErXWN0ASq7H1zUeTbmMrP6btgzRKsvZ3lbetJJbCxfdpyRDBwC5jU07DB9t7QgwNdhT
         zvRcL1DyZMxwVtg1TH2p2iAFOIMSDg2F/fVtlH1gBmG/7bmw1qg3/1vEc4b17hSe1hrT
         XG0Q==
X-Gm-Message-State: APjAAAVsOxpZOgiPNEN/d4lUbW1+UIqUEzS5mIcvWJHQS0x/e+1or3GX
        +kCDROomy8sXY0vG3W/TrJ4=
X-Google-Smtp-Source: APXvYqzv0No0diEA1DoLx1b6KestE0Bu3q6K4jZXDVxUtmPpun5145x0dvw4VMRReC+BmBSNqxiP8g==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr59572014pll.341.1577606786514;
        Sun, 29 Dec 2019 00:06:26 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id r6sm46824501pfh.91.2019.12.29.00.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:26 -0800 (PST)
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
Subject: [PATCH 10/32] pwm: zx: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:48 +0000
Message-Id: <20191229080610.7597-10-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-zx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
index e2c21cc34a96..0f5e8919b034 100644
--- a/drivers/pwm/pwm-zx.c
+++ b/drivers/pwm/pwm-zx.c
@@ -196,7 +196,6 @@ static const struct pwm_ops zx_pwm_ops = {
 static int zx_pwm_probe(struct platform_device *pdev)
 {
 	struct zx_pwm_chip *zpc;
-	struct resource *res;
 	unsigned int i;
 	int ret;
 
@@ -204,8 +203,7 @@ static int zx_pwm_probe(struct platform_device *pdev)
 	if (!zpc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	zpc->base = devm_ioremap_resource(&pdev->dev, res);
+	zpc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(zpc->base))
 		return PTR_ERR(zpc->base);
 
-- 
2.17.1

