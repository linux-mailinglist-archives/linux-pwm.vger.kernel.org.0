Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAA6E0D72
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDMM36 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 08:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDMM34 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 08:29:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C2B8A57
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 05:29:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v10so1744134wmn.5
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 05:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681388991; x=1683980991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qp0N5R/Q4kc478mKsiwOCthcJASKN3MuwNKuLyigck=;
        b=eKzGXjJv6ylDYcSKVMLDr6ok/cXQR6S2XL86o5MBB8dTOvOlrLK5ZVQ73WFAIZ0JpK
         qaqBIijLeF/d1GHHelDtzxM71mj1Y3O8F+DDcZC/Gu3R1PCYY3l9yMy9OOVfEeb8q030
         fkur217UomhsTtk5PInXJeUhWW5iugZy8yU3lfjiccFTFxkSCRhu4jDynawIsTPuKNEW
         C8ZZobaN9Zvz3Gjz3m4G6laOV9Etp9w6+6zEaatIQQO1Tr+kSzbRrJK0QvmwtLz8NyaH
         zIX5Q6h2SAo7FCWDmsCoUTpGeIFy5Cf8yulkim2oYgMTf7NoVpKGlejAusmvf/+MGd/c
         +krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681388991; x=1683980991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Qp0N5R/Q4kc478mKsiwOCthcJASKN3MuwNKuLyigck=;
        b=ExBffbhZvrMozTzh8YgiwDR3dxEw1lSg/iX4gtpnPa5b8V33/lhyDuJRweh9tTpjQY
         qsF1+WE/kuQP9iifqNjtexzVhSw8qWcnweWO3gh2BQ1vcqBs9Hy9NxAtkHsVTirLONpS
         gVPr7Kb4ecXVgQRgl1BDDFnCYrCqVaguNuNqPtzLci7DvG+vnHq9vUT8s7NfmxDPdaY1
         SPFz0e2Mw22sZOOzqS1qbF7ytu5jkbWOXTEe4CmYdZxnvkmWCI/Q3x8KeDSkmqqRk0ky
         lDapcpT1KVBG9FM34uEuArejyKZBqmAREEEYPDfiP0xW0Nn7lTIMx+Pl1MapILWK3xyV
         6zrg==
X-Gm-Message-State: AAQBX9eY/oZ/UMFSiOSf3r78cf61Olj99tgzrsuWgmsxd9vIbPaWCS3A
        U7AJ7e20+yp9oTtIA0GKm3whzn7yLHY=
X-Google-Smtp-Source: AKy350bcpUu9T0+OnVvYtM0Gd/smDG+XOuV+pRN2gbaUvLPAXV1Yp+ijdmAazqWdaCn3VS5w5vxx3g==
X-Received: by 2002:a7b:c3cc:0:b0:3ef:128d:7167 with SMTP id t12-20020a7bc3cc000000b003ef128d7167mr1750833wmj.13.1681388991360;
        Thu, 13 Apr 2023 05:29:51 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b003f07ef4e3e0sm9995313wmo.0.2023.04.13.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 05:29:51 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Remove unused radix tree
Date:   Thu, 13 Apr 2023 14:29:47 +0200
Message-Id: <20230413122947.428134-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The radix tree's only use was to map PWM channels to the global number
space. With that number space gone, the radix tree is now unused, so it
can simply be removed.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9ce85c6157e4..3dacceaef4a9 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -28,12 +28,11 @@
 static DEFINE_MUTEX(pwm_lookup_lock);
 static LIST_HEAD(pwm_lookup_list);
 
-/* protects access to pwm_chips, allocated_pwms, and pwm_tree */
+/* protects access to pwm_chips and allocated_pwms */
 static DEFINE_MUTEX(pwm_lock);
 
 static LIST_HEAD(pwm_chips);
 static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
-static RADIX_TREE(pwm_tree, GFP_KERNEL);
 
 /* Called with pwm_lock held */
 static int alloc_pwms(unsigned int count)
@@ -54,14 +53,6 @@ static int alloc_pwms(unsigned int count)
 /* Called with pwm_lock held */
 static void free_pwms(struct pwm_chip *chip)
 {
-	unsigned int i;
-
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-
-		radix_tree_delete(&pwm_tree, pwm->pwm);
-	}
-
 	bitmap_clear(allocated_pwms, chip->base, chip->npwm);
 
 	kfree(chip->pwms);
@@ -302,8 +293,6 @@ int pwmchip_add(struct pwm_chip *chip)
 		pwm->chip = chip;
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
-
-		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
 	list_add(&chip->list, &pwm_chips);
-- 
2.40.0

