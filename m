Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E9418BB0
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhIZWoM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhIZWoI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:44:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA7C061570;
        Sun, 26 Sep 2021 15:42:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z24so69310081lfu.13;
        Sun, 26 Sep 2021 15:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azJO16PBS0aaEX5vOfJpmf9jn1x1mJqiJpQpMZ0azY4=;
        b=CoucEmqsnHASEscWTvzWVMvPJx/TXgnqdGGuNIJPcO7mu88S+vh9AL8t1Ns9UQxBZI
         XYyLpgOhCbVihPd7RcTvlnEoo65EfnV9OkGmOWggm/JcV3T1Fkb0hoAtZ6o6YKD3Npjs
         H//NAJ7gp0wGVNHcKIrcVsCMNFUeMp9gBjixftFjxRLmL/Z2XsgUHsToJoIsQ91a9Rqp
         oV4EC8FnuEN/OmtmYdJoT+oiy2ExskpbLunYJ0pVQgGZEgVTuEE0BW+mpUw7+stYklh+
         wmG9/SuwJ+Co+IWoOjaOCa7e/0oMC36ZRTjBUO3zNyO8S7/jRGHaFUs2KkxQteQZYgcd
         hiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azJO16PBS0aaEX5vOfJpmf9jn1x1mJqiJpQpMZ0azY4=;
        b=ffznDfc+x4DXmvETs1zDpbpAhX7tUaERImcuapvE3C8tCFp59ALEdRA3o395MZQnku
         kVuduABmQnDN/i1vqADaGMFROw6I8EGKX6EHQBA9fmNbKBhpwSJWY3C5inw+0+Xl824I
         2jCh41HRH0ffb6Z1HWYej3mh+S6CrZ0Sdbf9+4wZmuoXyDzf/LRFCLp9ZEb0rAJryEYn
         UaVmjf6YznIo7hbeaZtzjprXwGGb+HIUPq8veZnfbqLl720lTPrLoVJR+uqE7qJmSoig
         +WNhZG5FNk62C01bPf7DD3OKzeUzNggGWAAuyqwajYZ2UB2zwy6wftEZ6XqjyKnIRr40
         e2sw==
X-Gm-Message-State: AOAM533ZLhiVY0xTd0fQPQvnTEOaDq6gPsqxnHv2564GbKSlVbGAcvJi
        ULCPBFR7kWVeKEGnN2HKx74=
X-Google-Smtp-Source: ABdhPJz0FoBQucMxJTKUygz8qqUX0VYeANYjoqsIq2ZxRXzP7B+OIO/7ur7ISRYBXcphepoeMGZavA==
X-Received: by 2002:ac2:5458:: with SMTP id d24mr20907289lfn.385.1632696150192;
        Sun, 26 Sep 2021 15:42:30 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:42:29 -0700 (PDT)
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
Subject: [PATCH v13 04/35] soc/tegra: Don't print error message when OPPs not available
Date:   Mon, 27 Sep 2021 01:40:27 +0300
Message-Id: <20210926224058.1252-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
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

