Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3966B12C11C
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfL2IGw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:52 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38994 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfL2IGv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:51 -0500
Received: by mail-pj1-f67.google.com with SMTP id t101so6881085pjb.4;
        Sun, 29 Dec 2019 00:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ybrin7Bm43ghD4JohutI1MKUWkgtrAiHaUYHCnbL3nc=;
        b=gn2BXtUaFi/tdX1Dv0Kl80fKucwAwOVC6rPzfhtY434YtZp11KCEm0WtOZfPRQDLKv
         4d/zGvTV1a3bsBkgx0+eByWAf393IXyEXrYsBuuC6EIod+6nICrvtppd1Txm2BD9sjeT
         02se04wl2qG9EdES/0qypQAZidiOyQl6iBgaF2ADkxvZKJuLbV4HupX0ULRQtMyoYzEZ
         Ul+63P/ZIyl3/TFMpqF9GrigjSTGBvHvMos20n9olUn0HLuRB2OK93c/YdCL3TCZuBlq
         v3cXN/dMPkC9gQfiWFyhUSpQMpgynoRRTuham8wPXHm8unCGGrdewhY+LWLWcTPpIwR6
         HviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ybrin7Bm43ghD4JohutI1MKUWkgtrAiHaUYHCnbL3nc=;
        b=rf4CN0LCBkopt6vBDb+/zGqRFc+JcuqcrO9ZMVwr0NYQR1vgf+cJJT2QqBXMs7A85g
         M7sgXYkepFTTc+SBlBUkn5bAGP6xVnq1au0cuqpSXHbSBwx1rJd1cfX7syudBS7AQW7Z
         YoXOZOfnudmAr1AqXeVuI41MKo39ohI4Dbn4T5R89f4HYG2rqsLZXiZy9gHe35o+uuvy
         hfk5GZrK0/pAF9hYAF0CMqVR4rDKv+vGhp8SI+anjrpdgmYUL+YRr/fnGSkNgR5HkHGW
         Rjui2fgiinhdmsObeBK2lAkPk2EYsFVGhronlOtpPK2z3f/L5jbQqUvnsO6Vro1o8po0
         BTTA==
X-Gm-Message-State: APjAAAX/RsUgcx5QJjXs17NfuM1D4ENaHqwuHpKQFnyKk9AAIK58/rS0
        d0nJ4Ca3nxMlXgjNoSxJmqA=
X-Google-Smtp-Source: APXvYqzgIbRZSeM6NnV/+qUyWrlWhkxW/F56U+gtXAWCgPTjTFIZU7kTdkeI0S+qki+zI2ZQYb7QnA==
X-Received: by 2002:a17:902:7484:: with SMTP id h4mr59426080pll.206.1577606810385;
        Sun, 29 Dec 2019 00:06:50 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id d129sm24524981pfd.115.2019.12.29.00.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:49 -0800 (PST)
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
Subject: [PATCH 31/32] pwm: sifive: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:09 +0000
Message-Id: <20191229080610.7597-31-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-sifive.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index cc63f9baa481..cb9134d7197b 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -232,7 +232,6 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pwm_sifive_ddata *ddata;
 	struct pwm_chip *chip;
-	struct resource *res;
 	int ret;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
@@ -248,8 +247,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	chip->base = -1;
 	chip->npwm = 4;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ddata->regs = devm_ioremap_resource(dev, res);
+	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddata->regs))
 		return PTR_ERR(ddata->regs);
 
-- 
2.17.1

