Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4761712C11A
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfL2IGt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:49 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36611 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfL2IGt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:49 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so6887980pjb.1;
        Sun, 29 Dec 2019 00:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pl5/ypnEUmA451pFNc43UKrN7kyhgo1Ved2+kQ4+IY0=;
        b=cWon9UkMcCmmLeOLXR9B0CAkyVOBUp7OQ8MfWjO30F2+Xl1jtlZJEok57OqGinqc+i
         8KvJ9vEKlxQQXcsU4kH30zYvwdvAcS9ZWNJ8ibH7jZWt/G1am6NNRdsywq8h701cqRT5
         3yTv8jSX05LlV4dsDijXUetlUobD2j53u7o32Mp3c5LJiuuc7xVopVwFbIYKNXE5RahS
         71G/5+S/sXJHca09kq3sTPofi0XZLZSVBR1/nP9R0E75WYSe4C30bBtoxKydZg1f2bFQ
         QecEg+2Ff9ttpTxuRny4cuWo3Yua+stntPd8qR89Fs8JdTrxDudDX12CoRi4yZSMtMHL
         Va0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pl5/ypnEUmA451pFNc43UKrN7kyhgo1Ved2+kQ4+IY0=;
        b=K2wVHX25DFNfOy6Vs4CQi1LyxRblhlNs/+GhzUlfK9He6Zk9ECJgAvxUeSIwA6YlOW
         QUQL+OfPO/6/AXqicvodgHE+z/ATQZSwoJt670udSl/Rc7vm3vGh95JXk1VVXO/iWJQx
         FUFgKe1GGuedFUrgww2dvC7xKAxHH9GuK5YRwrwCtNar+mdQIeeQjF7eEBi8BkRgJYh7
         1fStpbY2XisQO8ACqEMOUBqvX84BVZUJ3X68uJE6O7AvxUttPXZPjwYWEeqhBGq+YjKM
         sHl4ikkV1Z5I9wMFZfosOm9RwlAWfawC4EbQsdTvNWIQfCVwo9Qz5PGSOUwsI4u5Eb6u
         H3mA==
X-Gm-Message-State: APjAAAWX/QRlX9ftnfqRc6gzmYOb8498ZrV+oi2KyyE5P4lmeKiyHJTK
        dlP3joR4XKo6ll2IpDIHxSc=
X-Google-Smtp-Source: APXvYqwRk8Zu1KG7W120dptdC4raXyTAI77dRTGemuH4wbDX11kc28Uj499JtLjOduAOgIaf5Pw1+w==
X-Received: by 2002:a17:90a:21a7:: with SMTP id q36mr37784222pjc.140.1577606808394;
        Sun, 29 Dec 2019 00:06:48 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id m6sm19962023pjv.23.2019.12.29.00.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:47 -0800 (PST)
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
Subject: [PATCH 29/32] pwm: lpc18xx-sct: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:07 +0000
Message-Id: <20191229080610.7597-29-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-lpc18xx-sct.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 5ff11145c1a3..dc5133bec3e7 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -325,7 +325,6 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm;
 	struct pwm_device *pwm;
-	struct resource *res;
 	int ret, i;
 	u64 val;
 
@@ -336,8 +335,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 
 	lpc18xx_pwm->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	lpc18xx_pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	lpc18xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc18xx_pwm->base))
 		return PTR_ERR(lpc18xx_pwm->base);
 
-- 
2.17.1

