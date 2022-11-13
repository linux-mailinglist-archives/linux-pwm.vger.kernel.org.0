Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3717E627386
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Nov 2022 00:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiKMXhA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Nov 2022 18:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiKMXg7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Nov 2022 18:36:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93ACE2A
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l2so8588022pld.13
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OePMi4mw1G/4lVVl2oHBMTsTK79Bvn24hVYBtQka0Pg=;
        b=at3xK04xbxXGg/veF1pZy1G3bPzAWRmtCNKlHJbBIelJxedJiOXq3VytNrmYFlkJg0
         riWr6tppZGo2hfD5qtuAHGd63VetpubgRgnAu8nfJleMCd6tXj+oXE2zFqDuLnA23ONR
         6Z5q82O8UubMcCJt00HP9f9/UMW9HiUL4CKRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OePMi4mw1G/4lVVl2oHBMTsTK79Bvn24hVYBtQka0Pg=;
        b=Lctl+N9VloEGgtKEZeYQ3lK9eaxFk14EK6AK9gI40cejH5SuiX6IDjYX1NyLf85Av7
         h0sZF9qqQjzNHubKMMLYwWM7299m9t1hZg22ta8TU3O+OcoBAXZysnEiJZq+nb1Th2V9
         TBWgYb7GF5CshdfWdRdt4VKmL/YJOOfbIacrFtR+TVfFZ6ukvSGRqQ+dKgAS+toijZn2
         mWqIfPMRE+CSccgUbY1POdopRpT99mHc5lQThNFtOQ0Z0pc6/ehF33wrmepzOGAbozW/
         KtLE6DKTP37+hinZn3AfncUa5wqoczmk9fxH50h3QL59yzROuBKWS7Xncp4i/FMkjewV
         4tYQ==
X-Gm-Message-State: ANoB5pkzoHOj1TKoDzVUuxdowMS2fA/ultBO4NH/j2y5UkKOLP8CKXuq
        9yyUhehM8WejAghItMkzQHCnfA==
X-Google-Smtp-Source: AA0mqf6dwNAc3sR2cIL78dJGc2O3mdWuUQdoH2O4mqtX7ogA36yRttkNqe7cGirBeXYF9r5uiXbbAw==
X-Received: by 2002:a17:903:2797:b0:17f:628d:2a8 with SMTP id jw23-20020a170903279700b0017f628d02a8mr10878153plb.34.1668382617898;
        Sun, 13 Nov 2022 15:36:57 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id q14-20020a635c0e000000b004597e92f99dsm4641990pgb.66.2022.11.13.15.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:36:57 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 5/6] pwm: pxa: Add reference manual link and limitations
Date:   Sun, 13 Nov 2022 15:36:38 -0800
Message-Id: <20221113233639.24244-6-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113233639.24244-1-doug@schmorgal.com>
References: <20221113233639.24244-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a pointer to the location of reference manuals for some of the
supported chips, and add a limitations section explaining the hardware's
PWM disable behavior.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/pwm/pwm-pxa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 00063ead7c0a..46ed668bd141 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -6,6 +6,13 @@
  *
  * 2008-02-13	initial version
  *		eric miao <eric.miao@marvell.com>
+ *
+ * Links to reference manuals for some of the supported PWM chips can be found
+ * in Documentation/arm/marvell.rst.
+ *
+ * Limitations:
+ * - When PWM is stopped, the current PWM period stops abruptly at the next
+ *   input clock (PWMCR_SD is set) and the output is driven to inactive.
  */
 
 #include <linux/module.h>
-- 
2.34.1

