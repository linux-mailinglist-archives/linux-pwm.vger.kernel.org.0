Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A996712C111
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfL2IGc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36600 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfL2IGc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:32 -0500
Received: by mail-pj1-f68.google.com with SMTP id n59so6887854pjb.1;
        Sun, 29 Dec 2019 00:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VEfrDAiEU6puBWVOShtptTtgoJrswidYAzst42qjsaY=;
        b=Qsr3Kkvd2v3PEQksW5trlFa57gOt31oanuDX8xjzJnSkDTsvRTdAhKl4OfBzNezOMv
         Ow9aPhfGSSomPOY0Jup87/Ma/c6mHDM7yC4BSoWseZ2UiyDALgLiR0tiDw3SirV4R0W/
         jBu21GGrggpBKnKRm+d/8oBUzIF4HxYHoceWxB29sW5S/XVLu25/Zhclz2mRCBIdVNOs
         u0vnDLIeftmYJaO5I+itHESPbjGZO+WpTgXO2jlMdp+LOwPs8xclGL9UWelx7pgK/huh
         z3OZuXuW43OrJnf1lVt4h6YMJIT0IcyLc3s9FkpUhkGSRoLPYRaTka6LI91scoTk4PVE
         Dmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VEfrDAiEU6puBWVOShtptTtgoJrswidYAzst42qjsaY=;
        b=uekNV+abRDvUvZCTVfKyIgnhkLKZ1lvSG+2/6hS2EXIAUyn7tfkj0xCNMsOqFUJw+2
         MmWYjMx/NxonDmR4O7ogMFwazxEFsgG+lU+UHISigp/5kgEWfQKSWq/qBTJbsbmaUNlr
         heaGkupN6Y05zRJtfTFfu0jWC32+kV9bnRkEn7nYfIlvXm47CH6tH/G4NTfwUkVQbK6E
         cxQHlkSVi9VjcsEak4hsbHx8vbuylmaKz1a0zHlcNlT9WckKlTDzSGUxK9goLECB7Z48
         U6hgdnKmiv4asHpj0t1a4OIa3eNmDJjtAdWnPiTJBuAD3ZD8PTtYpMzMgp4LOe6OgkQC
         Xs+w==
X-Gm-Message-State: APjAAAXR0TcD5cYKFHFhy/WJdc4ClqBXXHwXL/I+mJR8zflux44hErq7
        ovZIWOY80QEY6fb8u+5Xs8k=
X-Google-Smtp-Source: APXvYqyJegZ4rhA8xxafUEqt+eJi/AxqJgGXb+jAX6THH+3qtTSC1H1OzKTzXAkU221EAUpiMT0Rcw==
X-Received: by 2002:a17:902:6b8a:: with SMTP id p10mr47058988plk.47.1577606791415;
        Sun, 29 Dec 2019 00:06:31 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id g9sm47637627pfm.150.2019.12.29.00.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:31 -0800 (PST)
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
Subject: [PATCH 14/32] pwm: meson: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:52 +0000
Message-Id: <20191229080610.7597-14-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-meson.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 6245bbdb6e6c..62fc79092038 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -537,15 +537,13 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 static int meson_pwm_probe(struct platform_device *pdev)
 {
 	struct meson_pwm *meson;
-	struct resource *regs;
 	int err;
 
 	meson = devm_kzalloc(&pdev->dev, sizeof(*meson), GFP_KERNEL);
 	if (!meson)
 		return -ENOMEM;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	meson->base = devm_ioremap_resource(&pdev->dev, regs);
+	meson->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(meson->base))
 		return PTR_ERR(meson->base);
 
-- 
2.17.1

