Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0F7508A82
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 16:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379332AbiDTOTM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Apr 2022 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380277AbiDTOSs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 10:18:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A7143AE5
        for <linux-pwm@vger.kernel.org>; Wed, 20 Apr 2022 07:16:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e21so2455305wrc.8
        for <linux-pwm@vger.kernel.org>; Wed, 20 Apr 2022 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=buTOea5hGyKVMycb2UNLHy/CmUKsfopnU76jMCLf+w0=;
        b=DiPpygcsv1FE9XrikGyg1icYH8Svlo4wHN7c1tle/5MzbK5V7gZZJq5zEs1zm+Tr0m
         hbQ7xTlZD3c3aGUWxVlvLu5rAiJ4fk64EfvWmQNbi2CZyH/3Eoq4iWQGbzXnWCaNJoUY
         vLauIkmYNo/D2ewIjUpwRwG4OF3kyDl7X8CP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=buTOea5hGyKVMycb2UNLHy/CmUKsfopnU76jMCLf+w0=;
        b=ztef9s/PPN36O+2NgXNsC+81x+6QZ1A+CY3/T+Ubs/PIyZHYuJDRi8f8cyvMJd/PTE
         nmW+zMMaELqcOd8yckzTt3OWla5GRQdcCT+y/LsDSmczZTrvMPT2hawoJElQV3u40/71
         yUmbEJQzwTrsWXOJrvAy96q7n5GGhMM4HudVEMktbePLdviIYPqcuJEinZxrGalETl95
         k9s7C0sh4YHN6IW4N4FM4wBbDXw4DhBJ4pzaz4CoqNZlJWINzJ7QMv82uVpxD8V3/gc4
         FbQHFkG3fANNfujXo1/QK2FSvsk5UNolRR2pTA2cqS2SMyVibeiF+GXecCKdi+Q/dEhb
         gbYA==
X-Gm-Message-State: AOAM530Xy+KFu7upAUrU/z5toGTZzXUOZQAa0xXSCiivGjiWZ3NO7wFr
        2KlPN5bR7MxKs86VNUH9MlwJlg==
X-Google-Smtp-Source: ABdhPJyYIA6x9+f8e47TwQBEyU5CfA6Jc7fDHnsVuiVEE4Gn+yDN22VKV/egJHJ1ZcL3RtVt3ILCkg==
X-Received: by 2002:a5d:6e85:0:b0:207:a435:d9a7 with SMTP id k5-20020a5d6e85000000b00207a435d9a7mr15785389wrz.217.1650464159946;
        Wed, 20 Apr 2022 07:15:59 -0700 (PDT)
Received: from localhost.localdomain ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0020aa790a258sm12447wra.8.2022.04.20.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:15:59 -0700 (PDT)
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
Subject: [PATCH v5 1/4] dt-bindings: add mfd/cros_ec definitions
Date:   Wed, 20 Apr 2022 14:15:53 +0000
Message-Id: <20220420141556.681212-2-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220420141556.681212-1-fabiobaltieri@chromium.org>
References: <20220420141556.681212-1-fabiobaltieri@chromium.org>
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
2.36.0.rc0.470.gd361397f0d-goog

