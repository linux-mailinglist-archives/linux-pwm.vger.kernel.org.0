Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266465009C8
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Apr 2022 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbiDNJbD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Apr 2022 05:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241197AbiDNJbA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Apr 2022 05:31:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06A86D4D4
        for <linux-pwm@vger.kernel.org>; Thu, 14 Apr 2022 02:28:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i20so6039781wrb.13
        for <linux-pwm@vger.kernel.org>; Thu, 14 Apr 2022 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Av8EzP8d6KVoQi/yXwkBOAZabP9Xc8kXclRu9dT4+Lw=;
        b=XW/DvwVmRs0u+HPVCBNJh0m4E34d8hn5teI5p4MFlw1AwT0QGpyDrvDYKeFL04RmRK
         jvJG4o7qAJeCTCf9MHamgs4HLvZ9Sp1qgwjYT6HwHxwOr7ayhQgJeTOVefciIbCRRfcN
         kAIWOaIp3+4P5k1D8vWT9Ug6Fw28yDxDjq/go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Av8EzP8d6KVoQi/yXwkBOAZabP9Xc8kXclRu9dT4+Lw=;
        b=JeAIvoZePAk/1WgzwvC1YqywPheJ912o/VGJGFs8KCjt4yme0NPMenAOQp0eYHXs+i
         2sG6emE8PUJu4j+PlWA/yj1NLtmMI+Zlz8Yr9RDeiw426gp2SX9Pq3DbwDjhZo5rgQOu
         2t4dO5XvAkSX9wgawdF+SqO8r5x9/3v2KTxDKmr4k1+qkWUQu6t+8I47ewliftdKeX5C
         5ePau4BPVO1VfdIjsiw52jd+F2Ab6sTSguKOg0a6vlGAcgxuRccJjM/DD2Gxt7wIzMOU
         0fZOCQ4KDcfJ3HhZNyPd2Ss0+Fk/U8biEq6Tpk5ypw5G55PTYy6NeSI2Aem+WGyHF7R3
         kE5g==
X-Gm-Message-State: AOAM530YgvxLP4Oij5ieRGs/DYzAjgHdO4T/JqDb0/eNg1uXHHXaDmiD
        +H6yvROdmOoHCCAPAr4zFk7d7w==
X-Google-Smtp-Source: ABdhPJwICPNoTiCyXovM+uFrLY1cRUMc9NSi0tZTBQi5obLIMnAkksH5rZ/OUVje2hYRLnI13kqUcw==
X-Received: by 2002:adf:d1c7:0:b0:205:dc0e:383a with SMTP id b7-20020adfd1c7000000b00205dc0e383amr1370718wrd.335.1649928514435;
        Thu, 14 Apr 2022 02:28:34 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm1698099wmb.3.2022.04.14.02.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 02:28:34 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH v4 1/4] dt-bindings: add mfd/cros_ec definitions
Date:   Thu, 14 Apr 2022 09:28:28 +0000
Message-Id: <20220414092831.3717684-2-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220414092831.3717684-1-fabiobaltieri@chromium.org>
References: <20220414092831.3717684-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a dt-bindings include file for cros_ec devicetree definition, define
a pair of special purpose PWM channels in it.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
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
2.35.1.1178.g4f1659d476-goog

