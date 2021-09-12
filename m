Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA1C408130
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhILUOg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbhILUMQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:12:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3BC0617A8;
        Sun, 12 Sep 2021 13:10:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y132so5131892wmc.1;
        Sun, 12 Sep 2021 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b4VIKmbdMAsFKCV4yDWvgLSko+6dlgzXMHJz6Zc9RO8=;
        b=WYlYCIHhy2AwhmX7L/AlwoRTFLRNk1Tw8KZ1cNf4Z2BgAk5gJUFFsDyiI8pBahl6s5
         CWTx8U8kQqpUC9d1Kf8UW3oIe3rg5dwKzaXaPmyg7lVuMXIceWpolx5f3LJKPUU87Bod
         3O7Lw+5Tjw2jpvqVMGOGBC9qMPlfztC63JbLV1QRppX1gNBIwTkmSK7wVXdpf2xO/RIR
         mKmyCaWGc1Dt2qQD3YL0XF5a3RJ5eAHEezXtRX5g508Tq82JkTJOiVmuZd4spjcZH8JY
         vwFG+NAvPyDBBTFXNnfKkQuETEecgQZy7+Tuc19oJuaNa11vCKL8YU+lmpseq99X/jCn
         Udiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b4VIKmbdMAsFKCV4yDWvgLSko+6dlgzXMHJz6Zc9RO8=;
        b=g5BRbmq/FhGjU41DhPUAR1Pf6OhyyBo6nnNPDE9L8Pyg/tvNXO9ITYprxpeKCLgwqn
         sK7T9nFAsZHvPnbTPfPXOZCqw3V0ZDq8jodb7f4270IL2z5ejyC+3AdfCr2eNXlu2ubt
         V4PfVlcZ7hpemwQjLcd7woqRbcG5+/m/rK4dxzVo59CZb7BJo5cyTTeYaNUzKb1BFT2A
         ABa/s4AROAu9HgOeoLq9IhBQu3wCuLxQpVXEGxnTX+1yoP+EWQe2zLHkYmoTjx33hzBg
         WXLFANN9RyAlfSivn6IQkefrd0o/3pXQzSrKhk1o3u7ssrl2Qlx2Tvp1DY/f7O038/nd
         Wpjg==
X-Gm-Message-State: AOAM531V3GDXbGj18w6YjJ8PdUb8QxnTmuFmC6HEuk/8HZTA03BQaYbq
        HncDkQWEc4Cu2hobdsltfyQ=
X-Google-Smtp-Source: ABdhPJwilD7uMmHHQ3Z72aCq5cGCPEr6BZMewoEYkEkrhgvxyF+teVEQagLVBgnOWAIx7IIGBJO7+w==
X-Received: by 2002:a05:600c:4e8b:: with SMTP id f11mr7626369wmq.165.1631477429807;
        Sun, 12 Sep 2021 13:10:29 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:10:29 -0700 (PDT)
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
Subject: [PATCH v11 23/34] media: dt: bindings: tegra-vde: Document OPP and power domain
Date:   Sun, 12 Sep 2021 23:08:21 +0300
Message-Id: <20210912200832.12312-24-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document new OPP table and power domain properties of the video decoder
hardware.

Reviewed-by: Rob Herring <robh@kernel.org>
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

