Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0078A3EE26E
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhHQBbF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbhHQBaq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:46 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBE2C0613A4;
        Mon, 16 Aug 2021 18:30:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n6so30168065ljp.9;
        Mon, 16 Aug 2021 18:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l81mhnshT1jOAdUmVwFRhCr1kUhvtG3KJjdpKuzou0A=;
        b=O20xXbpstS1K4NNNeIVcVXjBhGfcu2e5nNEJ5pDBYki1kIj4o5ZYIjru23tbYEGsyz
         r52Hf/+40WfMUNMEhvN72pmXl0XoPmEVNOOv8yUg6XmPcR6PW6ztKlm3dNhyGBEbaa7Y
         r09HKxsCu7pdY4G8ZxhjFl3L8Ms3XExvbjVxLlZReoy9dlFs4piRUc4FJoCVKmVfN6W+
         DvcxU+uSjJq+dyj9XuEHRIqCDane++wPVshyPW0s4dKK/D0v5UTDlCWSDUB7FBD6VcAn
         DSh/YDly+w0E3m8BW/O1X+usNpnRL02EHD/izGWDARukpTDuSfyZm9EWXzEP8jfQItxy
         Nwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l81mhnshT1jOAdUmVwFRhCr1kUhvtG3KJjdpKuzou0A=;
        b=XHRbwMOnA6vMyiRsCeSaRkSjiwyXH+9+p4aBh5fGDaJktwXH67WKcw4Ig3zq8mAg7p
         M2iecjxhe63yjkBX2ZN3vixJD7ZnUqrflS+HpM4/ahu5PKxyjqmXk3zi8t9+iF/IKk+x
         JiSdT1FqV5330CQPG05kLeS9catEyw1RSqs8W2ZNrzZXv4GpWM3u2Cj0LZiDemQl5NGi
         qGcnnLwTJh2tgHqdoXgieo8nuS4/jH1qup1TRYlH01orAvkX2TopyffQakbOe59vjTmd
         82nv0oe5N6/L1bk2tl0/da0OwnliDpXJ6Ew+8QM6OstvzfJLD9a6ax2linDALlqhG2IZ
         V2yg==
X-Gm-Message-State: AOAM532iZwnLwTQYOx7wZdXgNiip86ANZAYG3kv4S4PPg5FNEv3OmIP8
        kmDSH/v2UC+vLeAPcy4SGtY=
X-Google-Smtp-Source: ABdhPJxhuZkUDfR36UaYb9aumi6B1iVfEXbSXNsdxNHhblZQHD87dEi21/QGQqgVOj5+f/BnA4ZsHw==
X-Received: by 2002:a2e:8147:: with SMTP id t7mr859862ljg.126.1629163812262;
        Mon, 16 Aug 2021 18:30:12 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:11 -0700 (PDT)
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
Subject: [PATCH v8 09/34] dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and GR3D
Date:   Tue, 17 Aug 2021 04:27:29 +0300
Message-Id: <20210817012754.8710-10-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Memory Client should be blocked before hardware reset is asserted in order
to prevent memory corruption and hanging of memory controller.

Document Memory Client resets of Host1x, GR2D and GR3D hardware units.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/display/tegra/nvidia,tegra20-host1x.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 62861a8fb5c6..07a08653798b 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -18,6 +18,7 @@ Required properties:
 - resets: Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
 - reset-names: Must include the following entries:
+  - mc
   - host1x
 
 Optional properties:
@@ -197,6 +198,7 @@ of the following host1x client modules:
   - resets: Must contain an entry for each entry in reset-names.
     See ../reset/reset.txt for details.
   - reset-names: Must include the following entries:
+    - mc
     - 2d
 
   Optional properties:
@@ -222,6 +224,8 @@ of the following host1x client modules:
   - resets: Must contain an entry for each entry in reset-names.
     See ../reset/reset.txt for details.
   - reset-names: Must include the following entries:
+    - mc
+    - mc2 (Only required on SoCs with two 3D clocks)
     - 3d
     - 3d2 (Only required on SoCs with two 3D clocks)
 
-- 
2.32.0

