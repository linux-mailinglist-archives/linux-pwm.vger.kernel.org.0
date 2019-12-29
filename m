Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A9012C12B
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfL2IGq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37600 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfL2IGq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so16624930pga.4;
        Sun, 29 Dec 2019 00:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ubisCHSwqc2s7xWWzDTAHcgrFyxa0/se1FgLzXqSzJU=;
        b=PKcxSuP+TIR6RR+D+3utUn4UDdebt73BcNOcvFjEXOWOtUQu8RnoetjVEuy/iZFDYn
         vt/3TgUmGBbAP+K+PitpTtb8Q7MAYoNV6DAi/fLCia9ZK6l+a2JMsR0iH9zlWebHPTKF
         AdhaRsImVy430lM/LsLIRsYC80w5uy0ExwCN7Dg9FjZViWyETX4OuLWuvPBkqm4wuWJF
         uPSeSiNAL9LHX01Rcfkj3Pkb+3Lkfa559mQdT/a9Cof2zrN4XNI9n7hq4yAjws9GZG9L
         pW15SKC+iTmp0vPJclmBLQF+Ays9MUsuArhvroKiAfSUM5JvvK3yTjdJLYoOVwzQPi5A
         e2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ubisCHSwqc2s7xWWzDTAHcgrFyxa0/se1FgLzXqSzJU=;
        b=OGypcA9H85L6ETC4aqc48qGjxTKK1S9fS02MZbo4FNpA+FXNNvotIlleidhXIJWKSi
         FHOOxESU+1OWUpFimgQH+NZvCcCS/xuRU2usWdJDestvfRF82/j9OC27fbaATzlPDQ06
         P5+hyWMqdJFYY1aP8Sr20Qqqmf/ho3isZz20l8cz7ha23FcyC4eVN7hGVvCCmgp4Aa/t
         6MBY8VazKHnje42sHMqUOA+Yo7mUAF/ry2n5pqinswO6a2cwW9tgNxgb2TaRfm3V4CKl
         C0YsUX4Ae241Zr3PpVlWT7bP3jxPTYd7mx+yG5m4Dy/IGJXHn0HGmfQnHXkoENc8ZcKd
         3Srw==
X-Gm-Message-State: APjAAAXnE3gAPw9y0tFQR3+nnT2Poj+ca2aMF16s2zLtw8FK3qDxTzOI
        vGP9l8cvYYmhMHnpIu3Foks=
X-Google-Smtp-Source: APXvYqztgO51q2M7dpEWvqnOl+OuEOll/cXfvrXPmRpn+n/ZTTV0hJfK8S/d9jsZVGZMHeU4/SfnIg==
X-Received: by 2002:a63:6787:: with SMTP id b129mr64849725pgc.103.1577606805089;
        Sun, 29 Dec 2019 00:06:45 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id r7sm47674721pfg.34.2019.12.29.00.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:44 -0800 (PST)
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
Subject: [PATCH 26/32] pwm: mtk-disp: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:04 +0000
Message-Id: <20191229080610.7597-26-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-mtk-disp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 83b8be0209b7..87c6b4bc5d43 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -172,7 +172,6 @@ static const struct pwm_ops mtk_disp_pwm_ops = {
 static int mtk_disp_pwm_probe(struct platform_device *pdev)
 {
 	struct mtk_disp_pwm *mdp;
-	struct resource *r;
 	int ret;
 
 	mdp = devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
@@ -181,8 +180,7 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 
 	mdp->data = of_device_get_match_data(&pdev->dev);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mdp->base = devm_ioremap_resource(&pdev->dev, r);
+	mdp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdp->base))
 		return PTR_ERR(mdp->base);
 
-- 
2.17.1

