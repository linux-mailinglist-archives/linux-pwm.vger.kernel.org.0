Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA711418BBA
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhIZWoR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhIZWoO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:44:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DB8C061740;
        Sun, 26 Sep 2021 15:42:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b20so68762861lfv.3;
        Sun, 26 Sep 2021 15:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6xrHF0JDm5yvfpc+kvah6ca7+v53gn0YbmmBZcvayY=;
        b=KTBp8TCCGq/owdZuVTDixCYSrDTCvyoPGPhnTXQZDuyWzz1TnDVS1NTdeLBjT4nZFf
         VFgQQq1+5AQ4fHNtht3Ss9wSyzSUPvewj0d1+bChvvdGBsW4NfmX4wac3oZu7lL2lgzi
         Ejg7kodc+O/JVWOO/B/u+OFYXGcbl10gKu3mynRYp6IvbsCg+pEc86qOeT3+lgtZz69a
         z02amcamXQh/vp9CQ20yvtkGytkZrhUdSleZ0lk69p5jH9GPM0Iz837+RbLJWQuyztOM
         0ySBuA7ZUlKBLUOBqdvMQ+RtBlP693qwqk9/ee0482ONvCEAQxg66CalLRktDkvsnJj3
         8TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6xrHF0JDm5yvfpc+kvah6ca7+v53gn0YbmmBZcvayY=;
        b=6LYl4mYEFYN8Fg0ukMe8R4ZZUjZNPq3vNqNpGedwshNwc5iXuA6lQNU/a4n8qIiQcl
         4xtlYfirbk/p4vw1TkC0mNb1fO8C8UKlSSn9SSkyVqT8ufh50SXEZMVDYXXgQ5gXI3dC
         LcfhHYHGrEc0/YTAH2swGYULo5/0nS0su9l4531wZtbiiQIyoTGEHRIm3DbyX1CuzZzT
         IF9bWDWaPnrNdfcaMfqeuokpxxn9Zpb6hncFR1vCg/GZSSMXlryrI6P2n5Q8YCFrrviq
         HcmSKto2+RxfwvmxklLDFe4q8vWBDbNk8Begm5mCRngSF/nmZSQaL2tGYNsLNUdJJqT8
         XTpg==
X-Gm-Message-State: AOAM531l+XWNB/7DnhmNVL9FWwk3zFRr45TXtGAuqtSBTTNKwFteofk8
        AsrutllNWsWevYo8BM7ATiQ=
X-Google-Smtp-Source: ABdhPJxubncUissBx4ZmD8hh1ZobZ1bSg2iuLfg7u6HmSwkWTeEZFopmJ73U5J0ZtcXnw31JdxV8+g==
X-Received: by 2002:ac2:4d10:: with SMTP id r16mr21099936lfi.309.1632696155401;
        Sun, 26 Sep 2021 15:42:35 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:42:35 -0700 (PDT)
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
Subject: [PATCH v13 08/35] dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and GR3D
Date:   Mon, 27 Sep 2021 01:40:31 +0300
Message-Id: <20210926224058.1252-9-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
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
2.32.0

