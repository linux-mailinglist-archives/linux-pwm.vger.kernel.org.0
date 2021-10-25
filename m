Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699DF43A7E3
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhJYWwy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbhJYWvG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:51:06 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DA5C0432CE;
        Mon, 25 Oct 2021 15:46:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u5so15045497ljo.8;
        Mon, 25 Oct 2021 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUl5NgtppOXN7aMrj+VJMJxgtwwCvjbf2LUP4ZJTZHk=;
        b=dM8HQOakT9lKwnlzX8oDz69wX5j1TjDnrC8XDQpJ3/grT/a5UOQT72pKmmWOeA+nw5
         hwS1AaicnlAS+Q3JuF+ijqvdVe4Un6yYFhFplrdKyeGItVsGKKcqDiC/7fQHeHpKybn0
         mi8KXBeDO3NELpLv4ar+VQwjOxNzn0V1FHmGK4K54a2y92lJV8T2Xs4iQadhxe1H5kx8
         949C5LowvQw9vTNqSPVd5lnBVNk3LEVCdQxC2NHFJOFUZ6q/S9pksA16cLzksRcTmCPm
         sc8c3tPIr72zAsfojA2oE0GaEnvZY0XTwZQWzo9WhpgugqOWsN43BXToZPztYXToBEiP
         J7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUl5NgtppOXN7aMrj+VJMJxgtwwCvjbf2LUP4ZJTZHk=;
        b=0zg2zSDegl4tp7i+bvht8eXRQpkx8U53cgDudvdOkMBVGOQlxZEdQ2mUXFXJQeEcML
         50ppoJEJ54N9ul3m3eOBC5KQs1e4lrFsz9svAvMcb4opz8US+end7skFpporsPAJMbUB
         b+zc66X90Ro8aumET6vQgIZ/tosR/OMLhMIqlZWPc5r8tBr4pYsUEycK1wGY29ML9mMo
         dw+jKnlEkyvskuMBd1sAVsjBeMGGW0jo9mbiHbNWGK7JYdQ2YPhe8nNzNg53DNWVNnUU
         xCVs4IqntNJuWCCatpaEKvIE5hsHV/ctiKSbY1AtexWrtGz5ozZEipX+yw4Ep5HVSgFO
         W9YQ==
X-Gm-Message-State: AOAM531homEru0Tl/zg2GDlz5rmSslwx8+VgXb0x0/VNWMSdH4ArGLP2
        8/+dolnOpJmUQ4yZW7dsbLU=
X-Google-Smtp-Source: ABdhPJznfzGWMyl02ihP30IcAisfmZn0lCnSMUeLm2QIKB/p5f1vAU2HQg628QiAR5z1U8DIPh6cDw==
X-Received: by 2002:a05:651c:556:: with SMTP id q22mr21587546ljp.314.1635201982105;
        Mon, 25 Oct 2021 15:46:22 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:21 -0700 (PDT)
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
Subject: [PATCH v14 39/39] ARM: tegra20/30: Disable unused host1x hardware
Date:   Tue, 26 Oct 2021 01:40:32 +0300
Message-Id: <20211025224032.21012-40-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
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

