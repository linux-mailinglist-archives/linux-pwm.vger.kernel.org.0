Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07905F2790
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 03:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJCB4X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 21:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCB4W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 21:56:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D12F3B0
        for <linux-pwm@vger.kernel.org>; Sun,  2 Oct 2022 18:56:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d1-20020a17090a6a4100b002095b319b9aso8082607pjm.0
        for <linux-pwm@vger.kernel.org>; Sun, 02 Oct 2022 18:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EnV/ld2NipwM/UxxeyFxa6W6VAWGpYuC5Pc6JMzfqhM=;
        b=bmZ0rCa1Md1jWNyL8uYIYi1ao7DLs4+rI99nqYXdPcrpxoEEm2AXze38PB9Cws7JAd
         MCa3zSCAdcqMsIdMxA/wDRA3UKHaPjR2PMec+cNgTxONlzmf+NFYygzuj8NA709b7Qs4
         MKbEQFm+mYDhMAEiJ631AB4FieGAn/+fk1C+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EnV/ld2NipwM/UxxeyFxa6W6VAWGpYuC5Pc6JMzfqhM=;
        b=5oUC45oKyjQ+fCp6ntbWd3WU4CTVlSp3+bVpq52AZaAdYZd7FoTSik+8faLKmyfSSw
         MhyvkPABq5LdrReZcKRdZFBKbZLtAHVaetI7lt8oEaKFwEMIUke6QHbUxQuKNxWxjBkd
         QCwdoCw1oTyKCDKXCVTlgF3GUhbzFrNAHeYL36XUZX7GRU/W8FNnq67JRKAHoYk+lqfe
         WY63lKjjoPnwnNA/7X8IP13kiVsnRzKwI5oinVEOOXC46jCvPtbro3qSeBBuuTVfh/iO
         rWoD0+QsGs6cEHgjGMwiAHgGRHaiB+nuFrRahjeJ4PE8EEvYRMdJDvUYBwkanpI1lDD3
         3sEQ==
X-Gm-Message-State: ACrzQf1lFkPbMlA9pbM6/7KApaxsBo/gxysXsQvvzq1J9CFUir/eQat5
        2g3SbVYKLe9HD2Hn4GUY88PYtw==
X-Google-Smtp-Source: AMsMyM5VQDHF9RrS57mMLEuK5ILzBKePX4ex8AyaHSvWUp/Z0OhxAl4ktQ/JNCFL9T+ckdiHMc8HEw==
X-Received: by 2002:a17:90a:e7d2:b0:202:c6c9:4731 with SMTP id kb18-20020a17090ae7d200b00202c6c94731mr9766686pjb.114.1664762181405;
        Sun, 02 Oct 2022 18:56:21 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.45.132.124])
        by smtp.gmail.com with ESMTPSA id s9-20020a17090302c900b0017b69f99321sm5893786plk.219.2022.10.02.18.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 18:56:21 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 5/5] pwm: pxa: Enable for MMP platform
Date:   Sun,  2 Oct 2022 18:55:46 -0700
Message-Id: <20221003015546.202308-6-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221003015546.202308-1-doug@schmorgal.com>
References: <20221003015546.202308-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PXA168, which is part of the MMP platform, also uses this driver.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..d0d4caebf12f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -434,7 +434,7 @@ config PWM_PCA9685
 
 config PWM_PXA
 	tristate "PXA PWM support"
-	depends on ARCH_PXA || COMPILE_TEST
+	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  Generic PWM framework driver for PXA.
-- 
2.34.1

