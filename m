Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24C73EE242
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbhHQBam (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhHQBah (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A337C061764;
        Mon, 16 Aug 2021 18:30:05 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id n7so30325981ljq.0;
        Mon, 16 Aug 2021 18:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIIbTdgH+pfcdvXJM3PhuR8TNGLF8k42ZN+r4fmcuaM=;
        b=TEvCrByVx93JYtGn78GAWLt1bT9YxkCjzq93w+IwY4bwmNpr8DkqPH5ayGAOGtfdBV
         fa+PhOX8+Qv36UXTnCsov+5UtufMjjh1IQTsr3L1FNx5Z/9b8e5LHDnkh8zZiizJ1WxP
         72DYqArQVIy6I7VydaLBJNQPAL6zLFmYydaw4GQya90iFoiojJno0XaF7wd33gN6EgjY
         ToIrEapwVxW6bFJckYH1XQchGwszb7+T5HWZyUwfD27L/z4VoG6qChBzAuhbyJOqWUVj
         x5NU/f826zMfHMQZEfhLHMO5sTHgiqC+FBkhDgX0rwRgKwkKkbgbO3jXereixuNrMAkT
         Mieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIIbTdgH+pfcdvXJM3PhuR8TNGLF8k42ZN+r4fmcuaM=;
        b=O/lGxw0NytYKB9bacwn6L2Vgd8dhvRhZm0g1sq9HrfRuaEO5umXPOMkslj3AGxX2kv
         v/6ANOznx+sfr+ILCwvp/YJxQgfZy+0Tn41ZQ9z7H3Wsmno01iwrWoEQj9SfWK0Fj2hN
         4Ydj98vadd85JP++HwRAJ/MsF0en/UzWQ+VyInxLwSoYFOtgseJHx5EL35YPR5+58fzM
         lzn4BX81Mj7bRTvwgTBtEYZXzEvEvAiqPT9+QcsWxQvqCTMs0g0UTGvCnDFORLurFABY
         /3J2o21tOQk5cfEThyV1xnsGZSvTUWdBMksMDcvF+oEaxFHcvzjnbC+iWg9o5E02u/Dm
         ePnA==
X-Gm-Message-State: AOAM532C9ZYeiuBxmMW5rAMgheZqoxbh7jgCB1Q87XhWj7fcLoDziX4J
        4/huWAyp5kr5mqhi+6dhst8=
X-Google-Smtp-Source: ABdhPJzx2Bm7jx/Cai6FZzL4KCpIVLSHzlBwFdZrnxkJdr2Ws/VmVzSpQZLFmKjJZCDYkbxY7twb+w==
X-Received: by 2002:a2e:9c16:: with SMTP id s22mr863254lji.255.1629163803825;
        Mon, 16 Aug 2021 18:30:03 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:03 -0700 (PDT)
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
Subject: [PATCH v8 02/34] soc/tegra: pmc: Disable PMC state syncing
Date:   Tue, 17 Aug 2021 04:27:22 +0300
Message-Id: <20210817012754.8710-3-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Disable PMC state syncing in order to ensure that we won't break older
kernels once device-trees will be updated with the addition of the power
domains. Previously this was unnecessary because the plan was to make clk
device that will attach to the domain for each clock, but the plan changed
and now we're going make a better GENPD implementation that will require
to update each device driver with the runtime PM and OPP support before
we could safely enable the state syncing.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 50091c4ec948..fb8faf7b226a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -360,6 +360,7 @@ struct tegra_pmc_soc {
 	unsigned int num_pmc_clks;
 	bool has_blink_output;
 	bool has_usb_sleepwalk;
+	bool supports_core_domain;
 };
 
 /**
@@ -3041,6 +3042,7 @@ static void tegra20_pmc_setup_irq_polarity(struct tegra_pmc *pmc,
 }
 
 static const struct tegra_pmc_soc tegra20_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra20_powergates),
 	.powergates = tegra20_powergates,
 	.num_cpu_powergates = 0,
@@ -3101,6 +3103,7 @@ static const char * const tegra30_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra30_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra30_powergates),
 	.powergates = tegra30_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra30_cpu_powergates),
@@ -3157,6 +3160,7 @@ static const u8 tegra114_cpu_powergates[] = {
 };
 
 static const struct tegra_pmc_soc tegra114_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra114_powergates),
 	.powergates = tegra114_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra114_cpu_powergates),
@@ -3273,6 +3277,7 @@ static const struct pinctrl_pin_desc tegra124_pin_descs[] = {
 };
 
 static const struct tegra_pmc_soc tegra124_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra124_powergates),
 	.powergates = tegra124_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra124_cpu_powergates),
@@ -3398,6 +3403,7 @@ static const struct tegra_wake_event tegra210_wake_events[] = {
 };
 
 static const struct tegra_pmc_soc tegra210_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = ARRAY_SIZE(tegra210_powergates),
 	.powergates = tegra210_powergates,
 	.num_cpu_powergates = ARRAY_SIZE(tegra210_cpu_powergates),
@@ -3555,6 +3561,7 @@ static const struct tegra_wake_event tegra186_wake_events[] = {
 };
 
 static const struct tegra_pmc_soc tegra186_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = 0,
 	.powergates = NULL,
 	.num_cpu_powergates = 0,
@@ -3689,6 +3696,7 @@ static const struct tegra_wake_event tegra194_wake_events[] = {
 };
 
 static const struct tegra_pmc_soc tegra194_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = 0,
 	.powergates = NULL,
 	.num_cpu_powergates = 0,
@@ -3757,6 +3765,7 @@ static const char * const tegra234_reset_sources[] = {
 };
 
 static const struct tegra_pmc_soc tegra234_pmc_soc = {
+	.supports_core_domain = false,
 	.num_powergates = 0,
 	.powergates = NULL,
 	.num_cpu_powergates = 0,
@@ -3803,6 +3812,14 @@ static void tegra_pmc_sync_state(struct device *dev)
 {
 	int err;
 
+	/*
+	 * Newer device-trees have power domains, but we need to prepare all
+	 * device drivers with runtime PM and OPP support first, otherwise
+	 * state syncing is unsafe.
+	 */
+	if (!pmc->soc->supports_core_domain)
+		return;
+
 	/*
 	 * Older device-trees don't have core PD, and thus, there are
 	 * no dependencies that will block the state syncing. We shouldn't
-- 
2.32.0

