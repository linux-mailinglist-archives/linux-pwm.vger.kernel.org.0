Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE2412C92
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351895AbhIUCpo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbhIUCDF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:03:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D2FC140922;
        Mon, 20 Sep 2021 11:12:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b15so52885481lfe.7;
        Mon, 20 Sep 2021 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vwz1Flib1olsdeaukDInX/oFq46RrVNNMLIcTSXb7Po=;
        b=d/8SR5QIcgc+jDwTQtsdPq+k7oz8LN8nm2hKa44BYP3xKD8eP1xglsSvu9u2Z8GdNw
         9ZYFSyWuKyyddfmH/XVzXertBV353KFlPLDtR5BQ1ZXR9lpYbD9JZsLWw4x6TYp4OYYQ
         RthRZAWri7TgAxJ9G0JJDZDISsLbF5IlP83Dmxa4mDtQsXwUTne3oXuFua5neFap1m50
         h+MqIvMgVMUBNxmf5413tepjwHAvxmGr/OuqAK2KUCScWzjcXUEHvs+wbBtmsZ+Lef2g
         YU66RBpbkuXxcLwygeobdrtPVjZDSlCXjK3IUHxkzPjPh+Nr+Uj7qc475Uc21UZJZoGv
         8cCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vwz1Flib1olsdeaukDInX/oFq46RrVNNMLIcTSXb7Po=;
        b=itx0p6LVb519Qa43VgKCe+3iy5odSKtWQeGHvlCEDia/Tdfa1+tFGC6tTXdLTcaKM+
         pg1uaLzsiZWkR2N3bSaER1Gjlrg/NeCv1CNvDCQ9FLojWNPJ3yrHyx4zZ1l2U/wEkFM0
         EKyjNgJ16TMnAQyJM3UVFbWYrG64Y9ZTrgwu5JCghxuoh5SaPWJTxB+X7i7dkS+Dmckv
         Ffl7tkI7Ej7LfmdLtuHV4FAfNPEkAqZK+K6wwdp/BNI6ZWGhd4dG1lArYQu/70iKlKdB
         qqrrXH4ZjMXoF9UIH6QfgaONL3QYggzLFwJDOQn+KQMIi1v5De3pGg943dgS1UKUnyLp
         p63g==
X-Gm-Message-State: AOAM533v56WB+k/gmkAU64tLeAYlt5rEjheYPT6s1wOST/De5DUwWHw4
        FqNzmQE79oVTQtsFrbq/E0c=
X-Google-Smtp-Source: ABdhPJzNPlq6lQF+IFC+d1ak283Ur0/ZIjKZaw8UqSG6j6aTEX6i01IVn+xu3KeRoB6jLyboTMrPdA==
X-Received: by 2002:a05:6512:2348:: with SMTP id p8mr5974751lfu.431.1632161548573;
        Mon, 20 Sep 2021 11:12:28 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:28 -0700 (PDT)
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
        Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v12 23/35] media: dt: bindings: tegra-vde: Document OPP and power domain
Date:   Mon, 20 Sep 2021 21:11:33 +0300
Message-Id: <20210920181145.19543-24-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
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

