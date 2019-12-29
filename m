Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3303912C14E
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfL2IGY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44388 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfL2IGX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:23 -0500
Received: by mail-pl1-f194.google.com with SMTP id az3so13485500plb.11;
        Sun, 29 Dec 2019 00:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kJfVG4855LhBX7Jw+HB9muJtnt8I3TC3RRe+0TTxvkY=;
        b=umiR4bpK+hFagVx6dNWyqvf2HnQxVYRc+CfETrcB5LcBwr69Xc0488XfW3mvNQeajv
         V5+uC4mZ/LETljSPKS5THFfFyESAS8zf6M1X2lnDCW4QT4CkCM1ZGloSk4CrGSjvBTnp
         jiz/7OHdTgY37G3qoHVp/zvxj3OXZFkPODp67sRLepgYxr6tWsxHFyy1+z8SZ77++Ar0
         jKe+fwWd2T4d08gwApoIv7abrDv9e0P9nBToofeg22m/XN9kaOeMe1dq8IJMMP4vho3H
         UVjOCwXyxCV5JHqac1suFyczet/TSosYz1Lpx1kuo0HbP933G9fXZF3Fb0XVZBYku5HG
         A7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kJfVG4855LhBX7Jw+HB9muJtnt8I3TC3RRe+0TTxvkY=;
        b=Q2onF2/fKeTASz77223ZSwCIxiNyMB63AZBVlacs7IjTsVOHg06Qz9rAVUZrq/2Zhv
         48KxhtkyPhJv0fasfuB8Sz1GjXgL+5KS/cebwXLPLVGi5ODRUWaNbYWQp0YazD7hxfQe
         G/LnX4tHEYsnz/2AOoUUJGsEa+MDRq9NbJ0R1k9YP8KUzFv1IDHouTHQn6AzX7FkNwPY
         ciBU8RzU6Ob8DAn7Nc8t8uHqx5NdiBFNuv3T1STMjoBXUIDRlklYR0x2MszBR2e2xn3+
         MyO9zs/u9Dx+qYtMiMCN0MibtaoLOdZsHZ9FuvJTDUKeEh8v4ZO7rmlQseuhkwbamYQR
         15hw==
X-Gm-Message-State: APjAAAXH1Mm379hN4XwBPzLm9tWJcJJEifvCYAsi0/kMBPX9ESrBmErm
        W+8W1R/SPIPaPwvWBb2aaaM=
X-Google-Smtp-Source: APXvYqyLokgFtS6K5K5ahwNAvTHcYw1xLsZBJ3HO5Dtzo8qyrhcyo5S3agmSaWbAPSTxojar7WTBpA==
X-Received: by 2002:a17:902:fe98:: with SMTP id x24mr62258889plm.155.1577606782293;
        Sun, 29 Dec 2019 00:06:22 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id o10sm42988345pgq.68.2019.12.29.00.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:21 -0800 (PST)
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
Subject: [PATCH 06/32] pwm: tegra: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:44 +0000
Message-Id: <20191229080610.7597-6-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-tegra.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index aa12fb3ed92e..7f77a93eb4b5 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -170,7 +170,6 @@ static const struct pwm_ops tegra_pwm_ops = {
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
 	struct tegra_pwm_chip *pwm;
-	struct resource *r;
 	int ret;
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
@@ -180,8 +179,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	pwm->soc = of_device_get_match_data(&pdev->dev);
 	pwm->dev = &pdev->dev;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm->regs = devm_ioremap_resource(&pdev->dev, r);
+	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm->regs))
 		return PTR_ERR(pwm->regs);
 
-- 
2.17.1

