Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6BF43A6EF
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhJYWsV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhJYWsR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6779DC061745;
        Mon, 25 Oct 2021 15:45:54 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l5so16401079lja.13;
        Mon, 25 Oct 2021 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uELYhg3LoYYilCBTSAEvuuZR4UEF9kvdsKmUqE/otlI=;
        b=Nw3/IIiKpiyz7AiQ6ai2nq1KUA4QxDcDCtWMckJwLyKG5Gxq32OBoSSQAQLbeRdFnu
         YorZC5XRyE5krSSgSCw8DC6ECVOvt6OZomLKTVmdkvGdjoTGnN918oZxwg5qo66Eszla
         2YplsNGal9SI1Sv2NIj+288U9YGLB29xDxTrY7q4aBHL4YCns6pOjDiAxyew41gpcfZC
         Y3jNeBWJovoZZ3L224ZMfo8vHqgUTRX38MGbXcCyqJaqaArJJgzMEwL61qk9XYHRCKDf
         dU80AfV7GQhviy6I62cVW1N9WC8qM25Hu5tPRTJRRRmT5rvIIVpuMKFXd7r5j4lpI/PA
         +P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uELYhg3LoYYilCBTSAEvuuZR4UEF9kvdsKmUqE/otlI=;
        b=NGSYLW4d0Xulvl5FleXqHBRenawOAX8awEo2g/3glK2m6SJ0LPx5D+7oi6qFA4c1Ft
         mjsqhgUYHdgkd/lW5m+6IhLxflOD+0BK2/y2SXUVzMFj8bzb0pXKpc/PcwueqpOq7jU/
         noLXVWb9Wbs9YXEXhRlao1VJ1NK6o7ZhhC77dM7caGYB608iTJQRwgATIZSui+vZ/J50
         Er74Jo4Q61BCk/+nZPjkTu2L+XGjaBCBVqMRz/lZSFRArtGBW9EKXlqaJ/i+VMXDTY7P
         DMeqrOJcd1VRmdZZJtsATqaWc0U3JZVWqk8NO9jvU2TmTfsteaojZzhiWNpE3HMShCVK
         6cEg==
X-Gm-Message-State: AOAM531D5+Ik1s4Oq9Xm14PW4nRwU/C8CNRXFhIfQqIzG8kMVDp4pmHx
        VlqrhKMn1Oym45KnJRBK1WU=
X-Google-Smtp-Source: ABdhPJyRyNXx7asst86YnQ18/+ZRfQnB/t4MlWMaa7Kdx8f0jPEkwI6kMj2W+rROBoq7NY2HQZVA+Q==
X-Received: by 2002:a2e:a717:: with SMTP id s23mr22667950lje.265.1635201952797;
        Mon, 25 Oct 2021 15:45:52 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:45:52 -0700 (PDT)
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
Subject: [PATCH v14 07/39] dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and GR3D
Date:   Tue, 26 Oct 2021 01:40:00 +0300
Message-Id: <20211025224032.21012-8-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Memory Client should be blocked before hardware reset is asserted in order
to prevent memory corruption and hanging of memory controller.

Document Memory Client resets of Host1x, GR2D and GR3D hardware units.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/display/tegra/nvidia,tegra20-host1x.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 62861a8fb5c6..e61999ce54e9 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -19,6 +19,7 @@ Required properties:
   See ../reset/reset.txt for details.
 - reset-names: Must include the following entries:
   - host1x
+  - mc
 
 Optional properties:
 - operating-points-v2: See ../bindings/opp/opp.txt for details.
@@ -198,6 +199,7 @@ of the following host1x client modules:
     See ../reset/reset.txt for details.
   - reset-names: Must include the following entries:
     - 2d
+    - mc
 
   Optional properties:
   - interconnects: Must contain entry for the GR2D memory clients.
@@ -224,6 +226,8 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - 3d
     - 3d2 (Only required on SoCs with two 3D clocks)
+    - mc
+    - mc2 (Only required on SoCs with two 3D clocks)
 
   Optional properties:
   - interconnects: Must contain entry for the GR3D memory clients.
-- 
2.33.1

