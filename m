Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6A44FA84
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhKNTj5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbhKNTjW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:22 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1F5C061206;
        Sun, 14 Nov 2021 11:36:26 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y26so37505568lfa.11;
        Sun, 14 Nov 2021 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BgSCMMMjImw4OC6XX4I1D4jJZR1bPLAq5CznL/tG6k=;
        b=OEt5djRb5nWG2MCp4Qe+cEElHoKH+dMkZySFtFQ7mbqoC7WU5ES1aWbe2exy0Xv2Tr
         spmo6ALvP79D6tf9yhuLseaqLJeeeIucBBqsblE2xVph/sPdeUPBvZIU4caMLwM9EGW6
         fzIlMrWdHWDsnnCLRQo1FeAfvopLXcRN5WUC+DCZ5Xi81MA/6RqxLVPsdJB4xF/p0fbJ
         G4zEKKj52fnFAufMxp2y9CkERzahIcSHZoXfojt3y94fqtvTGdONRqnEnTHBI/IY7o72
         g3VNang9j7DeuBsnde5AIRcv74q/+M1Q3Gm2AXSD1sIjp0fWkp1ZjjarG+YiJMupUMN4
         p6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BgSCMMMjImw4OC6XX4I1D4jJZR1bPLAq5CznL/tG6k=;
        b=XZkjnnHsEYGlgcWOC5QQSOKwzeOJlSKxKFjlHisQqLVFjDPb5h0FNcHsuQ9ke9biB7
         zAkHBRIeV4SOtLRpNfkMJ/Bqdf9mnyI67yW15D7FdMO1RBsDTIBAo4iJhaS3/VzNnw1O
         8YfwSq6HDR431WP4JgwR8I2Z1ITGNUv3/fAzllTia+QGNmxpxv6KXLMtRtsnktpjfvgN
         EDULSbixBdeYrXIObh5urO5YhtZwXVnlbM0mxysjemobhVXboHw+Vxdl3ZhvkfFrhYDR
         ukmJgUwxsKDbUuKI0AH0IeGwflXbtbvRjIC6z0WbtRtfbwkeZjAK1M+Cfj6kflp8wPTD
         s5Gw==
X-Gm-Message-State: AOAM533e/Mi06y9QZCxvPDbTZUB0CeXWEyQy5Bg2KAUnCRtD9sAA8rLP
        0uZaKIjT7lCOMdMX7qYfM4o=
X-Google-Smtp-Source: ABdhPJznrtPcsIxT5uAX3z0HUQlgpv7GP03D/NkG6lRHRkk2VcuHQF/PSgD300iu3cIX8kylZRibWA==
X-Received: by 2002:a05:6512:3056:: with SMTP id b22mr21318248lfb.316.1636918585259;
        Sun, 14 Nov 2021 11:36:25 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:25 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v15 30/39] soc/tegra: pmc: Rename 3d power domains
Date:   Sun, 14 Nov 2021 22:34:26 +0300
Message-Id: <20211114193435.7705-31-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Device-tree schema doesn't allow domain name to start with a number.
We don't use 3d domain yet in device-trees, so rename it to the name
used by Tegra TRMs: TD, TD2.

Reported-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/pmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 1a55b8319d63..e1fae1a5e36a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2992,7 +2992,7 @@ static SIMPLE_DEV_PM_OPS(tegra_pmc_pm_ops, tegra_pmc_suspend, tegra_pmc_resume);
 
 static const char * const tegra20_powergates[] = {
 	[TEGRA_POWERGATE_CPU] = "cpu",
-	[TEGRA_POWERGATE_3D] = "3d",
+	[TEGRA_POWERGATE_3D] = "td",
 	[TEGRA_POWERGATE_VENC] = "venc",
 	[TEGRA_POWERGATE_VDEC] = "vdec",
 	[TEGRA_POWERGATE_PCIE] = "pcie",
@@ -3100,7 +3100,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 
 static const char * const tegra30_powergates[] = {
 	[TEGRA_POWERGATE_CPU] = "cpu0",
-	[TEGRA_POWERGATE_3D] = "3d0",
+	[TEGRA_POWERGATE_3D] = "td",
 	[TEGRA_POWERGATE_VENC] = "venc",
 	[TEGRA_POWERGATE_VDEC] = "vdec",
 	[TEGRA_POWERGATE_PCIE] = "pcie",
@@ -3112,7 +3112,7 @@ static const char * const tegra30_powergates[] = {
 	[TEGRA_POWERGATE_CPU2] = "cpu2",
 	[TEGRA_POWERGATE_CPU3] = "cpu3",
 	[TEGRA_POWERGATE_CELP] = "celp",
-	[TEGRA_POWERGATE_3D1] = "3d1",
+	[TEGRA_POWERGATE_3D1] = "td2",
 };
 
 static const u8 tegra30_cpu_powergates[] = {
@@ -3161,7 +3161,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 
 static const char * const tegra114_powergates[] = {
 	[TEGRA_POWERGATE_CPU] = "crail",
-	[TEGRA_POWERGATE_3D] = "3d",
+	[TEGRA_POWERGATE_3D] = "td",
 	[TEGRA_POWERGATE_VENC] = "venc",
 	[TEGRA_POWERGATE_VDEC] = "vdec",
 	[TEGRA_POWERGATE_MPE] = "mpe",
-- 
2.33.1

