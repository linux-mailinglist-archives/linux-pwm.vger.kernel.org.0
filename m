Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD012C169
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfL2IIK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:08:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39537 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfL2IGZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so16873309pfs.6;
        Sun, 29 Dec 2019 00:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JTxLwNHfWMCSdl17dQPhCHcE/C0FIExdEqc5ZBEYZfU=;
        b=USfTeOzMptYKE9gYaoMN2AcaH/T/YEM97jTDKmejVbSSpQ0VRIuSMlgI4iWyJKdyQi
         TgT9w+oa6HCJV/EbiMSTDznTvHy0o9Vp8Aeh/T6tvJ8fulH7IELjdTO1440DnsBW7Ecm
         Vz4vqPF74gnUndLkJNSBtRQYtMeOhcuKZyydfYZfkPsH4Sf7OVJT3S/62fwzKN7SAC0a
         smkyZe6cJlsjW8nzE5cySMMBI0HWlMKH5JEDgxO50BfnBw0Hn5cKB0WTigN/A/SOihJp
         Np6zIfueMyLZVqllS3iEN64sQ4rjpXubD9ErAEUULvzWV7cNsVjo6lk/euhBZ+ZFH8L3
         C+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JTxLwNHfWMCSdl17dQPhCHcE/C0FIExdEqc5ZBEYZfU=;
        b=n5ccC39e6BkZN3NJd2m9kCU2gKjFxVMDUoJCcxQwhVL+hIqnfN+sxSky31hmWm6YTF
         to+/tYNWe5SgtcEDk93heUPkcxId4zJw5oS/iB7H2SlwZISKYxUbYiwOz0RrgcLnU1HC
         Eq4WPR+Hr3k8sKrGNKK0jTtZYk+dDtkBPSWE/4xOv1K+vJbyDT3buozzD4YkPIYJcDcl
         qqkcJS6NUVEy3njCcFKnSD8prKlTRUDF2GQt1NMPyyHzGDQiTvGBahUmTYCyECHAT3Op
         iqWyA6llOUdFSAm9dlyWpq5uZ6XNk1RSQ8TdAMJq0/+0pX7Cm7JSiIYTmwgdFw5vwnLr
         HihQ==
X-Gm-Message-State: APjAAAUqIrDjNMrH40mOqZ2OcI4LAVIjRb7KuCzY8XgA0xbfjEAIFEUp
        00JIpp1bjOPeqpFqI7LeVc0=
X-Google-Smtp-Source: APXvYqw0aOEeyRNR1ZSX3UWHpVI83plQz16k8Unv0vX9tNYiTSBj4CWfSoUVyECQTs/4PKYZlIN+yQ==
X-Received: by 2002:aa7:9115:: with SMTP id 21mr33026878pfh.224.1577606784475;
        Sun, 29 Dec 2019 00:06:24 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id m45sm20368923pje.32.2019.12.29.00.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:24 -0800 (PST)
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
Subject: [PATCH 08/32] pwm: sti: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:05:46 +0000
Message-Id: <20191229080610.7597-8-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-sti.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 1508616d794c..eaeb38c0c0c7 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -540,7 +540,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sti_pwm_compat_data *cdata;
 	struct sti_pwm_chip *pc;
-	struct resource *res;
 	unsigned int i;
 	int irq, ret;
 
@@ -552,9 +551,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (!cdata)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	pc->mmio = devm_ioremap_resource(dev, res);
+	pc->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio))
 		return PTR_ERR(pc->mmio);
 
-- 
2.17.1

