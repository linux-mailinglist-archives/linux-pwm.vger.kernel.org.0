Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D5412C12F
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfL2IGt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40795 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfL2IGs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so16605837pgt.7;
        Sun, 29 Dec 2019 00:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yOZESLDf3NMQl2AQzpvlA7k5qk3OCi4YGKummQOrFs8=;
        b=LeTIqEBW8Zs2cVWvHu0MnAMgs+gLcpWeH0KGWJgyv0M4pne784SNrN22qVKM9VxLGg
         VkIgrhxEQ30CzrwesG7m0kyxQNTtuJIREZP5mbsuT7kI006XW457m7zpP8wcDJdtf5wW
         rG7IArpjXRiHApgleitFu/5xtZnNb60rGHKkteyiSyxzEIOgHYKziuHHCk9148gX35M7
         ZtYqBDU5ew/TJi2rPABaXhvcIm1UZ5jSuJkS5NlSH35OEiGzFXbzdok6V3FbwW8o4qn1
         UQJCAjR5+JG3n7x1sg+c1vg1x6XfsOhyp98ZNaT0SlitZqjGC6W+QrI2xtcqSAPOGZB4
         nCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yOZESLDf3NMQl2AQzpvlA7k5qk3OCi4YGKummQOrFs8=;
        b=Pup39pjQjEB9jFLs+xeDagtbutBl3Q21Z/sxtaccEUG/odDtLN8EtfrVGAxQVABKQi
         YLp1ecY6AluhXxlq/0sedp0LoqTvXGXJUPS6issj46EfgMt/dh3z/TUFUMagzqPnLEQW
         NDa2z4x/qLNETOE9HBcKJpJzSDmZrEqfPJkOnC9G3ggU1oyXjc2feBXpf11ikePaCIoT
         F3kKoTE8aqQ3GnbLHSlUx0FVZFm4Mjrl9ToruwdJKVwxvP3AaHDXknPtYuHYlWKI+PDt
         bpQ1sMWM3TK7+JWRbkDvdPrVLZZuZueH+OPF812X4QkXgTFyjIVC0TCzu+gYGuLajlUy
         CKRQ==
X-Gm-Message-State: APjAAAVRPtV2VnVS5REmvstbx9TW4pFiVr66Lb1vx/I6UjcMlz8luJ68
        T3eJ1qhOUGTsLUde95J7GFE=
X-Google-Smtp-Source: APXvYqy3I9nbiiPsy5usJiGTqqOxXYQdFH9OZhOVBLvhOhgfJN5S0H2k5R3G4H5O1kb/UplcTjBTuA==
X-Received: by 2002:aa7:82c9:: with SMTP id f9mr65137704pfn.168.1577606807243;
        Sun, 29 Dec 2019 00:06:47 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id a69sm45429777pfa.129.2019.12.29.00.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:46 -0800 (PST)
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
Subject: [PATCH 28/32] pwm: img: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:06 +0000
Message-Id: <20191229080610.7597-28-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-img.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index c9e57bd109fb..e9b25440b808 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -238,7 +238,6 @@ static int img_pwm_probe(struct platform_device *pdev)
 	int ret;
 	u64 val;
 	unsigned long clk_rate;
-	struct resource *res;
 	struct img_pwm_chip *pwm;
 	const struct of_device_id *of_dev_id;
 
@@ -248,8 +247,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 
 	pwm->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm->base))
 		return PTR_ERR(pwm->base);
 
-- 
2.17.1

