Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364835130F1
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Apr 2022 12:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiD1KNL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Apr 2022 06:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiD1KMt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Apr 2022 06:12:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F93742A1F
        for <linux-pwm@vger.kernel.org>; Thu, 28 Apr 2022 03:04:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e24so6020879wrc.9
        for <linux-pwm@vger.kernel.org>; Thu, 28 Apr 2022 03:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGhXnVH0ggOkw3OApNhk6r1wBoAuFoy4h6Is9/5uMkc=;
        b=eVRmZnZEGzasLOjDwCJhqMfwLwbT5pTUBZz6prR0DxyB7mVpuF5mXRRscz37OTa6Z6
         IWgu+Ynv9/cl2cdN4wSHOsVXgZJVCwTcuqwymlKwTuIvCSftKXKEsqQ9zbfpbJSLV5az
         hKI1onvYoOUpIqh1c5R75pCR06jDSYjWNR99w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGhXnVH0ggOkw3OApNhk6r1wBoAuFoy4h6Is9/5uMkc=;
        b=5k2D7WISa6UL8aECjwDTjdFOtoHtHRy/QGDIjK4w/BMy9i31VKWV20EFVL/AXC4KoG
         oARFdnKQuIIKVml2lbUQ24Ko3PBNcveJs3UcdPwMWz69Vg/7g6o9VUBDljRbDc+VkG1V
         5jPt7BQc01lB03i09FbBx7q888+eyIhGuoWSulcVJXg+Hcmw3wCTGXjb+uL8jvKvyRIo
         8OO7DStooHqT7HDBKwftt5DBnhErU6F8WwmjLAoLqn+0+lglcLoWpHJAV0hPaeM1C/QA
         bYzPwPyf4w//x4mzI3TOtfosz7wpdjDD4R33f2ijDy+mxa+phVBNQN8Lw0K7y0dgck5k
         s73g==
X-Gm-Message-State: AOAM533CoYWVHjsQ22ij0eY9FuGC7zognDJG2qlwmL1jI8NfgmBIulX9
        pat/JizNaSY9aFBoD34gzNHx5A==
X-Google-Smtp-Source: ABdhPJzjbUoBwlDopMyW33l1lxY0cYudO9Yi5cAIdOYzcQJ+ApQfht6chf1e6HDKMOFqWFP1chBB4g==
X-Received: by 2002:a5d:620c:0:b0:20a:b1dc:eabe with SMTP id y12-20020a5d620c000000b0020ab1dceabemr24962689wru.711.1651140271218;
        Thu, 28 Apr 2022 03:04:31 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6785000000b0020a792848eesm15080449wru.82.2022.04.28.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:04:30 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: add mfd/cros_ec definitions
Date:   Thu, 28 Apr 2022 10:04:18 +0000
Message-Id: <20220428100421.247471-2-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220428100421.247471-1-fabiobaltieri@chromium.org>
References: <20220428100421.247471-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a dt-bindings include file for cros_ec devicetree definition, define
a pair of special purpose PWM channels in it.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/mfd/cros_ec.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/mfd/cros_ec.h

diff --git a/include/dt-bindings/mfd/cros_ec.h b/include/dt-bindings/mfd/cros_ec.h
new file mode 100644
index 000000000000..3b29cd049578
--- /dev/null
+++ b/include/dt-bindings/mfd/cros_ec.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * DTS binding definitions used for the Chromium OS Embedded Controller.
+ *
+ * Copyright (c) 2022 The Chromium OS Authors. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_MFD_CROS_EC_H
+#define _DT_BINDINGS_MFD_CROS_EC_H
+
+/* Typed channel for keyboard backlight. */
+#define CROS_EC_PWM_DT_KB_LIGHT		0
+/* Typed channel for display backlight. */
+#define CROS_EC_PWM_DT_DISPLAY_LIGHT	1
+/* Number of typed channels. */
+#define CROS_EC_PWM_DT_COUNT		2
+
+#endif
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

