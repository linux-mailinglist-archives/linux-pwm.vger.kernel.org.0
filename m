Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9720012C151
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfL2IG1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42746 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfL2IG0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so13497115plk.9;
        Sun, 29 Dec 2019 00:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ixbpgZkfNGAKCOr0lEPoSYVoWXPtjLRNZNzpPO1U1MA=;
        b=b9hb0mvrVhTd0TFON/cY4jJeydT/P7lXvGuK137ZrT3sGB72vyWzVXVjaECXZs2pIw
         WPY449C9wwvFqPrG3Qa1ezCsPXXPFs2RmsgxU9ZntgkrPMrbqLvDOGMtRJJxYxOyvsra
         VV+UBrDbyqvaGIwi1XxasEEnq5hYltcEl3EojwVF8PP1GC+vIftFjqW/gALodDDdVKbp
         3aOvC8ETRdUlTQNbSQi9POQ+g4SE8mMEdOf4DbCWK4jWrEjpYPl93PF7r616xrMlvR/Q
         VmI9M4VbsPF3TG2zRzy3OSA/paeHh1zowJrP4V0XERdgK6UkAKR8tLLhfLuOd52S53/x
         XN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ixbpgZkfNGAKCOr0lEPoSYVoWXPtjLRNZNzpPO1U1MA=;
        b=lPH9MsE/geMGpNJ9HnHrBbA5cg/j+pT75gNdmrxJHow1u12RCRD1Rzsm2/iSk1/OPb
         AE9fnkr5Osk2+DE76TyUHiVYINSf/XCM8npPZ/BHEMcxDSKq7iHdg0A6t87n/9Xpxfu9
         BZlCLyw+6A7MJNwPFR7bN7NWN9dCMQkf3K4TzSao/SbhRZ0897Fgvg3UFikuVjzVHMnL
         AyGI/pZuIeNhGpLcP3Bci6mT8oyEtEVsw1OjK+h1e6ify5nW1orbMO/OrLxudaXPGrBO
         1OPuiaglv+XxjhgbN5U8eLf7ffmvyZxv1JYoF2XE6X09NNiEBODCxEVh0Oddes4cwqVi
         hKxg==
X-Gm-Message-State: APjAAAXyfmiU1Zyi/ksVsnfD1sqdnAPl9K/CN4lwkKRt4r9QXIWg0nai
        YufSkU4X5Pi75GRAzti3uNI=
X-Google-Smtp-Source: APXvYqyDkPiBHYfCdoCXLDgoh2qk/Ypift8UAhqFU0bdxV2l2xmLFYvYYcF0WaO5Y76DoV6YInaAnw==
X-Received: by 2002:a17:902:d694:: with SMTP id v20mr22004925ply.127.1577606785450;
        Sun, 29 Dec 2019 00:06:25 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id k1sm43874410pgk.90.2019.12.29.00.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:25 -0800 (PST)
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
Subject: [PATCH 09/32] pwm: pxa: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:47 +0000
Message-Id: <20191229080610.7597-9-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-pxa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index a2a0912c2dcd..d06cf60e6575 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -166,7 +166,6 @@ static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct pxa_pwm_chip *pwm;
-	struct resource *r;
 	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_OF) && id == NULL)
@@ -193,8 +192,7 @@ static int pwm_probe(struct platform_device *pdev)
 		pwm->chip.of_pwm_n_cells = 1;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm->mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	pwm->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm->mmio_base))
 		return PTR_ERR(pwm->mmio_base);
 
-- 
2.17.1

