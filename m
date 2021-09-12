Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22EE408013
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhILULK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbhILULA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:11:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D516C061574;
        Sun, 12 Sep 2021 13:09:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id g128so690641wma.5;
        Sun, 12 Sep 2021 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azJO16PBS0aaEX5vOfJpmf9jn1x1mJqiJpQpMZ0azY4=;
        b=dgfruC3Cp7h5J9EBqCGafMKFXt20sGTs0YsYPkR7d1TWRr8oLswsvyCKcBSxy4nulu
         0ZbxVa4QFZQfmClH9qJ+sj0/aqr1Oj4x/2i4oRtkgdsKe6uRyet4NtuDNfxNskm/LaL3
         8G3liXSQkeLLElx3zNZ5Jg4yey7pZ9YhZxU9IXTtiBUnML34vHWNB7u27oXvTml/Yx+T
         nKYVv/4i3YYIKnpQV2d8M+QJSBaCu5P1QMYCVCbFOiXdv/zaOWdhIPOBsiZBvSYznQTm
         1cx/B8qabHGSZgtGF8U4kZD8Mq0cMv4HZzfWjRheyzvnTcjs6shxv/6yp7El7CNX7MWp
         awFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azJO16PBS0aaEX5vOfJpmf9jn1x1mJqiJpQpMZ0azY4=;
        b=buvAiB0gbKTO8OwAMeloqoen7VqAdHe4eXf0XxMVRmbEKbkbFFWr1DkKMkWYllmN5l
         pFfPsQoAdNimmhPFXG9lIKhl4GbrmKreWNl4gS8gGzX5yoLZ6ph5msy08cjdz0IGeVFr
         MurPEFKbNEhThfoPPcgJf5eNrd/Cx4hcctoyhZco2uLOJJYKnrVUmVdePDJF1S/Evoj2
         hHH2D5Rt9okPDCKNmBgbeGPF/cSP4tmr8pVkdizBF/XrYCy57mNJYuXsuD0redRN9dAc
         KZfu1o7JFh0sGc7UU8zfgOEWm7Y6ki/q118+jgYpop4mxu+JrZqyYoRFfhssx03JgK6a
         4BsA==
X-Gm-Message-State: AOAM532QbIPeEZR8wWk3wrJBC3r6qdjd9+5NaBgssPe3s2BtslvIFVMp
        oMFWAkPtlFyjctmsfYkGUn4=
X-Google-Smtp-Source: ABdhPJwmxULcCBMXR6BD0JLAazGByGQYAT6BgoTu1ONDbXSqkFAZZJt5z69GiuVGoP2Im9fwPD+HbA==
X-Received: by 2002:a7b:c3cc:: with SMTP id t12mr7819882wmj.68.1631477382665;
        Sun, 12 Sep 2021 13:09:42 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:09:42 -0700 (PDT)
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
Subject: [PATCH v11 04/34] soc/tegra: Don't print error message when OPPs not available
Date:   Sun, 12 Sep 2021 23:08:02 +0300
Message-Id: <20210912200832.12312-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Previously we assumed that devm_tegra_core_dev_init_opp_table() will
be used only by drivers that will always have device with OPP table,
but this is not true anymore. For example now Tegra30 will have OPP table
for PWM, but Tegra20 not and both use the same driver. Hence let's not
print the error message about missing OPP table in the common helper,
we can print it elsewhere.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index cd33e99249c3..a42d4f98c078 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -111,9 +111,7 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	 */
 	err = devm_pm_opp_of_add_table(dev);
 	if (err) {
-		if (err == -ENODEV)
-			dev_err_once(dev, "OPP table not found, please update device-tree\n");
-		else
+		if (err != -ENODEV)
 			dev_err(dev, "failed to add OPP table: %d\n", err);
 
 		return err;
-- 
2.32.0

