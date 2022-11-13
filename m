Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8692627387
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Nov 2022 00:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiKMXhC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Nov 2022 18:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiKMXhB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Nov 2022 18:37:01 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B67CE2A
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:37:01 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id b29so9508570pfp.13
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDS2LHrr0iyus1PVsFFCM5d1XlkXhGS0bBzYDSzvT2c=;
        b=EvBM+GOXIkFNeOPimGHVcJ7FbDPBgHvlS7yU94qiaQxpf9tkzcGrj0PbqYgH/pbKsg
         Q1UDIZYOfG9y/ZTTtLCT7qiXu8UAW6cdbYFKdgNSIJeDIjUY1xz0ij1sHA4MUgJfoI6i
         9JNUJ+xkm9eR96DTb003LWg7o91uI2cl+sE6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDS2LHrr0iyus1PVsFFCM5d1XlkXhGS0bBzYDSzvT2c=;
        b=IDgwLwWXGTbCxb7QMbYwccuSb+JbBAvY4DT90i+Eb9SGL740MFFDejuYOakaoSavok
         HrFS/C3KJoByPf9Iy95sqTK9REAmwsZKTXRKupGoz+pGX4w31Ftdt17OBwDAuIvf7zwe
         otV7AqkhdDH7lWnAxqJgInrL6MQfGsws8LfMvNyHYO3HQ8Q3bEX8llYyoOwoxr5ffTnR
         17zFhKmlU9sSc7ax8h/smOH7ZZTBIYT+K38LH+TF1CeZ6LUR3O5wUxsmIwqSKvfOykXE
         8w++cyHfXH/PRv2fj2gzmvGnrb8hCw/+ZxQGQaPAaFcWohCxwdC8BAt+diJRuCuW5uOT
         H0+w==
X-Gm-Message-State: ANoB5pmm0OlLbO3xbh02VXWbRrDeKlehP8V92RCDOW5f7380HnhOLCOr
        tQlmJaXYm7F1z4JGj4JEgPAZsyHRiVSEECW5Odg=
X-Google-Smtp-Source: AA0mqf5lPsWgYCg9g+lTtmQpD8Vcbsk7VwxZXhNZa3oUDCl+E3Sb47gVEfDTwvhymobagfQFq3Q05g==
X-Received: by 2002:a63:ea03:0:b0:470:814c:f54a with SMTP id c3-20020a63ea03000000b00470814cf54amr9678012pgi.516.1668382620494;
        Sun, 13 Nov 2022 15:37:00 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id q14-20020a635c0e000000b004597e92f99dsm4641990pgb.66.2022.11.13.15.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:37:00 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 6/6] pwm: pxa: Enable for MMP platform
Date:   Sun, 13 Nov 2022 15:36:39 -0800
Message-Id: <20221113233639.24244-7-doug@schmorgal.com>
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

The PXA168, which is part of the MMP platform, also uses this driver.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

