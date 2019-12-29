Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A78A312C160
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfL2IHw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:07:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39774 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfL2IGe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so10549861plp.6;
        Sun, 29 Dec 2019 00:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3FJLm6IHho2et3EaxiZvjeK2p/A2hG2XGbKwfQ5pkcI=;
        b=knU0TWfNlerRqeXVJfgPi3d6ipftwz6wCwagApjQURWF3pfFaxBu6OjFcHxBx7SrxB
         +Fzu2/vMjmjDtU5X4mP9AFRJAqqZs2dGxKIWHQZKJF3xgEj56+nFzScLvXqRCeFPr1cK
         Hd0vNqET9Ec6byhgNrg45Pt3QcZs1TSzQt54rcQ13qURFatO9zYNqqJcqgGrsB1ylYdd
         Sd0qk7Kr/2ipNksm3qTL2+IC53DMfr/ebs9RFuuro+F+/jUsU99R8ht5eyn++OewNdRq
         +ItlSNeEhECkhcopP1b2eQGKQc9gOZ7CxD8PCazMqv5ee69n7oFlviF1gQxS9vbySD96
         +o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3FJLm6IHho2et3EaxiZvjeK2p/A2hG2XGbKwfQ5pkcI=;
        b=FxPGHO32awKa733lUqQVoHEFgg08hICtW5cJyd0+XcvalNZ+mO26JeW666jmQKSJcH
         Jg5rHQIB8BflQs6N3QKQ1Kna/QzyyGoawGnaRHHDiiScGfzwAg4Fw1JyPKaZIMfmdFKU
         EO68udtbVSNR3x1JxBYh9ZWfv1AlW/pJOtM6pRGE+ynImEZ9iUh7d/qgUGL5EVXu4lF/
         QobzogmYbQktbtTchNmzkfG4XgOYHWj5rYdrP6r9qYFy4T13yiQY8GmV6jjUrMnsMTZe
         c3mKDiXM95y11hxxoRKb39zaUwNrtRoSCkk0Jmor/zqnjYv8ZD/RXyevPLqWZsSPsjO3
         A2gw==
X-Gm-Message-State: APjAAAXy87ACou8AVlVBEJtTYja+CO3TtZUb4tc5x9tptxJDVFkXllfi
        7MCeg3K8aLPfk0WIwS8V8fU=
X-Google-Smtp-Source: APXvYqwFME942YugfhefjV5/NKgYnOPVb/hpAWbFUGH9q4MwS4lL8gn3kycg7FTsyyL3Sj3vd2zW8Q==
X-Received: by 2002:a17:90a:3763:: with SMTP id u90mr38491512pjb.107.1577606793562;
        Sun, 29 Dec 2019 00:06:33 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id e10sm48335950pfj.7.2019.12.29.00.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:33 -0800 (PST)
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
Subject: [PATCH 16/32] pwm: bcm-iproc: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:54 +0000
Message-Id: <20191229080610.7597-16-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-bcm-iproc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee7..52860df7d9b7 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -193,7 +193,6 @@ static const struct pwm_ops iproc_pwm_ops = {
 static int iproc_pwmc_probe(struct platform_device *pdev)
 {
 	struct iproc_pwmc *ip;
-	struct resource *res;
 	unsigned int i;
 	u32 value;
 	int ret;
@@ -211,8 +210,7 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	ip->chip.of_xlate = of_pwm_xlate_with_flags;
 	ip->chip.of_pwm_n_cells = 3;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ip->base = devm_ioremap_resource(&pdev->dev, res);
+	ip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ip->base))
 		return PTR_ERR(ip->base);
 
-- 
2.17.1

