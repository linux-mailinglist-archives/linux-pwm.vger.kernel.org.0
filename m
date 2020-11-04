Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0F2A730E
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Nov 2020 00:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbgKDXtv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 18:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733031AbgKDXpC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 18:45:02 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9ACC0613CF;
        Wed,  4 Nov 2020 15:45:01 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 11so328100ljf.2;
        Wed, 04 Nov 2020 15:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tp9Yqrg3ShDWskF8okk8dyCecDIPmsRhr05c/t0mOxA=;
        b=NdQEwwdMZ/yJ8OPkD9uloM0o9Ugj2c5ieJ8wp9NIAg4kjdkCRrrp6Ude1JYuYIY5el
         cQ6T9hxjtsLOMggnGayrIGviTd5zP5TmyeAhR19Q9fq/kaJCXx7OBuhnTCeqhvfrSguA
         Rv4ks7q4ok1WjbMowL1f6z63nyrF+GmoOHEaAOUS5Fxj/XKxQW14PgoN1eaL3naw79IX
         aLkXyfnX2RmIvqjqe6TajXkhlx2gBtY4zoXde/weS+BuPwWztMj9RUDljXw++NeoX+21
         CEVubhkQvuVQyjMvWVwLaZygJnsPTNBVNntcOhwNXbHdInAh8pVfdkI0IC9sCjSOa/LH
         qo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tp9Yqrg3ShDWskF8okk8dyCecDIPmsRhr05c/t0mOxA=;
        b=GuYvKs6IlBYVuym5W3SCX+yQZ1ftk3igi0xdt38SS0m6NbWNVH9UjHo58iqG9ZSx7S
         8+EtPtZv7n/TNPH1/TSYH6juymFVKG6MABeAC2nVd6pGpE3BhHHC7gCyWCR0BAgsyQqi
         dmqGz0En9TgGB5qRE1ilWlUj9/jOsRUiEahDEp44OY/10vRUe0NaZsKkZm/hFkDGWCeh
         xdyGG9as7e81JU9U/EJ92EUohVi4g68T/C6AEaGW6b6Gm1bCoH55C1HROmzde7q6JmW+
         2rPMd7Lf1yGlJbpeXHvbajMqLTBxLD0bXjtKbFU+kQX5toPKxUQDepxM70CgPhr2r36o
         MGLw==
X-Gm-Message-State: AOAM533bgWQjzq69UbaRmaKF8yjnj6rhakPZ8GNcmSNN16tXRnjIQK8k
        VCgJmzpGp1ahG6az2jpdX0pQDfEslrs=
X-Google-Smtp-Source: ABdhPJyMzZS8yFbdeuBZmLEvuZcRuMGo/R+/3Gh1ylV5XVZW8SAuxgU/GPnV+T1exBhvuYiAMbxSkQ==
X-Received: by 2002:a05:651c:32a:: with SMTP id b10mr125604ljp.256.1604533500240;
        Wed, 04 Nov 2020 15:45:00 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m6sm640725ljc.112.2020.11.04.15.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:44:59 -0800 (PST)
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
Subject: [PATCH v1 03/30] dt-bindings: pwm: tegra: Document OPP and voltage regulator properties
Date:   Thu,  5 Nov 2020 02:44:00 +0300
Message-Id: <20201104234427.26477-4-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104234427.26477-1-digetx@gmail.com>
References: <20201104234427.26477-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new DVFS OPP table and voltage regulator properties of the
PWM controller.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index 74c41e34c3b6..d4d1c44a2c04 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -32,6 +32,17 @@ The PWM node will have following optional properties.
 pinctrl-names:	Pin state names. Must be "default" and "sleep".
 pinctrl-0:	phandle for the default/active state of pin configurations.
 pinctrl-1:	phandle for the sleep state of pin configurations.
+core-supply:	phandle for voltage regulator of the SoC "core" power domain.
+
+operating-points-v2: see ../bindings/opp/opp.txt for details.
+
+For each opp entry in 'operating-points-v2' table:
+- opp-supported-hw: One bitfield indicating:
+	On Tegra20: SoC process ID mask
+	On Tegra30+: SoC speedo ID mask
+
+	A bitwise AND is performed against the value and if any bit
+	matches, the OPP gets enabled.
 
 Example:
 
@@ -42,6 +53,8 @@ Example:
 		clocks = <&tegra_car 17>;
 		resets = <&tegra_car 17>;
 		reset-names = "pwm";
+		operating-points-v2 = <&dvfs_opp_table>;
+		core-supply = <&vdd_core>;
 	};
 
 
-- 
2.27.0

