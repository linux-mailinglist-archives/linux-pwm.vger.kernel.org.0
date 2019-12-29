Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6217E12C143
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfL2IGj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:06:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38412 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfL2IGh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id f20so13505622plj.5;
        Sun, 29 Dec 2019 00:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rdRv1Yc/GVM5QzXo8OZ+uM0MpgAUogq7/gSzD+uMyQk=;
        b=HyKxQ0X7zePFu/EcLQaScGOsVn6QhVTIYa4axjdO7X2n5g+utafq5uS0/MX8+zYjyG
         MoCJzgsGFNytjxvdiFfwyGGGsb2E/To4CYtFuSoG3EPTZNBhCfiGjBL9salgrEyixgaj
         /PgunUkKZTnBvZwzfFvxxVWPa/K0wT7EbrgxNve15SrZxcdO3T9Aa2zPVwn4qMT/aAtV
         qLdN6G72mIPGnCdV6XPylj4ozi5WcynmgNofyKjBpNYP90golg4KEfUfWgW6y86OixmO
         4oon+57lcAqqj3yrOwGYtUpZbyYQb2EP6wXBdME6i8UO7Hthb2MzW74A9o3yGH04lSnb
         OP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rdRv1Yc/GVM5QzXo8OZ+uM0MpgAUogq7/gSzD+uMyQk=;
        b=iD8icDzTvjmZ1d45IeNPdvRf270bsN+HtYfXe3GpY2j+9KLmLL+oAI/IpPIBblL9Bu
         XmE/yup1222UrPL3/fmEK0YNq30Yyguzv5KqyWtn3U+FUctRSIYRJDxKE7hvMR7G5QuQ
         Av1TpHRKDq1irfWxMnU168hHpVwaUYqnDNJwjcXTBa+6AtvHnzzgB6oINbzQ22BW7tkU
         Q4yeETMGJ8c+p5LUKLexhIC3CGBDzy8oaVHyfEUU9ip/F/G8RBMwuBftQxn5FYsrOunR
         klFnTYydGI+sUk8yDhn9oKluh64GA49+WFWUXBcdIkMkna6JzVRCVyf7PpRCpxuskvB2
         yxSA==
X-Gm-Message-State: APjAAAWXt7mXJsWBNQHfqSuK3tT7eiQcuIRykAe4HcoaEhLi0+LMuJbS
        VQv9UlN6Kkr708bkye2Wksk=
X-Google-Smtp-Source: APXvYqwJs62lt2yTRubCpXdDcYU2gAlWxVb3iezJaG6Z7PV6NuNVu5odFRAOXqN85oLpEmH60FRe6A==
X-Received: by 2002:a17:902:744b:: with SMTP id e11mr8626986plt.247.1577606796882;
        Sun, 29 Dec 2019 00:06:36 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id h6sm42817258pgq.61.2019.12.29.00.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:36 -0800 (PST)
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
Subject: [PATCH 19/32] pwm: puv3: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:57 +0000
Message-Id: <20191229080610.7597-19-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-puv3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-puv3.c b/drivers/pwm/pwm-puv3.c
index 9d0bd87a425e..2367dad7cf95 100644
--- a/drivers/pwm/pwm-puv3.c
+++ b/drivers/pwm/pwm-puv3.c
@@ -100,7 +100,6 @@ static const struct pwm_ops puv3_pwm_ops = {
 static int pwm_probe(struct platform_device *pdev)
 {
 	struct puv3_pwm_chip *puv3;
-	struct resource *r;
 	int ret;
 
 	puv3 = devm_kzalloc(&pdev->dev, sizeof(*puv3), GFP_KERNEL);
@@ -111,8 +110,7 @@ static int pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(puv3->clk))
 		return PTR_ERR(puv3->clk);
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	puv3->base = devm_ioremap_resource(&pdev->dev, r);
+	puv3->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(puv3->base))
 		return PTR_ERR(puv3->base);
 
-- 
2.17.1

