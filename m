Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508C612C15B
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfL2IGf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40155 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfL2IGd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so16881676pfh.7;
        Sun, 29 Dec 2019 00:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ct3vgdS+UwOkSQiRdRBo4SJ7PUFYHZ+yjrMr0Puh11g=;
        b=ghyzqYvQARSfUYq5JSG2z28dc1azfEBMCfJFYqJnfOIxzXImq3oKdazr/DIyiK8dQo
         3qKoSyld1xuazbHlUQFIXHN/PWNOK21FoSxERfZ8HuBT2s3Omh87MYC8coVK8TRkkpT5
         ST4X0ALU+bDl6iEESe7BXYMFvjdbhvMvEurE7m/sGTwjjiYXqjTJIw0Jgcrqeub4Dua9
         EQaaDp4fxFs+93L1xxvPI3zrtTy5FxslMYx7y3DXrD+3SiEWebHOVtWcYZ7oPMTL+4V5
         a4BJudvlLECV9hf8qbedssmCdQmoxWnT0zSzHfTshtBY1vxk0awKbs7cGMlb9eQf88OX
         F+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ct3vgdS+UwOkSQiRdRBo4SJ7PUFYHZ+yjrMr0Puh11g=;
        b=HF+ILXOcv4UF9uz6NmoK7KhY+iL8AJOZgttry/rgO7oUehM8Iv3WcdXe7PRcKre4j1
         u4g6MYUpx4rcURmitKgVLQzzsomFuTVrGD42u/VVLoTnUtBJZijBy7AGijTcJ5dJVoit
         BbRxU9vaFwn0IdLcoTCvKpTM+2B5etXtRUY7ZEax9NQwKdUyHQRYPwIPRQmj6YUqnl3H
         dBjefoWFNuFfH4JYlWDmKvd8ctCgu6bOrutc8kAQAwhIbjg7LbUK2QCx/vW2JkF15lXD
         hY8VynsDzX3jDNeswQNs9WgcE8T6OeP+UY9GRWNlffPjfhoR9AO/V2/xG4icC9ueXoVi
         T8ig==
X-Gm-Message-State: APjAAAVlKwL1lXv9TWv8zbancmtib3pKBZkh0q4bHkmBRtuj4PJHgPAA
        evITxbACAnWlJeyTRdIGSf0=
X-Google-Smtp-Source: APXvYqzSxw9K1ScWg6hnSPiOSt1jE5L5RXiPnGdbNgCdaOrvDG2u8O/0g4Yh8BqE+c8rgkeMZLKvlQ==
X-Received: by 2002:a63:2fc4:: with SMTP id v187mr63795754pgv.55.1577606792475;
        Sun, 29 Dec 2019 00:06:32 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id l2sm20053079pjt.31.2019.12.29.00.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:32 -0800 (PST)
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
Subject: [PATCH 15/32] pwm: rockchip: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:53 +0000
Message-Id: <20191229080610.7597-15-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-rockchip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 73352e6fbccb..f0549b82338d 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -292,7 +292,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
 	struct rockchip_pwm_chip *pc;
-	struct resource *r;
 	int ret, count;
 
 	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
@@ -303,8 +302,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pc->base = devm_ioremap_resource(&pdev->dev, r);
+	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
 		return PTR_ERR(pc->base);
 
-- 
2.17.1

