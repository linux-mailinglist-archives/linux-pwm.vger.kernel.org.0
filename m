Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5112C116
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfL2IGn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39820 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfL2IGn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so16614032pga.6;
        Sun, 29 Dec 2019 00:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SoWTkdw08fKNkZI7zecO4kgB8x71qLQgBx6zKThBhe0=;
        b=dFCyuXUEKl8LsO/sXPvZkU+TvC3B0fKFaEg+Xuhq2RsKStgue7QzNd3+v2m1LIj1Q6
         GyT8nsgIoiS5paCLvOprfNHhJJf8ILKkc1PsH61+Yfw00WIDxzhdQUKm1/xl2DPGONBG
         rQGX+aJSInwpHrshCpyLqFzdlKYyCkP5ur+TESDgxTKjfpjCiHwLZsVxeB6SnhQfzXTW
         n0cB7pAoxLs+cG1rdlAMhZ0U7ZHPNS0hdpS7eppQErPMN22+CyxKdZJaG4dMb4xncATj
         ROSFyclMBn6fqhjWus5OZnzNVho2v4s+xwQhpjokIZlG4sZdW6hTJha2E/9YXEVem8Kf
         LMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SoWTkdw08fKNkZI7zecO4kgB8x71qLQgBx6zKThBhe0=;
        b=A/3C3AWcLr/PQjdsPgCWRhXiWs24y+6yvpUAh9UvNxte3lfJUJdJBUtkKkyoF+2gVk
         ZwYtgjAWoxnrGr+ebqOrjQm2K8hXNVHauWkeUVrT9VmJq7CsUoVgfj1QEGyGkQ2n/E72
         /2geiUPcBRZztnnNwvAxKAJHQG5C2cLFxD4D9GD6LiQ6c9//mFVbshwZmn4o99lMALth
         QrTNPFEB9EUh+oRFuQj2X5vztNunfyLkzCYEYw7OqDC3vgeiuNTyALFi9YywnjDn+GOb
         t6JC1NIyGRBTOeLuEZMrt2hkiW85h2UjZrBJD1WOsNQcHSG8ih1WozsXqRTjuBAHNG0u
         V9fg==
X-Gm-Message-State: APjAAAU5pnhhHvPoHuUbpGWnih2aqivzUWGuZoIhQNHFB6gE+6+Og04I
        6klP0FyQsALTN2rmw2fT0d0=
X-Google-Smtp-Source: APXvYqxFPMe29+XLuDvoRw+OYUFI9Ar/T8F4eKcB2m7F1vCONUQP69zaPfgygh+KUiIyWo1JSp3mCA==
X-Received: by 2002:a63:6507:: with SMTP id z7mr66588518pgb.322.1577606802890;
        Sun, 29 Dec 2019 00:06:42 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id s1sm42817428pgv.87.2019.12.29.00.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:42 -0800 (PST)
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
Subject: [PATCH 24/32] pwm: vt8500: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:02 +0000
Message-Id: <20191229080610.7597-24-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-vt8500.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 11d45e56a923..6e36851a22bb 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -193,7 +193,6 @@ MODULE_DEVICE_TABLE(of, vt8500_pwm_dt_ids);
 static int vt8500_pwm_probe(struct platform_device *pdev)
 {
 	struct vt8500_chip *chip;
-	struct resource *r;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
@@ -219,8 +218,7 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->clk);
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	chip->base = devm_ioremap_resource(&pdev->dev, r);
+	chip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-- 
2.17.1

