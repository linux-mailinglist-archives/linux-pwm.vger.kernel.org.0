Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42A44FA89
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhKNTkA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbhKNTjf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:35 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F61C06120C;
        Sun, 14 Nov 2021 11:36:35 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p16so37617150lfa.2;
        Sun, 14 Nov 2021 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUl5NgtppOXN7aMrj+VJMJxgtwwCvjbf2LUP4ZJTZHk=;
        b=Yy/hKIPWSodlFNY6swmkyJRCh+WhikTA/dRazVz6AKJzSBnF2jYDK/5q6e3nxyFWIa
         BNKlRQlFq22odK1W1PGiaNYP8D03qiUr5dz93d5GLxOtr3836lr+B2ybo1dUtxep2Q5+
         wWY5SRlhPMbJUMk3k1giiLPXXqvyEReqHI+ZHyiZSKvPOHC0Ga7h5o34WdPeFT+cv6K4
         gVaTwurnwjzCi/TiPwC6GXWYDCG5rtamz60rquUksOhMtMdy2enNd45c3fYBZFYZ0O1p
         7g+Mb2mmw1/TyYCw9zZwDl30Sz2cX80v0eg6MGK7QD+3uXmOkcUD+W6luLzxZuzahx+8
         PtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUl5NgtppOXN7aMrj+VJMJxgtwwCvjbf2LUP4ZJTZHk=;
        b=S8EJ7ykZI+7Qyz9FILpn+dMDyuoQM5nxqUZtzkbgkYU21OJ88ZFwTrTzVzcgCwjrjs
         /qMmcrJ7uuYt/Mv+Wrepby+nDfhl5Ec17kg81XFXDBrTQH281kUT6QHkHCOa3a4mUmW6
         BmqNaWVxRD8KHuB9yjOJ32msLvH1J428jjihW12theVM+hrU87ToZscbuZsxgLgv7AUa
         +vY3q1EI1Sl6T052wx4Bi6dt7Z5SNDnWv9Kj2CZRRCIqGB3fIn6/v6gZ2onHPT51qiWu
         o2Z5zXYBuni4pLNVxAP/nnK14rJaCcSOzl3/6++R39qgjhdeKjjn8rzcSjWNwqfiZRl+
         2i9Q==
X-Gm-Message-State: AOAM533B40TMYdK3+pJG5/RX9FDbVe/sm0tmxGTLUYURZCiZlWCxn45l
        7uEFaVKIbrf8OuY9L+XSzz0=
X-Google-Smtp-Source: ABdhPJwkl0EgJTGgwtb6u0tc69twYwIooQnj94EJ74B6thW9WYrExV03eJqhkxli+EYJLyHT25vMkQ==
X-Received: by 2002:a05:6512:92d:: with SMTP id f13mr28203010lft.63.1636918593677;
        Sun, 14 Nov 2021 11:36:33 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:33 -0800 (PST)
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
Subject: [PATCH v15 39/39] ARM: tegra20/30: Disable unused host1x hardware
Date:   Sun, 14 Nov 2021 22:34:35 +0300
Message-Id: <20211114193435.7705-40-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

MPE, VI, EPP and ISP were never used and we don't have drivers for them.
Since these modules are enabled by default in a device-tree, a device is
created for them, blocking voltage scaling because there is no driver to
bind, and thus, state of PMC driver is never synced. Disable them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 4 ++++
 arch/arm/boot/dts/tegra30.dtsi | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 7b69ffc57abe..8010b40d7377 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -59,6 +59,7 @@ mpe@54040000 {
 			reset-names = "mpe";
 			power-domains = <&pd_mpe>;
 			operating-points-v2 = <&mpe_dvfs_opp_table>;
+			status = "disabled";
 		};
 
 		vi@54080000 {
@@ -70,6 +71,7 @@ vi@54080000 {
 			reset-names = "vi";
 			power-domains = <&pd_venc>;
 			operating-points-v2 = <&vi_dvfs_opp_table>;
+			status = "disabled";
 		};
 
 		epp@540c0000 {
@@ -81,6 +83,7 @@ epp@540c0000 {
 			reset-names = "epp";
 			power-domains = <&pd_core>;
 			operating-points-v2 = <&epp_dvfs_opp_table>;
+			status = "disabled";
 		};
 
 		isp@54100000 {
@@ -91,6 +94,7 @@ isp@54100000 {
 			resets = <&tegra_car 23>;
 			reset-names = "isp";
 			power-domains = <&pd_venc>;
+			status = "disabled";
 		};
 
 		gr2d@54140000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index c1be136aac7d..d961ce3761e6 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -145,6 +145,8 @@ mpe@54040000 {
 			operating-points-v2 = <&mpe_dvfs_opp_table>;
 
 			iommus = <&mc TEGRA_SWGROUP_MPE>;
+
+			status = "disabled";
 		};
 
 		vi@54080000 {
@@ -158,6 +160,8 @@ vi@54080000 {
 			operating-points-v2 = <&vi_dvfs_opp_table>;
 
 			iommus = <&mc TEGRA_SWGROUP_VI>;
+
+			status = "disabled";
 		};
 
 		epp@540c0000 {
@@ -171,6 +175,8 @@ epp@540c0000 {
 			operating-points-v2 = <&epp_dvfs_opp_table>;
 
 			iommus = <&mc TEGRA_SWGROUP_EPP>;
+
+			status = "disabled";
 		};
 
 		isp@54100000 {
@@ -183,6 +189,8 @@ isp@54100000 {
 			power-domains = <&pd_venc>;
 
 			iommus = <&mc TEGRA_SWGROUP_ISP>;
+
+			status = "disabled";
 		};
 
 		gr2d@54140000 {
-- 
2.33.1

