Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9AC408099
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhILUMZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbhILULu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:11:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559FC06175F;
        Sun, 12 Sep 2021 13:10:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q26so11306212wrc.7;
        Sun, 12 Sep 2021 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=798UaN2O7BsVLG2b7m1c5jRBaYmhXVVyGNLo4voHgAg=;
        b=MeT9W24Jr2f9RvjUC5EbBHXQOyy115v+4M/+W1kU/o08i4o+XtIkF3zaTkNILlsp3n
         QZ2vhRuQXCvwm1YePWgyHa3xQfnXKyksuI6Oeu9eTPhdhHhWOFCW3QPI3nmBrkq1f6ff
         JbG1uaz8WrgNCEHiPIAkUsNaBI/Ui2bxy2QuvcKSNJjxqh7yAe1S3IjEok4s4epX8HXN
         y+e8MqPONDOga34MZsm9+g8TIov9EiuV889Gpmb+rsWKXS5rk1ZJHZM0VpUkd/iuTVIn
         DdvPqlVezTjnVrgbYvjCurd9bHHM5//w4NKpvYVBWyJ4Gq40Ow8SphSrrZbPfgX3gT/a
         PFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=798UaN2O7BsVLG2b7m1c5jRBaYmhXVVyGNLo4voHgAg=;
        b=miktXNJNzDAGx7KsftoaSEbNeeI5M7KastoqBvTDUatKpMLWA53L+Kz84er5ZcJ3Ra
         791G9rAvwpyxawUwCeTGesAJbp1St2TrbiPeXyv/SchrMKIfrl2ZNNBN//5aTb3N6UxO
         q2YDMCOR89x6MJm1mLb5Z5hZQJ7VX0WgX9rRVNcAltcyLiMi/f424qM992RHZBZi+73V
         jcsjuqpvh9JIZhlYYVo8dXpWvMyHqhLOlHeTgmvpzjV1hDXFTezTqxz0H0tjbd6iFjv5
         Ut6GaaNTg9wV3HsHijA/kI7Qb8PjrCfisSj3u4SqCdkQ+qBzYu2E6BkLIkUrQbXCAsbK
         ko2A==
X-Gm-Message-State: AOAM5336MQOwcTZ6dmqcn8fOLXkj8C1hM0sj0l+cti+QYXIlHCrqEW5s
        QQmXMBFK2ZdU40nd+736IR8=
X-Google-Smtp-Source: ABdhPJzu7MzyAyEOUCRr750amNJVBtVQ2utB+Xjt8OlkPvZv2p6LYKW9k094ppdCb1q26Tn+61kFew==
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr8787352wrs.183.1631477410012;
        Sun, 12 Sep 2021 13:10:10 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:09 -0700 (PDT)
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
Subject: [PATCH v11 15/34] drm/tegra: vic: Support system suspend
Date:   Sun, 12 Sep 2021 23:08:13 +0300
Message-Id: <20210912200832.12312-16-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hardware must be stopped before system is suspended. Add suspend-resume
callbacks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/vic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index c02010ff2b7f..359dd77f8b85 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -315,6 +315,8 @@ static int vic_runtime_suspend(struct device *dev)
 	struct vic *vic = dev_get_drvdata(dev);
 	int err;
 
+	host1x_channel_stop(vic->channel);
+
 	err = reset_control_assert(vic->rst);
 	if (err < 0)
 		return err;
@@ -517,6 +519,8 @@ static int vic_remove(struct platform_device *pdev)
 
 static const struct dev_pm_ops vic_pm_ops = {
 	SET_RUNTIME_PM_OPS(vic_runtime_suspend, vic_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 struct platform_driver tegra_vic_driver = {
-- 
2.32.0

