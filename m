Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73FA12C13E
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfL2IHd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:07:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42005 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfL2IGk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so16605173pgb.9;
        Sun, 29 Dec 2019 00:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=upleNgTFfAza3FZg7/9VQrzMx7En/pvAOWEfdB18Fmk=;
        b=r+5CpJmnN4vOgNpA/om76KyWVgPXmGGC6EM7e5tj8W5dRFmK9Jkqc2gpIh53oz+Caa
         LIAb7jx83j8Ef0YXJ+NgKqL+7LJQg65TOGqsZoPIvZ60GJD9V6T1XfllJWEYAOC9zjC4
         e5Fwd3jau7TGVaFrOBgX4MJw717C0exQVM327OITBjJHfTlLyasNoUZW60EPSsKOahBN
         VKs9jK2lf7hwyWdfhUxHR0emWL9IeIGRgxvkc6IgY468vxtmtW34CNrEIahXOtQOhoD5
         xP0Sbw1eW1+RTFzSeJ8/41p7VFsupzRE/i76xGj+KTN0wZvgVjqLudZI1p/vmdak/z7+
         cZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=upleNgTFfAza3FZg7/9VQrzMx7En/pvAOWEfdB18Fmk=;
        b=fh14QhxjJRSoiQsoCAbocJ4lJ5NLMSaWri2ANcKcv+v7ZBenDyjDTnXV7PwsTdG4lE
         S2FA6Dd8VGi4fowUDXa/uM7cCJKePFgA+XrIDX+9lpNPmXHt2FKVYNKwLN/uFRL6f8M/
         zjXoMj7VWue5JNUYLxY4Ue+wZXRuUNF5VYfwzeAWaxLgZDJnG4Yk7zbL7edZXWl3v+r+
         80BsXSyw2U+JUqMcK8iOPLs3BDUbhO6nTnuVzUfSHPnwCQ3bNqdw+D+1HHQ/MZI5P8QL
         cw7hzaXZJh91gTphJoVmzgg7/che5BRLx5Zqtpx2PEm/flqlp4SD6ZYeJIqPtP3VgsYd
         iyPw==
X-Gm-Message-State: APjAAAVfymk9yXERrqxtIKgGhhuQb9AqQLSIrYm8I0PfHuQbGrQ2oSrV
        zHWihwIGHf3r4I/olB3aY+w=
X-Google-Smtp-Source: APXvYqy4BUrAwHcEQW7eOd+3yd2eT1ZZTaKeli2o7/H94zl8bi+IzfTqBBlbxhAYoRaHMAsNYRzH0A==
X-Received: by 2002:a63:fc01:: with SMTP id j1mr67311075pgi.220.1577606799597;
        Sun, 29 Dec 2019 00:06:39 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id m6sm19934565pjn.21.2019.12.29.00.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:39 -0800 (PST)
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
Subject: [PATCH 21/32] pwm: tiecap: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:59 +0000
Message-Id: <20191229080610.7597-21-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-tiecap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index ab38c8203b79..3a9885cce386 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -196,7 +196,6 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ecap_pwm_chip *pc;
-	struct resource *r;
 	struct clk *clk;
 	int ret;
 
@@ -230,8 +229,7 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 	pc->chip.base = -1;
 	pc->chip.npwm = 1;
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pc->mmio_base = devm_ioremap_resource(&pdev->dev, r);
+	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-- 
2.17.1

