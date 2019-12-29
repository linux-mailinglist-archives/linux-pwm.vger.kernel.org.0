Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0512C138
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfL2IH1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:07:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41619 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfL2IGn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so16611293pgk.8;
        Sun, 29 Dec 2019 00:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7C9csqsnQvcsncB7BFqdTNUWmGo/VsO+LA8tqtfgkPA=;
        b=jcjs/+PLV2JXKvRK5ziMpwAysMkDPC8s9r4UV5yKxf4yhxZbU8xB5E75T6G/P7ulXb
         jMY8puOpg9UcDUg+10rYov5RFZx8U6pvz4XAD5KpWg1cX8Siwjtz26KDB7AsB2gVNtQq
         CdAnqGPr372cK1kcSr9c2X17LwY8wOcSstoRm94NWpcEYAserNiA/w0Fz2JVpBDTPH3+
         ZA0RD/rOJvts3a0XWraMURs26hCaQ8lK+tQcN5PLYuiY9GrIdZaJdFguQV38dmJ+UQmc
         I+hhBYo+RfLtod0vQrpGTa2vLgx4GA/hKk8mkWnVqFHW1XLgE+QVEHR369nWbR8cE3fo
         iL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7C9csqsnQvcsncB7BFqdTNUWmGo/VsO+LA8tqtfgkPA=;
        b=Lqbfvc8mgfwc5JicM9UqPTf9BQpDdyZ/7MPqydGaTDo4xwuQihbUlguJHnBF3fc3if
         tklnnyovjRHvvp3Qj6IHtSmr3INCldZks86xj+fKJI8q1YUP1KFoJ36fogoOiqI2JDKf
         ej7zeQgwC64arYiWC2Dd/xcxen3d2uBYcXCEBkiaJYP17YqY+O36tlcB2Hbcjvv5dL3R
         3aGFp9d3nDw4Y7JjVD10CzSGnaGvDQZU2/GH03hdiHXQHOnXR0fbN7ayXTIuYJB6hj9o
         01QdN2R6/cQYZyWAJRB1kkue6fcB02h9PuRZmQK2imV9XYavBAa3DxnkSzKSL+MBBzHi
         5ZIQ==
X-Gm-Message-State: APjAAAVUaEmYOFVSv3OLx/gfSbGQL9KCzmFg2ZN050R+aZ2Ke8CrQSzN
        gohtQmpxY8a3m8dz1nMiW5dF57dkvKk=
X-Google-Smtp-Source: APXvYqzUdmO2Rv7imffzZ5diTgtjXIZc+zetWCpfjNYcI++CXUFajSDwDRs8JEjaQLkbgWwatBbprA==
X-Received: by 2002:a62:a515:: with SMTP id v21mr65261927pfm.128.1577606801886;
        Sun, 29 Dec 2019 00:06:41 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id d21sm16349375pjs.25.2019.12.29.00.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:41 -0800 (PST)
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
Subject: [PATCH 23/32] pwm: berlin: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:01 +0000
Message-Id: <20191229080610.7597-23-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-berlin.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index b91c477cc84b..fe405289e582 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -186,15 +186,13 @@ MODULE_DEVICE_TABLE(of, berlin_pwm_match);
 static int berlin_pwm_probe(struct platform_device *pdev)
 {
 	struct berlin_pwm_chip *pwm;
-	struct resource *res;
 	int ret;
 
 	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
 	if (!pwm)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pwm->base = devm_ioremap_resource(&pdev->dev, res);
+	pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pwm->base))
 		return PTR_ERR(pwm->base);
 
-- 
2.17.1

