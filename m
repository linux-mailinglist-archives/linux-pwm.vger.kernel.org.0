Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1D44FB03
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhKNTnw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhKNTja (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89979C061207;
        Sun, 14 Nov 2021 11:36:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id br15so33785965lfb.9;
        Sun, 14 Nov 2021 11:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nDfKTCKLqf9G6JM8mpqxRAZhh67bMGPfUrf1PMFZnmE=;
        b=U9lUXFzw+LhuaWEaxuUA4cjMsEa9q1fstmVYcSlHgJO8iH26U05+9jbVKkp1qKcKVj
         4GJu/hfHsAGvCSsQ1elS4Kmp1ZoKQlyblBEOVfwWxbRPGN8QubcTFqbt2m46InfpV8Ty
         apF40BJJS7LmsL1g0T5auPLBCrNUkWildIoaOKVVxn3LQmWIis5wWRArJwTVqUIAkXFK
         5arqBOR+gLRgN8IqK8Q61mEo0IhlqfvXZfnzzjWQMWkRu1cp+QhQVcQbe4FUFVBhTkNj
         xX2gnkkHvapCra28ehcOYyQ7XpI2UHcoQtUgdicJtWLysRSU3K3EM4DLSjCUPuSEFoL0
         9gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nDfKTCKLqf9G6JM8mpqxRAZhh67bMGPfUrf1PMFZnmE=;
        b=pfGX9TZR8iDMCf6hZ3JUUqHwEXtwk3Zt1oRBs4EoioYt3Ta1c+xEag5wyraPVvcri6
         gh1nzaVpzyUe0Mx7HmbFdh9HNTwqf8WpD08URWjZ6dLP8w0XZggIXbBjje1JnhEWtwDV
         gJEk3N8HJTGokh+JYUJy1V0WS7Zl7WSmvgNaTXO54oiwAWihzSpvz9/UFo4NAY18bwxn
         FSoj5SzAnXi5zaIHgzPKY4Yn/TVRcw0pS5g9QcICkGB8l8EtQM7ecHqp1xhI8nLC8JqZ
         J+l9QqFlcjZTiPVDgCu7UOk+eaHG5TeOacqYXM4fHodzVrpkI9deHq+JYm9xKW5VUf+w
         lpww==
X-Gm-Message-State: AOAM531qfOpf4M2lyTCoF6737Mv/LQeXA4/I2Dqg7A7Wlrla3aeII3TX
        0FnXCMxFLXWYuhYrTbPJb04=
X-Google-Smtp-Source: ABdhPJyusqVEM1bFGp/6ppX2dZiMhlD13GgviJ+ZpifWluNIUU5CQmBC6K8SfWpu+U2byKbaOvV4Hw==
X-Received: by 2002:a05:6512:152a:: with SMTP id bq42mr29718650lfb.109.1636918588958;
        Sun, 14 Nov 2021 11:36:28 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:28 -0800 (PST)
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
Subject: [PATCH v15 34/39] ARM: tegra: Add 500MHz entry to Tegra30 memory OPP table
Date:   Sun, 14 Nov 2021 22:34:30 +0300
Message-Id: <20211114193435.7705-35-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
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

