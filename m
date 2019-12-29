Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4125A12C14C
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfL2IGY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:24 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38978 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfL2IGY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:24 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so6880865pjb.4;
        Sun, 29 Dec 2019 00:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ANOl3CnPFLyB6riFOKnyBL3T9PtdCr1lGKXikea0YcI=;
        b=dxj3V1IisuDpq2NL5Q6A8NOvQgKXCeunf/9Z/eimC99L8bNK9plw1/sS7HNjHNf+wF
         SfErrsxT1W9JLW5PBYinKjKs7zadepUCWoomPrpTxJFyuSfA3Lw3e72l8FeRCLk8R/ho
         efGwN01DWTe8/K/mFblhsZo8Wm8pU2kGZVBDlD6uyfUF8hrtIiBTrcK/uR2wlxNrT/dL
         fjDYf647oMz3uNYJHyHdbdA94GeFS7ENvCUnjDKSepsLBdGEijoPzNTGUnN03mAXBOq4
         vFN3vRczWJwlZ36qw1+X172TkQT0iP4TPYja+ni8K6yKezKzoqShxtN2bKRf8B/RSiHy
         BaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ANOl3CnPFLyB6riFOKnyBL3T9PtdCr1lGKXikea0YcI=;
        b=oPTpGnaTraU4FwXbDuoe/NZyXj5b+DAZ3vEeCWtM+IvqMFp7hoDgFNdH/bI4KQmUma
         WdaLBfeT0SN74xahqFccAZyl6eZfaYVz/WVqtyDnKtLR5ZuSpyGWY3P2oC0TibzOf/MB
         +q/MqYXAdvPkYlKFiSrgXaGvRPh7ywERIoNvEooX5H2vvvB48ciSOEb+B6i74pfHH4ug
         0t4dJ+Jgwj9k+9rWSi9YzC+K2bQ3LgY/PEyS791LLjjnp+e+1P0E+u6c+L0hb71gYxF+
         acPWdemIZNFehRhH0/OeirrRCX4qG8fkFjn9friz1PDC3pbgWuAh5zqSWBvaXo6oTgCH
         YetQ==
X-Gm-Message-State: APjAAAWvhhNXuZJDRn2TqOvFt/LYUwHkSV+4aW4Fu6hhx1RK9hLxZY9t
        tKMMn2v4j8Z8F6C/b1zZoR4=
X-Google-Smtp-Source: APXvYqzZqQph6OcOb8yEENrkWM/eD0nkMWTrwwYH2jNC+yCIcGe4z4tadg45LLsnTqBcHb5E6WeHXw==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr37811661pjb.90.1577606783376;
        Sun, 29 Dec 2019 00:06:23 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id q21sm45775431pff.105.2019.12.29.00.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:22 -0800 (PST)
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
Subject: [PATCH 07/32] pwm: mediatek: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:45 +0000
Message-Id: <20191229080610.7597-7-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-mediatek.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index b94e0d09c300..e4a715d3860c 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -207,7 +207,6 @@ static const struct pwm_ops pwm_mediatek_ops = {
 static int pwm_mediatek_probe(struct platform_device *pdev)
 {
 	struct pwm_mediatek_chip *pc;
-	struct resource *res;
 	unsigned int i;
 	int ret;
 
@@ -217,8 +216,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 
 	pc->soc = of_device_get_match_data(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pc->regs = devm_ioremap_resource(&pdev->dev, res);
+	pc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-- 
2.17.1

