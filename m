Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F26418C64
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhIZWpu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhIZWoW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:44:22 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385A1C061575;
        Sun, 26 Sep 2021 15:42:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id u8so67669922lff.9;
        Sun, 26 Sep 2021 15:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=798UaN2O7BsVLG2b7m1c5jRBaYmhXVVyGNLo4voHgAg=;
        b=pUEPNMkJQr5NWNa19a7ZyiLQA/ce5o3cooLHQciCTfn7GDvRH6VTTTdD6JKIL4UrmV
         rrVbAP/wvZWx2J0K2faasFGjzdi1o5y8ezrQGpvdeJIrszdl8ecw8YwEyqDA1MvPawmp
         0PJ6yycgmc045AsLdgLtVuy8KAgDTFddIzR6xi7P9lXt8qD3EuLmDuxPVs1BY89/wIsV
         /jXKmHsXeSDJelnpvglMhN0zjnmKIQw2G47uxtN2JI6M3VthPUoP+q02lvNETHoucFHI
         /JiJckf1QnJt46IeCFDl4rZymcy/0KL5Fowewmc53xoffriJ72cInIZPrF2f831BKUnf
         nYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=798UaN2O7BsVLG2b7m1c5jRBaYmhXVVyGNLo4voHgAg=;
        b=Zu84eukA81XCjgkbgYfoGU94+Pt4xqt7wRqJoJa30pA3uBm0G8ncCREag+WVtYCQTj
         RwjPvxIlP+ltsRXarW6eiwAemq34T38dZ/PScYtCaUAWlnnq9rJKmmTG36qvEH0OZKUZ
         YPbqoFvpGLRF87kQm14bbgr43q7KaqdDOmaTz6vB0r1usxZdwvM7Go4nSwvXIHve017L
         BDD47LGH1F3o4kzqbGuBqGiCQweJh2ZJ8J2ZEmoSjYo//dMySjqFdzWk1VwWFKWIJe8W
         Mtt2lvQ6IOqMgrAfFc7iqsAJgeSTuGXwliP5RAgy7eXUa9YMbzCCdi24I6OjbCiq87nq
         oB3g==
X-Gm-Message-State: AOAM533lHhjiosFpUuReWpp7rJz1dp8wK+Qd+3BiAyctE87fVdcy2HaT
        1iZmVZap2zW0tQs7wvo9qM0=
X-Google-Smtp-Source: ABdhPJy2rzvcK/EpmNkU06oa1ux+Bax5jzq0bb0T3/Dhw3FjdBPfDZTPA9CjLuSUJfe3zuDn+9yAGA==
X-Received: by 2002:a2e:585c:: with SMTP id x28mr25230381ljd.508.1632696163660;
        Sun, 26 Sep 2021 15:42:43 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:42:43 -0700 (PDT)
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
Subject: [PATCH v13 15/35] drm/tegra: vic: Support system suspend
Date:   Mon, 27 Sep 2021 01:40:38 +0300
Message-Id: <20210926224058.1252-16-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
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

