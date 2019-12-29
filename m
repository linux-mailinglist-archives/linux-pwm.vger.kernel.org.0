Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7A12C12A
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfL2IGp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44887 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfL2IGp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id 195so16013280pfw.11;
        Sun, 29 Dec 2019 00:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1lmPaKxSSZ+I1fI6kH4nM+jOI/5GejnD0cSqURuaM4w=;
        b=JTWO/fAYYxaETHqpnuKD9DLLTqjCv39Prq8QcLSmKa7TIkCT0aEFEUaPQ1BSJ4gxV6
         vquaHEipI6ZUYuP7CGkLUKsAU/hXO55Nuu23P3ug3YdpMS1wBx5we4jPWkkG1Lj8dE9q
         +TWIwJEqwWbCpBl+tnLhpMT2uPvnHPGc9+Hm/prxi0dEZ/9u1sG8QALPAQL8Da2U41M/
         pYowafpSIYnA2gnaajAJ0yw6Dlcq3JTBCzR8d3bUUdN4Eh6QZM4YvpvHitboPZg1gqRc
         T76q1c9AA6cvzEC1urlM1xY6BVX0ye6OUxu77VOC7sY9WrjVP61g087TepnuO/r0gW+1
         3s5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1lmPaKxSSZ+I1fI6kH4nM+jOI/5GejnD0cSqURuaM4w=;
        b=kTdlIJQV0QEcRT3hoPt136jfCstoRFp5rSXh2RqY81QjSvwgJR2S8Dwd21Zw3uziVm
         dfuYdcs/QEwSLfbvV3qj6YtS3kpoHoUpL0jViitYiofG16BJS2QGw6abt3KKLrtGLVMW
         S2AjwY3zKaS6V3bkwxf6hyD7XjRUk1Yj/BeNojjjn3rHd+p2R2gJVHq/ZbehlLS0DKbf
         HpB4UYTaHsc90CRDOHHMAqbBXBWHCTyq1widxTnq/F6kg9S613Ak/GhvXWk9D3qbJqbd
         c+EKYEg3ufYTV2A3q0AUZLrJ5BVENrtSOxXCY4mKkFUfpD4U+5vg7XL23YyYg2GJyPiD
         w63g==
X-Gm-Message-State: APjAAAXm47RRXZKPwlgNfVA97KLm3F3mOGouY4px7Kut7cfawJl++/u0
        y1dWgwCqVlsSGorz3JIOOEo=
X-Google-Smtp-Source: APXvYqzKZtQcfQAWux39vbt7X9KeBIFebdYzJJZStU3j6r/dp630EqJoFMufZdCAEbmgZ86mh155pQ==
X-Received: by 2002:a63:3f4f:: with SMTP id m76mr63383066pga.353.1577606804056;
        Sun, 29 Dec 2019 00:06:44 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id x21sm45574889pfn.164.2019.12.29.00.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:43 -0800 (PST)
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
Subject: [PATCH 25/32] pwm: brcmstb: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:03 +0000
Message-Id: <20191229080610.7597-25-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-brcmstb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index fea612c45f20..8b66f9d2f589 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -234,7 +234,6 @@ MODULE_DEVICE_TABLE(of, brcmstb_pwm_of_match);
 static int brcmstb_pwm_probe(struct platform_device *pdev)
 {
 	struct brcmstb_pwm *p;
-	struct resource *res;
 	int ret;
 
 	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
@@ -262,8 +261,7 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	p->chip.base = -1;
 	p->chip.npwm = 2;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->base = devm_ioremap_resource(&pdev->dev, res);
+	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base)) {
 		ret = PTR_ERR(p->base);
 		goto out_clk;
-- 
2.17.1

