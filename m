Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA364E2ADA
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Mar 2022 15:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347509AbiCUOeL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Mar 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350109AbiCUOeA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Mar 2022 10:34:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEC25D5DE
        for <linux-pwm@vger.kernel.org>; Mon, 21 Mar 2022 07:32:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t11so20982899wrm.5
        for <linux-pwm@vger.kernel.org>; Mon, 21 Mar 2022 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPNbf4VBXaKauQrD5GdOw/7C1sM2aDR3HnxDjhZ0elg=;
        b=K04KZ2llvCIBVjpLXRbj+FItZXFlk4ZVLcXMU/n3uOzyXQkjIt2p8UQRjAN1JRYeHw
         odN5bc3b7y61QwvNr5Voo9HYGe+n6sUBYkPIHRCLkL2b8MpipkOPtqLac92fMqy93U/2
         9Xve7ZthNZPcBZUKdMEkBljxtgCh7T6f6FGbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPNbf4VBXaKauQrD5GdOw/7C1sM2aDR3HnxDjhZ0elg=;
        b=IeCEPVWjwZ0iSfPvO1PpDP6lfTZqNoVDBJFD2p2jcrzfpJMfc0GJtMQLzV5ocxL9SN
         sjmlfzmTh5D9PWIVquvcQXB8H2peshyIJF9M/fbMu2z8fz4ffT4BNiLFOq6RrnzVr2kk
         TFsnpQv/qoxzsSRL17D7keMZFz6NzbLbO3+l4fY2SzAM67YlXD7nJrJC/YFFwd4Ay5bj
         hKpFKIkNJDykHtQajosHZbQJgGLzcEMjKKlHWG7MRMyBpwJq/w26ITCkeySGVRaWUqsd
         41v0W0pI4nxc4k/OkULiDxTgwsM1fGCDH4a0OHcpf8uWmswdvCrXXlC9+HfwQioc6YHu
         iwMA==
X-Gm-Message-State: AOAM530C2ItYl+EZxLxQL/uNoJinurBq7YuR/fJtinJkY1BID3rrep00
        PDSb1fhMnEzZWYq9rKn48rXISw==
X-Google-Smtp-Source: ABdhPJxAUNMAkxYkB4uOST35byIe9LqZT6SPgd/wDbe3ZFo/1vnlqpEDwMr6f9llJhrZuMausBRxrg==
X-Received: by 2002:adf:ea06:0:b0:203:ed67:6093 with SMTP id q6-20020adfea06000000b00203ed676093mr15652317wrm.596.1647873152722;
        Mon, 21 Mar 2022 07:32:32 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b00389efe9c512sm19092793wmq.23.2022.03.21.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:32:32 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: add mfd/cros_ec definitions
Date:   Mon, 21 Mar 2022 14:32:19 +0000
Message-Id: <20220321143222.2523373-2-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
References: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 000000000000..e02414eae622
--- /dev/null
+++ b/include/dt-bindings/mfd/cros_ec.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
2.35.1.894.gb6a874cedc-goog

