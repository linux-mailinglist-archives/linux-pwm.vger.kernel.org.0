Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3812C10A
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfL2IGV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39803 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfL2IGV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:21 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so16613815pga.6;
        Sun, 29 Dec 2019 00:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NuI6xPQivvyn80zM6z/Rk9fG3tjCood0gjQscJmLlfM=;
        b=heQ17Q6cfEOQEkJ75H1kNJEoqMluIxqlV3F5LQzVzi5dnSw+2s4EnL2eVckJBiAZyz
         KwhQOqJumTLBSHStxyOQ91Y3S5HStCvrRJecQ5pUrghCCjl/2/UAhZ2C5hPuKnZCPoTR
         Ft1NwBE5PPl27QoQw3lZswOUbrf5sJ7NUTmUKV6khxM09XKc1LqIMm1eR2hnKrCCeijm
         n3TSOaMg0Hu50HPYPQHzAXTB98eI+1Ei90YhEBidRmqgbu5QG1qv1I8x3eYiWPHgbR06
         rNS51khjhaSOFdP0yiguflRMP54B77M8gZCiFjKhh4g72NT8kY8HWZYWzJTp0ygdiJmO
         FOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NuI6xPQivvyn80zM6z/Rk9fG3tjCood0gjQscJmLlfM=;
        b=Lagmb1VOrO2Nv8Ik0B4OkQfKJaleqSy01Mxhn2IODQDGjOsrDxLV3YnAwysM9Nicdu
         lubTYq+aeacZ68nOCReJ1W3Wli1Xrm1tu37lNMVWYSPtqZu250KW6bB8vniHKkUpi0oV
         OU1s3Wx4iEHnDkcZF9tUtUD5FUN3ZeoY3oxIMCMgyeZ4523T6ogYd/ni3G35xRfXu5ey
         a/cu5Vz0pk2oDP3B2EmLJJbo8IA3vZPAqCRdhgu1O+e4GyLKOPRoa44Jiq/cJCmXhJJp
         08hPwbsVCc5o7kbSvV65OxmMujy+UQ2hFZIpDA+8h2A1jejVr4gPnyAV/t1I0lrcF6rf
         NgmA==
X-Gm-Message-State: APjAAAVxJR5siTHdSCv6Px9zVEkLobgzJNVE7xwWZQvcw0KZwcdh8Tkq
        QzhJkQuIn/IOab4Stha8rME=
X-Google-Smtp-Source: APXvYqxLM8XVaQBp/QfuS16/tUZBmfcc7TmcOv60xmo/5rDnPQvmCR5gXBlyK5U7O2hVs+djSv2BKA==
X-Received: by 2002:a62:7696:: with SMTP id r144mr21966475pfc.177.1577606780217;
        Sun, 29 Dec 2019 00:06:20 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id w123sm28402452pfb.167.2019.12.29.00.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:19 -0800 (PST)
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
Subject: [PATCH 04/32] pwm: renesas-tpu: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:42 +0000
Message-Id: <20191229080610.7597-4-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-renesas-tpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4a855a21b782..9f4695cc8e72 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -383,7 +383,6 @@ static const struct pwm_ops tpu_pwm_ops = {
 static int tpu_probe(struct platform_device *pdev)
 {
 	struct tpu_device *tpu;
-	struct resource *res;
 	int ret;
 
 	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
@@ -394,8 +393,7 @@ static int tpu_probe(struct platform_device *pdev)
 	tpu->pdev = pdev;
 
 	/* Map memory, get clock and pin control. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tpu->base = devm_ioremap_resource(&pdev->dev, res);
+	tpu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tpu->base))
 		return PTR_ERR(tpu->base);
 
-- 
2.17.1

