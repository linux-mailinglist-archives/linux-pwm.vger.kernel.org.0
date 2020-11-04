Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273D02A72ED
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbgKDXtx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733030AbgKDXpA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:00 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E114C0613CF;
        Wed,  4 Nov 2020 15:45:00 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 23so300100ljv.7;
        Wed, 04 Nov 2020 15:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyl6mwFdE15+t57cfnIytHG3Se38ipqIkKmYax6Z3Mg=;
        b=njurvPV7mYqVLXzLgzJMnQSBEnKE98oQKN4wK2dwEEIUDD7c6TRaSrw/9vciyz9XTc
         r0YOhwlcgm49SWqw8X9FydGAuWL+Unq90UFrxUtioI7SBGMjW3CXqGJug3RcWkA/s5yn
         XXyOv3T/tJxeU3RYP1xk3msgeJ/bxdzuK7URw+UQfBWoEZNEc1GTjxs+RSNpBzQz9Vvx
         T+BIa1HbzcDoiEXmaykCEP46kmiCL7189E89By+ope+D0L/TnKptWT+CPx5PYg+3BvjO
         jCwwYbCrTJce2YM5Px34gOTd06YKcy1A+u5agSc+RfC46gLInyC/nzLICGe4dtLWb3l0
         byVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyl6mwFdE15+t57cfnIytHG3Se38ipqIkKmYax6Z3Mg=;
        b=RzysN0s9ME/zA6hTQla/4rO8FwCMzOhza2uSoSA9LdnIUtIwP7iN85mCHDOOX/pnt0
         4h9I92IuTSsX1xjtjVvDd4Yuc6TJJ0tWyN7x0XVpBLVU9YUfw0uuCd/BMbgTVlMW3LaM
         Bjogw4MHZevLIgNiuhv+MfWaAF+14VU8QPGHRrPx662TiUXdc27fiYsszhNrN35o1HGA
         dDgsDNW7BW8+DycpyPKgOU2iKTnJWFrP8aVB47Pe4fcd8UZs+PCribOl5lxL1QVd3Rmc
         bp94irvAhosD5Pbcg+cwnk+Jv5/SLw1eOnTA2cUMiQnNpodiK0oyEd5W9qn9JjxHUwAk
         lCKg==
X-Gm-Message-State: AOAM532Uqfavlo+SX4sl6S5flL4bNM/WRzYOLpNntABJFoVvKR6Z90Vm
        qrOibD3NKaLvEACyB7tqjus=
X-Google-Smtp-Source: ABdhPJxyfUR5ytzjzRHO8KNVIYAL6OAR8JGEl8Y8hPTg36jXTHsV0rP3oD6HDz+Wf6BvR5Q/lM5EBw==
X-Received: by 2002:a2e:9909:: with SMTP id v9mr136172lji.429.1604533498850;
        Wed, 04 Nov 2020 15:44:58 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:44:58 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-samsung-soc@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 02/30] dt-bindings: mmc: tegra: Document OPP and voltage regulator properties
Date:   Thu,  5 Nov 2020 02:43:59 +0300
Message-Id: <20201104234427.26477-3-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new DVFS OPP table and voltage regulator properties of the
SDHCI controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 96c0b1440c9c..1beb0416ae5f 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -31,6 +31,16 @@ Required properties:
 
 Optional properties:
 - power-gpios : Specify GPIOs for power control
+- operating-points-v2: See ../bindings/opp/opp.txt for details.
+- core-supply: Phandle of voltage regulator of the SoC "core" power domain.
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: One bitfield indicating:
+	On Tegra20: SoC process ID mask
+	On Tegra30+: SoC speedo ID mask
+
+	A bitwise AND is performed against the value and if any bit
+	matches, the OPP gets enabled.
 
 Example:
 
@@ -45,6 +55,8 @@ sdhci@c8000200 {
 	wp-gpios = <&gpio 57 0>; /* gpio PH1 */
 	power-gpios = <&gpio 155 0>; /* gpio PT3 */
 	bus-width = <8>;
+	operating-points-v2 = <&dvfs_opp_table>;
+	core-supply = <&vdd_core>;
 };
 
 Optional properties for Tegra210, Tegra186 and Tegra194:
-- 
2.27.0

