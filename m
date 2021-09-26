Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7617E418BF2
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhIZWop (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhIZWo3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:44:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D52C061774;
        Sun, 26 Sep 2021 15:42:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z24so69312604lfu.13;
        Sun, 26 Sep 2021 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xyfv+bs1PqRnjMFL4Pq5e7XkvADOaeyFEUXpxII4rIo=;
        b=izvFqpS38K4FCvT7p/zbvtPiyuSbxhHUIKmFwiK3flubJCAqcxp4mNup9FVUVBz10D
         BaZc9dN4ud4sqdRa9IoE73Rp8graQE+SahQXeY7IOPhoiS+N7m/KkaLm5SMLR/4w0aPj
         fg0tSmIcoWmarUWnmFwz5LastPqVxXfW5RPHers47MYDvxqf9Dfl+4Dzr9cGHY8HAHvi
         m1pK+t0poPBYPw4Zax6XbCAaoqMfiQU1/4WQ2Ay9/Kl6f34wy3fZuLPXoagHgox/5bTL
         A3v8DwV12vmHFdpkQGfAGPyI+CZr5nITAm+9lMD11iMI6Zznv2S5aOtjHIE18/Dsuru5
         Ijuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xyfv+bs1PqRnjMFL4Pq5e7XkvADOaeyFEUXpxII4rIo=;
        b=JOMPOTioMgHsut/89CCbUfT+T6mCbP43Ha9ccJCJ0jQ6k+VTNpc5DqYQFLAzFqwzTh
         VuiO4xEgylcENnZPV9tsTCuQPxGjEzbUaHhpC6IGgj/lwYhmhOIcLyQmBqqyWUt8+WnQ
         a+M4rhnD8Kc6q6H25e6oAGKD3HNvTjFUWvdWL2O0QQAs8WKg87IuXIwonrFdkDCiUOFP
         ai1Iq+ZMhgjG5M3R7mIQ2w4sraXbw1DhoAX12D2J01n0DsNf5xFhWz3CyONuuLt3sVef
         a8ePXDI4aUDJq4qYDtnN2weFxyj0eiNau5fijPxMHVDQCeyaFbRZBgCNB2tQubDqDXfd
         HGIw==
X-Gm-Message-State: AOAM532ohePFWDE7VwmHRBLATBj4GN/CmQU7BIELen530cqUHSq3VQQe
        U1ekrcje5wp+bgGYMQgP/74=
X-Google-Smtp-Source: ABdhPJwFcgY1e/EpRbZGqJyBjJ81B0If7emAzTEomlL5PaZAh/GdNeqs2BhIjIoVoXBk8gQvMR+6HA==
X-Received: by 2002:a2e:5005:: with SMTP id e5mr24744959ljb.471.1632696170675;
        Sun, 26 Sep 2021 15:42:50 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:42:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v13 21/35] spi: tegra20-slink: Add OPP support
Date:   Mon, 27 Sep 2021 01:40:44 +0300
Message-Id: <20210926224058.1252-22-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
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
index 3226c4e1c7c0..eea1853010e8 100644
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

