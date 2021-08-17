Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7084F3EE244
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhHQBan (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbhHQBaj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FDEC061764;
        Mon, 16 Aug 2021 18:30:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q21so8672394ljj.6;
        Mon, 16 Aug 2021 18:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azJO16PBS0aaEX5vOfJpmf9jn1x1mJqiJpQpMZ0azY4=;
        b=hNWZ3lDQBB9G0NfTmCUH5K27tkGRQQ+XAmdCjgXsoLk44TVXnSV0rZZArfsM7BjMNQ
         NzXAqYUV8bprqa1tDC9g84EyQd3o8jniWwkMjyQMMuqUkUkg6juIVGYjyUCbChTFmc7C
         Y9kAvvDPB9tH2tyarHnY6QH7UIi/z4zffPnrrS03ZW5T6FXyCYoeQLuQKPtpL84Si2yR
         MkQ+LN020YkVrk5A8hxNQQXfqHQiqTAV1n8zak/R17pXJIG49Dyerbvv/lIRePo4u9Cy
         r4NoX8Q2wawaT0cFfMSzhTg/VWuRq5m8tSgtaZnX2c9Uv2OXGulLsD2BxcAnqIFKNTgY
         /46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azJO16PBS0aaEX5vOfJpmf9jn1x1mJqiJpQpMZ0azY4=;
        b=B2diAksiJhiTOsmJYI7qRxTlYl0N9S6K9v0YwNtXxdqi9LJXegRVp0GZpYBd95UUWC
         fwqbs5UWQ/ZtG44PpNse7e6br/mG6w2o4gQkS8ICns67BV9s5u3iFt2KsVzpY5pD7BVJ
         GX1XqUWNOmjjiStmMFwgFaBrZJx/RwVT2WIPgpdGSkpy1JCMCBT13JElOQdgOI8QWOS6
         W3QIrkCp41Tn8mZOKT6BmBq2UqyGDv0/zWm3Rf+mOGMdk3E+rIaE6oU7FUjV/Jdt/7O4
         VBXZRdYv2FwQfqDFi5VFXceQnQZLFRbvMfuQGbyAa6M5skCH7j0tkKsRJmdZtCgTsp4/
         qFUA==
X-Gm-Message-State: AOAM530fFLVrBvaI8sxvBwGT/ccfaCbEHtS7ot+68bn+znDMYkPBxYwR
        QmJJQ94nnonMVDPqKQvQcvo=
X-Google-Smtp-Source: ABdhPJw/eckx03zVOJf2hmuiHkhQYzKLMML9PEB8kcVT0ZNZolUJSB9HB3aBM4EeNCzEcW2W6988dw==
X-Received: by 2002:a2e:9e04:: with SMTP id e4mr832311ljk.431.1629163805018;
        Mon, 16 Aug 2021 18:30:05 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:04 -0700 (PDT)
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
Subject: [PATCH v8 03/34] soc/tegra: Don't print error message when OPPs not available
Date:   Tue, 17 Aug 2021 04:27:23 +0300
Message-Id: <20210817012754.8710-4-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
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

