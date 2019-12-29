Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C532D12C16E
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfL2IGT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:19 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38973 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfL2IGS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:18 -0500
Received: by mail-pj1-f65.google.com with SMTP id t101so6880822pjb.4;
        Sun, 29 Dec 2019 00:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R0cuAbci5uYQKV5oYgcIjNZXakTJ8cPiZU7xeuhf2xI=;
        b=m5m+bIRzpVxT2lC3WGernvIiSgoiTh4GSzfGJ4cxWeD8TuX4KSVlCIumOBF6bd5SnO
         F4wHJOwzIoL0KT2CyRuHa2Koarb6rxhmzSucn0o/LTP+pT5YIumStQ1D5pz2GvG4hKAX
         ckQ492UoFz+fZxyxH77wyvEXK6h1CI54OszXIz0n3aw/3i26R8MEAjX+nHHkJMWUCnCY
         JQZmgSGX0++STKSwGykPZwgP79ZU3W0BUQ7UoG8pYFLdRMxO6Bcx8E+tnTrRB/G4CPXL
         KV6Ny2RV5QWhE8o64tYrWRDwkiXsESJBpaaUAdOsC1abH/LRtTPP9z2b+v4mJHHS8Znb
         gOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R0cuAbci5uYQKV5oYgcIjNZXakTJ8cPiZU7xeuhf2xI=;
        b=b7pw+PSUa0h6odIeIZ0upMMj/N+ON3yUjm4Pzd+zr2aqCBuV422f7AsvysYd3KFNqu
         WMFGoXIu8a7kndK/bk+UrvtCSASKqE/1y+5K0YtWv9LMejzetf07yGEvR36tPGfWxYub
         U2AkiPIiSllk4ifJ7B+ajwikLO3P0/iToYrbsQCrqAz+XeFTzx0HfGxL6ykGJ0+k5Eaz
         q+fYID6Dw9F8wptNwdiAXLaq8qwUAHTZ3Nz+91KMWnQCoKz0QvusGA1mshxXSUIbCqJU
         PATOWrnZAqF2HhX5klZe8z8exFnq4ie956AxRarRqP0SYCnO6dP6XIRVh+QFyg7xuBZM
         OSlg==
X-Gm-Message-State: APjAAAU9/tgiGpeZlBsMUg07hPY97U+ZmnIJRq8852aiilJC5Cx6uhsh
        Pg52HvcOA9cekvfk91JYXe8=
X-Google-Smtp-Source: APXvYqwBzBTDNYHJ0gM69+2QZwtTswZP7Da88QJfXDtLekK7yHdTvbLHKiFKwKnE1jw315fndAx/QQ==
X-Received: by 2002:a17:902:a58b:: with SMTP id az11mr61458821plb.147.1577606777982;
        Sun, 29 Dec 2019 00:06:17 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id v143sm38690397pfc.71.2019.12.29.00.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:17 -0800 (PST)
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
Subject: [PATCH 03/32] pwm: rcar: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:41 +0000
Message-Id: <20191229080610.7597-3-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-rcar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 852eb2347954..7bd67f69db84 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -203,15 +203,13 @@ static const struct pwm_ops rcar_pwm_ops = {
 static int rcar_pwm_probe(struct platform_device *pdev)
 {
 	struct rcar_pwm_chip *rcar_pwm;
-	struct resource *res;
 	int ret;
 
 	rcar_pwm = devm_kzalloc(&pdev->dev, sizeof(*rcar_pwm), GFP_KERNEL);
 	if (rcar_pwm == NULL)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rcar_pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	rcar_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rcar_pwm->base))
 		return PTR_ERR(rcar_pwm->base);
 
-- 
2.17.1

