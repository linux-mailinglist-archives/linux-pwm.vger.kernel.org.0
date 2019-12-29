Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C9712C153
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfL2IGb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:31 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36598 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfL2IGb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:31 -0500
Received: by mail-pj1-f67.google.com with SMTP id n59so6887839pjb.1;
        Sun, 29 Dec 2019 00:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tcDW0aXcY/G/MxwpM2Ci/sP4tj8rJe2hKMdbyakIxjI=;
        b=lP3Ek33xUHHbth9me5q6mLUex5a8dg8mEKxuccWfGhU8cqf2fmgCzVh6pJqCkREdLv
         6wYlaQCiC6Typ9k3VpPn6E7s5k5FMmPfRzQPwYSyQH81f3hMDjlXels8X25fMpPzQDxv
         0BlYwydSo9J+R+tcFE1V5YApFPd3UmWDUOM/IYUfUV7frbaLlA6ANnZCy+u6eG9KQcY0
         NILqNQM8yVLHkLd95Cq4uekIt89NG7zj5jTZqLM/vfbhtX0xmNF2pUtLWWL7WU3lV/gH
         /NEHDpjcpXJbcyDCti6h/Iq99QrQpbQd5Vf0fuguebONJYSdQ99fOqu3ydK3N4POZ/7s
         6aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tcDW0aXcY/G/MxwpM2Ci/sP4tj8rJe2hKMdbyakIxjI=;
        b=tPKnljILX4R5khs7Oy+34rIlF1g4HC0KSF/JdRb3UoUtjEouKAf5HvI8nHRRGOtVYH
         nmy8EMcUORvH26klpn+qms1/zdy8Jks+E8u5H34npiD1dw9sPz+42LHseqr2adlnXbj1
         /B7M0F4/JpOEBkPZCmYXppgXt533vYA7NLyMpb381TvcCA80y2qPG+sEWsQEgbHPWyJu
         JtNPEuUQa/VUxFPX1Ka1eTn1BlCVzjKpsL3UX1Y82NV1gCE0VUHDO8/KQz5TxVJzh05e
         KKWS95ls6I1cDCjvmx7xYOgkOVncN7A6ZiD846j6TvnzD2iy6d7iEhmcu2vPr966t4fT
         rCNw==
X-Gm-Message-State: APjAAAWL6vvbP9kGCb/o1MtDS6r1p1QzfyMjF9iilJ/VpwNCZiiXXLer
        MeWj6tvxJ3m48v5Oi5athWs=
X-Google-Smtp-Source: APXvYqwCNlBbQKUL/ySdfCHC6bpgHo4q8fuG0jQjaVQkALInNO0iEWsgrT9VDjuqiaUmhZN/qUezYA==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr37812404pjb.90.1577606790432;
        Sun, 29 Dec 2019 00:06:30 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id n7sm20169871pjq.8.2019.12.29.00.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:29 -0800 (PST)
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
Subject: [PATCH 13/32] pwm: lpc32xx: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:51 +0000
Message-Id: <20191229080610.7597-13-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-lpc32xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 710d9a207d2b..6b4090436c06 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -98,7 +98,6 @@ static const struct pwm_ops lpc32xx_pwm_ops = {
 static int lpc32xx_pwm_probe(struct platform_device *pdev)
 {
 	struct lpc32xx_pwm_chip *lpc32xx;
-	struct resource *res;
 	int ret;
 	u32 val;
 
@@ -106,8 +105,7 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	if (!lpc32xx)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	lpc32xx->base = devm_ioremap_resource(&pdev->dev, res);
+	lpc32xx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc32xx->base))
 		return PTR_ERR(lpc32xx->base);
 
-- 
2.17.1

