Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87FB418C0E
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhIZWpC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhIZWoc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:44:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9961FC061740;
        Sun, 26 Sep 2021 15:42:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y28so68075171lfb.0;
        Sun, 26 Sep 2021 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vwz1Flib1olsdeaukDInX/oFq46RrVNNMLIcTSXb7Po=;
        b=n17OwVdrkj7Y4L1R9tjfVhXv+cgwadphs0AjRe5Y0i2moNAviWCc+UoOV07BeJQNSw
         wtNY9+e9OLovtBu/NaoV3b5ooNZVDcG+xZ9tuQhutTYA+Rcl9FT2OvtbQRwy5ibph0FC
         XuaB/RuBlOniAOKdvOW4l8FBlbQ7RL3sWHx6C/WSRC5PfRXKQkHL1wZoEQWQRjAfQOsB
         cVfvlnyQutOOdWgZVAlF4MA3szcxGtJ8RwvIdSZ5HS/vTVW7clZt8u8GSq32GGlVZuJw
         wS42eP0Zwlm9VrzTyg7rShqDmtQKB6aelU/z5CIf7SIxV37CVsl423DdH5TtCapRhcMz
         LqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vwz1Flib1olsdeaukDInX/oFq46RrVNNMLIcTSXb7Po=;
        b=ben211D8H+HIQaRJAeAmgtxVSUl/umg0rNE9haXg2brWPhu/Jx618Bq84a2qeNrM6/
         rGWSgtl8BP1z0l8kUSuiqq8bETl5QWxoS7tUsoufQdUYjfs/r/uwsrtDBozCRHLhj+XK
         GtseiurB5MzfYTJUJOsEnOy5OPEIa5ro0PK6v24WUKeK8Bj/Ubc3zSHydHLIXdamJK3B
         rey2JwjnBP1Nr/nzwGAzHxhSf0dW4cTeo/PjmTkbiJsFfnx98J7HAXfnpiNRGiYfQz24
         Uu9kp2nrpAP6AZX/9pvR9hpTSYC+iwM9030/zyWu6B7uEfFAtNbBWb5moxOENRwQ03T7
         XN4Q==
X-Gm-Message-State: AOAM531+JRcanPAzfdZwwaW2jzXMV7J2Ww27KuY+ihuRKDvNSdBxnfuO
        pj3Xg7OzBKSzczjlle24ycU=
X-Google-Smtp-Source: ABdhPJyAW8fEFRtMs4lMIldQGDgrGCV7P13WNKC2dzvx+S/aHC5HbOsIUdN3yZj6Iybbiic2V/vFHg==
X-Received: by 2002:a05:6512:3caa:: with SMTP id h42mr21438411lfv.349.1632696173061;
        Sun, 26 Sep 2021 15:42:53 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:42:52 -0700 (PDT)
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
Subject: [PATCH v13 23/35] media: dt: bindings: tegra-vde: Document OPP and power domain
Date:   Mon, 27 Sep 2021 01:40:46 +0300
Message-Id: <20210926224058.1252-24-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new OPP table and power domain properties of the video decoder
hardware.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/media/nvidia,tegra-vde.yaml  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
index 3b6c1f031e04..0b7d4d815707 100644
--- a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
+++ b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
@@ -68,6 +68,16 @@ properties:
     description:
       Phandle of the SRAM MMIO node.
 
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property,
+      which is a bitfield indicating SoC speedo or process ID mask.
+
+  power-domains:
+    maxItems: 1
+    description:
+      Phandle to the SoC core power domain.
+
 required:
   - compatible
   - reg
@@ -104,4 +114,6 @@ examples:
       reset-names = "vde", "mc";
       resets = <&rst 61>, <&mem 13>;
       iommus = <&mem 15>;
+      operating-points-v2 = <&dvfs_opp_table>;
+      power-domains = <&domain>;
     };
-- 
2.32.0

