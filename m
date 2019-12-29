Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDC412C156
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfL2IGb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35759 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfL2IG3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id i23so11464261pfo.2;
        Sun, 29 Dec 2019 00:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JOrbhl6IL9Xtkt4/H1upFbUIrsfJCt9ywKKgbdx1WNA=;
        b=BxA3Ez5YIasVGvi3UGfkdAUd//NlNCFLqRQVB2ADrdQ6RDYwTGf63G6m1UEUOfCyy1
         aU5A65CSSNzUUgglcwAt0sHmc8zFkJbfszp9ozgsNJBGQ7XH3kFbdFsx4lTz4Wd9i37D
         3a7WSxYIhW0PPXWwiZjUsnZYPIB8Kgghe7GhR3IEufB4lfv5UkDoGiiE0QaI7DrA3Uef
         twewN+wG5QU9mPjQSBOj11zMOnUM6QEpOHXInLeLuyhVRr9wSinry/1czxgiqQSwRfLn
         yYgGZshaAjsHfEkWDjd1gjIHLiG+WYAIYWTRPylCeWKygsHab6d9E2QmsRe4j9Ja48YX
         HHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JOrbhl6IL9Xtkt4/H1upFbUIrsfJCt9ywKKgbdx1WNA=;
        b=AFeIBNjxKkOmtiiNVuk1zL89BjikNXS/NJXwKL/In1wB56KtVFw3Htx7O3AvuTexlX
         xcxVaE+n5jJCx3B1MhU+WmSHRtfuQtsdelQVAusqXwtmVO7N/RQFn+aiVUyZ1bHVuVPh
         DL6YhlSWh0qGA+S8U/lNABZVHqflp3FALSt9E8lr0+llfVpCWsUHMKheN75X7IDhypLf
         uQRa6b0gtIs0Tuf0BzQwXkC/HRmxhF8cZYcl39Rrkjq6kZ81DdOOdue8e0b5SID+uRw2
         HyVBd40nC8qJLGSz4WC5K6+tJeX3/NojD4YbwmZYOD8rF+rfZCBKIW70WdwMP+9XieHE
         Sbmg==
X-Gm-Message-State: APjAAAV2cYOxxISnMjVhhKG7ZEHI8opnzO7orHvphipQ6rxPEQ5CRf6R
        3aQltbfmMttPhLyX6abqgc4=
X-Google-Smtp-Source: APXvYqydhPEDBMxSQE0/HZ63X75/QdJ5GVtnhDA3lmRMQohFFvjGMaMMOQSxxNsnPfc3KGxBTNkC7g==
X-Received: by 2002:a63:1756:: with SMTP id 22mr65995274pgx.109.1577606788653;
        Sun, 29 Dec 2019 00:06:28 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id j14sm42485645pgs.57.2019.12.29.00.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:28 -0800 (PST)
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
Subject: [PATCH 12/32] pwm: bcm-kona: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:50 +0000
Message-Id: <20191229080610.7597-12-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-bcm-kona.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 81da91df2529..aa451987733b 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -259,7 +259,6 @@ static const struct pwm_ops kona_pwm_ops = {
 static int kona_pwmc_probe(struct platform_device *pdev)
 {
 	struct kona_pwmc *kp;
-	struct resource *res;
 	unsigned int chan;
 	unsigned int value = 0;
 	int ret = 0;
@@ -277,8 +276,7 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	kp->chip.of_xlate = of_pwm_xlate_with_flags;
 	kp->chip.of_pwm_n_cells = 3;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	kp->base = devm_ioremap_resource(&pdev->dev, res);
+	kp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kp->base))
 		return PTR_ERR(kp->base);
 
-- 
2.17.1

