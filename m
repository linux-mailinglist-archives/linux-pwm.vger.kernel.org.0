Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B48B112C135
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Dec 2019 09:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfL2IHT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 03:07:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38766 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfL2IGq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Dec 2019 03:06:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so16883404pfc.5;
        Sun, 29 Dec 2019 00:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zcHD+rWT+BbboeyvNLj2n3ooAcJQzfyFO4UCzDGkuhw=;
        b=E/JzGOtpfinHn+r6Nqt4BI5pFks+bjbqVron4JoRxP94w0UIFIVAEzNAykvpZoDTHG
         YdpP4wRAK6M/FQIdpYYxzBLZOmoog2O1Y40cOyLcpnDo/2O9fxR4NFzOaZ1x0EmaujHB
         Vov8M5Z25EwOhuPEoRoEFu/dM5gTDeGkLvqCDdPZaObFIo5vY7JIpHeZfiIFIeDhprQE
         u04G5AatFvvQ7aoNiA0/W7lgxLSTfHxFlafECN0owOb2uTbRi1abpNLb+TGTQxNmryPh
         gpocdwGzgwwZYgjXfmEJf96i9Gz2VuYiig3Dzl2RXfsSMky3WavexL5Kr3R4FWeDNl3p
         DeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zcHD+rWT+BbboeyvNLj2n3ooAcJQzfyFO4UCzDGkuhw=;
        b=VB/IfAGjERjv2EtjRz3tfdBMityI9A/wCcu6zk76X01UFZ9pbUv9kyAE9J0vfTNpeP
         OSeHJXigx8VM/15gL3AG3oc/QXmbjgSUFiNBphUC5MPZfQo3LByt6Cuo8dKfoDooxgFE
         Rq7pqeCWjNLHKEfK36Fmq/dBpDtfmhFMd1Xw7rTLddkM+Lcw3WDm6K5RWUOLJwBl2wdp
         klkAtp9yGq+ll6I9LIUUQ0SMtaSnBpHrE4TgTNU4/eh8WmmbvqpOJBrGyj+kjt7B65ix
         TPyhTOBaztGEORCXFowrFjyiQMe/2HGxmYEidODcDDfIniJYzUixA48U7sQl5Ia5ASzd
         FGLQ==
X-Gm-Message-State: APjAAAWDYTDQe2alG+cZRLo8shWP/ZYiOj3oxesmoothYHd/tXIWfyHr
        bJu+2UjC8WIpi5T6YnuHSLM=
X-Google-Smtp-Source: APXvYqwWymCsuMsS6doL78LFT042zKrJjX+UYK0FXE7pm0oZc+RfEaCYhPRMzd55UCYO0aSn6F1J+A==
X-Received: by 2002:a63:134e:: with SMTP id 14mr65912691pgt.115.1577606806183;
        Sun, 29 Dec 2019 00:06:46 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id a9sm19507006pfn.38.2019.12.29.00.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Dec 2019 00:06:45 -0800 (PST)
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
Subject: [PATCH 27/32] pwm: clps711x: convert to devm_platform_ioremap_resource
Date:   Sun, 29 Dec 2019 08:06:05 +0000
Message-Id: <20191229080610.7597-27-tiny.windzz@gmail.com>
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
 drivers/pwm/pwm-clps711x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 924d39a797cf..e69a5877cec6 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -113,14 +113,12 @@ static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
 static int clps711x_pwm_probe(struct platform_device *pdev)
 {
 	struct clps711x_chip *priv;
-	struct resource *res;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->pmpcon = devm_ioremap_resource(&pdev->dev, res);
+	priv->pmpcon = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->pmpcon))
 		return PTR_ERR(priv->pmpcon);
 
-- 
2.17.1

