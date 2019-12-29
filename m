Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BDC12C15D
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfL2IHp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:07:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42095 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfL2IGg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so16875790pfz.9;
        Sun, 29 Dec 2019 00:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=svnvAUsqbEkFIoMGUER3OWtLIkClDeqzObpr+AXdZkw=;
        b=t5ALQLYK9lE9EF3GpK75tsx7VA2i2BuOPjCLKDo5sSqg3YRHpO7DWBok2eiPKH6Zsk
         F+4ncCiS70Pt5DR9KMI0QU6VZBnbwwi54ooU6QkGvSSaxpX+mqIbp8bHsLQX3uO1pv0X
         OkADBds8TVGjQwtYTls5YZYAaoeItIYmXN6CCE3t5G5fzBfNxf0nS/2zdluXKGdlPK6j
         Bdq+W9BMNPDJUElctI6Djq4w6tylgT0rlMuDv1+5QKJ6+GZufn33f3/0Iwo0fpr91o9c
         TTv9uClGVSbigvShKuRQMEvORpLdA6AB3Z6pDDh7u7vttBTxVgOK07T8IyGMQqWlDtpx
         +wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=svnvAUsqbEkFIoMGUER3OWtLIkClDeqzObpr+AXdZkw=;
        b=DMPeYQ2TXDsXOtHdSlSR6hZIJmshfB4uwXtwWK/OnjAjwTssD6n3TI2KeEl//rSLF5
         wrJ3RpX25wsFspWsf/WPI6iNMA6EL9hU6L7sFdr9Zy8KcsgUK/rP/5vuIrQVWuy89oDP
         SgB5vBnbBbhYSuodncTwjXZ9vA34dwWyLMnHdRVJFyJO6va9vPDTmWM7q1STYuXPKCyw
         gIvL53IQ2TrafYbR2qDYHpm5HNSPYyIbEoFVs5Lv/ZUHwC0ge1cN2CmlgDS7OXO3UoWT
         RMpbNS90Q3oJJ1BEDMXbH/YCfBGvancVsleY12r4mHvY1qn+jcC4JkiF3FQR37DJM5zx
         W0YQ==
X-Gm-Message-State: APjAAAXHbADlCNemoBem8hxEmUw7Sda+gSma0hJQujsD8S7bcwYyj6qe
        Srpkgbjynl1LjR97l5rBz40=
X-Google-Smtp-Source: APXvYqzgqbn3DN4K9PetwsZFudgp9eD/v8wQEKuWIqkJk6/RoGS49GaXiPsLXIZoq9tCD6gTE1NeEA==
X-Received: by 2002:a62:1a09:: with SMTP id a9mr64684599pfa.64.1577606795644;
        Sun, 29 Dec 2019 00:06:35 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id h12sm31640473pfo.12.2019.12.29.00.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:35 -0800 (PST)
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
Subject: [PATCH 18/32] pwm: tiehrpwm: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:56 +0000
Message-Id: <20191229080610.7597-18-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-tiehrpwm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 7b4c770ce9d6..3a1313caa5fe 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -421,7 +421,6 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ehrpwm_pwm_chip *pc;
-	struct resource *r;
 	struct clk *clk;
 	int ret;
 
@@ -455,8 +454,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	pc->chip.base = -1;
 	pc->chip.npwm = NUM_PWM_CHANNEL;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pc->mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-- 
2.17.1

