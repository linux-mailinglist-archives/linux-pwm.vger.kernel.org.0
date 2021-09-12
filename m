Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B981D4080B6
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhILUM2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhILUMQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:12:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA3C061796;
        Sun, 12 Sep 2021 13:10:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x6so11279142wrv.13;
        Sun, 12 Sep 2021 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9QYtupMPLyzQnqOhwfXP4oUoMqt4gxj3ewFZ5B73Ts=;
        b=likXWSDZ1v4Sks8GU89iHowLqcUIMbRx2wPVX1eQxhP6OFsM0KOWZ9FJZhC5u81DH3
         Xwm7v1MdGjoALtI6tmFDtN9SbW8Kim3JApNeY1SY7TKt6OC3vh3EBVSiwtbK2CClM+Ch
         FhxtDJVGkWKHaFxatJVQimK5oi2xZwnonEV9O9Hrp+ECsZvXzfCdLC8zgVxxOYSRih5G
         12j0KRIHdXQWild9q2nxvAMdxgj+OwpAwzhwLSe1w/X5a7wf6YfGu84X+25CvvWmqTUf
         QalIstKqSUiPtJtPgkLrvVVp7FeQ0qN5uKfG0LxgAwDZYuXuoEfCI6CAeaviK7SONxJF
         jWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9QYtupMPLyzQnqOhwfXP4oUoMqt4gxj3ewFZ5B73Ts=;
        b=s8MQ+V7WhAZ7/+6giwUX/2JVnbAHlrbYlyiBGNpxCgdluxYnSuzI7bfC+QmK5mvKdQ
         lW45IiOnKrZ6KP88mrFqYdY1SKstjBo0UDeXr/U8XtyQDw5PKO0oKDSrEIWn4OxIz7IO
         0c1Cku5PLBdFzsroFbeJ9IcsBe6d120Q653MIcWL39qjEC2tlVlbbU2F8X8i/bEhCi91
         7H/59EcUlwk1ruVtf/hxwA5AdNWT6obNGrGKAxOrR+9zVeec704WDk0eJj0I+5D54QvD
         QOG5bPa1C4k1wAzrCVAmXxcvWH0zFpHclvuxHMfFFMaAvzZGGrphJ7iD6BXU8NKAbRiv
         Gsow==
X-Gm-Message-State: AOAM530aKx0CMBgomw2iqjL8DLGZq48873guY99N2RYSGk7QukZT+d0h
        b5FyX1x/T/x+yVS/4ll6JDY=
X-Google-Smtp-Source: ABdhPJwCmjRwTNEp+XF6+uJ6s3Fjckg+MJaBPqelfkfezkcz9fDISHUtIGjPc0rD/uibc9ZFzImTJA==
X-Received: by 2002:a05:6000:124b:: with SMTP id j11mr9073974wrx.147.1631477424444;
        Sun, 12 Sep 2021 13:10:24 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:24 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v11 21/34] spi: tegra20-slink: Add OPP support
Date:   Sun, 12 Sep 2021 23:08:19 +0300
Message-Id: <20210912200832.12312-22-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The SPI on Tegra belongs to the core power domain and we're going to
enable GENPD support for the core domain. Now SPI driver must use OPP
API for driving the controller's clock rate because OPP API takes care
of reconfiguring the domain's performance state in accordance to the
rate. Add OPP support to the driver.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 8ce840c7ecc8..1a92978d2120 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -18,12 +18,15 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 
+#include <soc/tegra/common.h>
+
 #define SLINK_COMMAND			0x000
 #define SLINK_BIT_LENGTH(x)		(((x) & 0x1f) << 0)
 #define SLINK_WORD_SIZE(x)		(((x) & 0x1f) << 5)
@@ -680,7 +683,7 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 	bits_per_word = t->bits_per_word;
 	speed = t->speed_hz;
 	if (speed != tspi->cur_speed) {
-		clk_set_rate(tspi->clk, speed * 4);
+		dev_pm_opp_set_rate(tspi->dev, speed * 4);
 		tspi->cur_speed = speed;
 	}
 
@@ -1082,6 +1085,11 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	init_completion(&tspi->xfer_completion);
 
 	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
+	if (ret)
+		goto exit_pm_disable;
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
-- 
2.32.0

