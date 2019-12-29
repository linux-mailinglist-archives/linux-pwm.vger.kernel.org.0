Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C5112C131
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfL2IGv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39785 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfL2IGu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so10549993plp.6;
        Sun, 29 Dec 2019 00:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CJr4HqPkZ3pPTSYRcWOsbHXVxGnqGh2WnBscj80axwQ=;
        b=Bssl8EsNZrOgZVwJDooD7AhI5/dzQdq+ZTBUU2dvaMZSgYTCPJU3Yz/3DLrUeaKs+G
         +6FliSf51Fd2rj9rX9QwjoIItp4EfY7B3nNLhzaz+KmaT6TwRRPzv5xkeMHNkUhF/RAw
         To0N2ay9kdtzm3eGOklyBFbKtIHYz4pox4UduOryF4FiXnNUjORl27obUdurhX4oF6sf
         7Q6JnRHAdm9g4PdcQQR4yjSLoJOxTQuCvjPo6ofwb6ykDGj+5X+H5OXKv5j0zAehUEYd
         WaGLC2L4XSGjjLBLj9C75l10/Jk6/z+MDRhSUiQMn54Lg8Duz4tsplT4Ppk8xHjFyLFX
         tIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CJr4HqPkZ3pPTSYRcWOsbHXVxGnqGh2WnBscj80axwQ=;
        b=J5cevHZYB2sueKZx2pxeN2FD6KsRi2ZJwgu46QUk3kfXlJUVef4zdR609LdVbUUO2C
         PFePOFRYTTjl+W8aodAdDH0oOnu/uYYzW+27GIEbpnYTYu7yNwnfAs6pmpeuaRojGv1R
         +/ysPLH4Frd5MesPxMN06ZbOBayUDQe+jZyebjX/e11SeEbC0snBeakfjKcuFRtxUZLU
         tQ0LiIgo5bmNMnC9gt5NfTn15LTte7Mt76TyKjS9uyKFeNsIkBeTrgZSRt2zr6v/0RcB
         NVKzBhd3gxMNoriwwHWOEE7FJRvvEVzPrS+31vMPG7G/PMlNiwSBrj+4wWtZvkPH1PSc
         WQbg==
X-Gm-Message-State: APjAAAW4mHgUo8Z4fYXPbMZz7xrrmPm2bvR+pT/bQT7y4SS4WSFnW59/
        od2Jue3cp69OY0S+8WrlfQc=
X-Google-Smtp-Source: APXvYqwAyE3gieezb7OcD6zcyUg+EE5n2ZTOPezezbkBULlCQmyLEcIJI5oqgk7T4KhbBdJCruCC+w==
X-Received: by 2002:a17:90a:930f:: with SMTP id p15mr38599124pjo.2.1577606809372;
        Sun, 29 Dec 2019 00:06:49 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id s1sm42817742pgv.87.2019.12.29.00.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:48 -0800 (PST)
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
Subject: [PATCH 30/32] pwm: hibvt: do some cleanup
Date:   Sun, 29 Dec 2019 08:06:08 +0000
Message-Id: <20191229080610.7597-30-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229080610.7597-1-tiny.windzz@gmail.com>
References: <20191229080610.7597-1-tiny.windzz@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.
'i' and 'ret' are variables of the same type and there is no
need to use two lines.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index ad205fdad372..a1900d0a872e 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -190,9 +190,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
 	struct hibvt_pwm_chip *pwm_chip;
-	struct resource *res;
-	int ret;
-	int i;
+	int ret, i;
 
 	pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
 	if (pwm_chip == NULL)
@@ -213,8 +211,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.of_pwm_n_cells = 3;
 	pwm_chip->soc = soc;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm_chip->base = devm_ioremap_resource(&pdev->dev, res);
+	pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm_chip->base))
 		return PTR_ERR(pwm_chip->base);
 
-- 
2.17.1

