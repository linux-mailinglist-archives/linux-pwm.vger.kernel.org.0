Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1F3EE3AD
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbhHQBeG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbhHQBal (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:41 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3464C061764;
        Mon, 16 Aug 2021 18:30:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d16so12086631ljq.4;
        Mon, 16 Aug 2021 18:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whXbmpiV9uZrIWQEZSp5RRTDQ3TFfbRun1N2tfG7MWk=;
        b=qVuy6Otl0UWSQ+/nZMjDzykD2sSUZDst3NL/JVapiLI3z3yUfsGAUcncelhMR38Lym
         1xjVPKDNQoeHSdojhaD4CNMJ2Dgxsx7ya2LEvfAdSM6jyMIhg0fAggQvAzFKMqqVOL9O
         IPbH29DcWGT56C4Udgprd2zRCBzNWyrc1+xqzNB9hh3j27fQeaGpUX2Jl9g2CjR6dsJE
         H3f4BOVlgw85yDYhZPvxDoAPPZKXld5HwD4iSdkylVBs+x8a7x/zUr2T15/KjxPp7TBo
         OcMaTgNBzyb8Gi7/p8ZpOcNZ09XNRqw/14qoRIg6z6RvIG29dGNOEq13dllv4PGdI+NN
         gRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whXbmpiV9uZrIWQEZSp5RRTDQ3TFfbRun1N2tfG7MWk=;
        b=tKRONxf/lPDCkWXjIh/cnuGK5Z8tVtnWfeSatE6d060W0vqWsicKIh4CaETF32u1Xj
         HZzdVHfbOOYQV98BAlqvsjax5e9pi6iZQ0YC9rh3kEYgoZTTKQfgocLcojp5O3cEc29h
         pccH5oxsS1+M3nL5P6ytI4duBbHtaADX0WHsupeMiS45XsdP7ybto7i4m9Nck03yDU9z
         zfdCF6+GVCdWgk91QH59NItfZeUlqfFj5QjbOc4xviHw9BPfa/CsxssFja+t6YWBV7KQ
         vJRGFFGb9xEuD08UJJ3OBWSZqx7zQlNkxstEwOEDtTAypcey4vCQ5MYwpLGSA0rn/nBk
         pykw==
X-Gm-Message-State: AOAM531jZCQ3LsBYhtYCovILQcxa5Jk1OLcznavUFSjp6JjSyu8sa7uA
        +Do/8VPSTXjl8sRT6u/YMKI=
X-Google-Smtp-Source: ABdhPJx0BGOHbSZlE+uingQVCD7QPlpfvESjI/6O9+jCEZkAPokxg6m3XSjkH1CoIjJ45grVv1YxFQ==
X-Received: by 2002:a2e:5758:: with SMTP id r24mr870243ljd.432.1629163807370;
        Mon, 16 Aug 2021 18:30:07 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:07 -0700 (PDT)
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
Subject: [PATCH v8 05/34] soc/tegra: Use dev_pm_opp_sync()
Date:   Tue, 17 Aug 2021 04:27:25 +0300
Message-Id: <20210817012754.8710-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use new generic dev_pm_opp_sync() helper which initializes voltage vote
based on clock rate.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index a42d4f98c078..dab1bacb41ab 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -39,34 +39,6 @@ bool soc_is_tegra(void)
 	return match != NULL;
 }
 
-static int tegra_core_dev_init_opp_state(struct device *dev)
-{
-	unsigned long rate;
-	struct clk *clk;
-	int err;
-
-	clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get clk: %pe\n", clk);
-		return PTR_ERR(clk);
-	}
-
-	rate = clk_get_rate(clk);
-	if (!rate) {
-		dev_err(dev, "failed to get clk rate\n");
-		return -EINVAL;
-	}
-
-	/* first dummy rate-setting initializes voltage vote */
-	err = dev_pm_opp_set_rate(dev, rate);
-	if (err) {
-		dev_err(dev, "failed to initialize OPP clock: %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-
 /**
  * devm_tegra_core_dev_init_opp_table() - initialize OPP table
  * @dev: device for which OPP table is initialized
@@ -118,7 +90,7 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	}
 
 	if (params->init_state) {
-		err = tegra_core_dev_init_opp_state(dev);
+		err = dev_pm_opp_sync(dev);
 		if (err)
 			return err;
 	}
-- 
2.32.0

