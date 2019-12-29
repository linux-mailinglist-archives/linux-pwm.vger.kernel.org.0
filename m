Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 188BD12C163
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfL2IIA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:08:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34336 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfL2IG2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so10032692pfc.1;
        Sun, 29 Dec 2019 00:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9aror3WMc9TnPqrqaSDsSX8TFSQVY2wHQIlltl6fZmU=;
        b=vYtyJ2VDK+91ZMjApOjKh+6624NckEqfqF7Cts/XYXdr9hOriX2dlilzKkqavU6LFa
         yaYIvku9FW1ht4DiTC0KYV//chMEZZ7OA1obzPcm6FlzdInl+PVLLGxbxMisiflWvukv
         xiEOh6HjKhscZJADjkPAS8WsWRZ+WtjsA++MnyCVMMqKd/P7mU7US2m3+BroLpO+Oz0Q
         WH/IwBOH4MJJGU7S0VWdJwfaGdAdJkWfJUeWYzBCp+w0jITHLm7DVN/btgV4iIdwlYUA
         WjBvTiE7/4E32MhAoTuSJiAyYczvMOqW9DvnPhUwDDF6Es7TXITgTjZJUgPKQe9PVPDC
         tC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9aror3WMc9TnPqrqaSDsSX8TFSQVY2wHQIlltl6fZmU=;
        b=kH/d/ZkD9CsCjAduZKBxHnqcS/vnwUS9Qyasfk7qwS8JmHc1hsiXUwnsvl04uJevAB
         4qE1qPClzLbKdxN75E2KPWXU11rqZAntKGiIwwFXgG0ZyoSgCnYRWYLZsnfHcV1P1S4s
         eWKnIGEndFodHZABPlzUYF+rIGmdgJHvmrFWmWl2PYeqVvfw1sY2NYfqp+qLaqbaq7ut
         O3DdrBSRmQsr0r4NojdsZl3Km1/0juhhUs5pW7MG5Te5Ecz1tTrxCz+H4MaK/xiYRIxE
         ztq+e61eFWqQk1NwU35p9W8CrgGz3xckyLNp4UCfXfPXzs5dk53ScfsXNjFQWRMVbmUd
         Lbdg==
X-Gm-Message-State: APjAAAXQgKYb/EsAKvdzRxIFT6o5n9xakpVRLfNMOS7c/xlm4PXHM7j2
        P8k6lfGXGGe9guMiYWVWAg0=
X-Google-Smtp-Source: APXvYqx5w3rpNGF6e/LmsI5rm8FSKu6lK294KHs3eFdgxgzHOley+p/ZQCNB4Y8ISGTJXBB3agSB0A==
X-Received: by 2002:a62:2cc1:: with SMTP id s184mr64663678pfs.111.1577606787693;
        Sun, 29 Dec 2019 00:06:27 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id c2sm19899049pjq.27.2019.12.29.00.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:27 -0800 (PST)
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
Subject: [PATCH 11/32] pwm: spear: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:49 +0000
Message-Id: <20191229080610.7597-11-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-spear.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index 6c6b44fd3f43..f63b54aae1b4 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -174,7 +174,6 @@ static int spear_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct spear_pwm_chip *pc;
-	struct resource *r;
 	int ret;
 	u32 val;
 
@@ -182,8 +181,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pc->mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-- 
2.17.1

