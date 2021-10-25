Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD343A7E8
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhJYWvf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbhJYWuL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:50:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166FC0432C5;
        Mon, 25 Oct 2021 15:46:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w23so11207755lje.7;
        Mon, 25 Oct 2021 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDfKTCKLqf9G6JM8mpqxRAZhh67bMGPfUrf1PMFZnmE=;
        b=DQFtiZJRzwYyQSiSot3eZPc+auvU6R1hIV8c2YYOgx26qKiphx3R+A0na2iyUTakrn
         Sq0hupn9tVdOtC7rxxuDeDialesAmRmSSuvDQV5iEVe6yTMDGII6voTtCHqkVqsPEwph
         63jgt5PFcWTSfyd3eC2/Kxc2bUINZlHjn8GtFk2r/OjtxSPzQlS6SXf6UZ2e4f+54eJR
         axJqj+c5qGuXI0vRosopHLIlmF9dBZMeTvL93zMutgyEacTwYla5w95Yq+cVctJGmch1
         zyxkZUjDUI7cJEcTvE2mDLcekGTndgo61UWOcbZ0naRb6UVpYY5Featjhd0LpP2owRJg
         vkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDfKTCKLqf9G6JM8mpqxRAZhh67bMGPfUrf1PMFZnmE=;
        b=y8UHDdszcW7rTQtkLEGgUVS1kePDXrDoZqVVpVMUSAkaSJnki2ZDOCHBXNJWSK9VJA
         /KmyTKAXZAmJqQP/P7cxd0V4ABqzXHDhROc7tmnV0AYsqumIrO2AhoUlWHbEbc5ypupL
         HjPUeKVjpr3rqiDyxl/vA7CpbkUllwD9JuZ5iYAvPV8YsZodoHy3IZH3nALNmxzibM0m
         Cm0JYkH4C7gunKUjEjHSRrbSwviGhKnUixTy0Niz6145TkCZnrmtjONV+YVj4jWYFuri
         f4yrWyoPbLh9Z7KojzsXveilvYlbPoY6vJ4QIzvv4SGlH5Zsh4mvLdE2ckwJYeLTZBzY
         JU5Q==
X-Gm-Message-State: AOAM533DS+rU5O9SkZTvjyM2bdctfMlEecU+BUsLET1EKtgtERziNmQN
        IuVlfwxXn+gibtN6JrYwffj4IvDIWys=
X-Google-Smtp-Source: ABdhPJwFpsaCaIGEu9dje2JzGoJR9fM9gDJwA22FgCRyQuGUDNEs8U9CXXplL2hhn74NH3CczfiiFA==
X-Received: by 2002:a2e:4a0a:: with SMTP id x10mr21689639lja.146.1635201977441;
        Mon, 25 Oct 2021 15:46:17 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:46:17 -0700 (PDT)
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
Subject: [PATCH v14 34/39] ARM: tegra: Add 500MHz entry to Tegra30 memory OPP table
Date:   Tue, 26 Oct 2021 01:40:27 +0300
Message-Id: <20211025224032.21012-35-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Extend memory OPPs with 500MHz entry. This clock rate is used by ASUS
Transformer tablets.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-peripherals-opp.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
index ff25350869b3..af9640401402 100644
--- a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
+++ b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
@@ -216,6 +216,18 @@ opp-450000000-1250 {
 			opp-supported-hw = <0x0008>;
 		};
 
+		opp-500000000-1200 {
+			opp-microvolt = <1200000 1200000 1350000>;
+			opp-hz = /bits/ 64 <500000000>;
+			opp-supported-hw = <0x0007>;
+		};
+
+		opp-500000000-1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <500000000>;
+			opp-supported-hw = <0x0008>;
+		};
+
 		opp-533000000-1200 {
 			opp-microvolt = <1200000 1200000 1350000>;
 			opp-hz = /bits/ 64 <533000000>;
@@ -347,6 +359,12 @@ opp-450000000 {
 			opp-peak-kBps = <3600000>;
 		};
 
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <4000000>;
+		};
+
 		opp-533000000 {
 			opp-hz = /bits/ 64 <533000000>;
 			opp-supported-hw = <0x000F>;
-- 
2.33.1

