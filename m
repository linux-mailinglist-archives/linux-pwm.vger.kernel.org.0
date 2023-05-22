Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11E970BB44
	for <lists+linux-pwm@lfdr.de>; Mon, 22 May 2023 13:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjEVLMb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 May 2023 07:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjEVLMM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 May 2023 07:12:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A11721
        for <linux-pwm@vger.kernel.org>; Mon, 22 May 2023 04:07:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso36492555e9.2
        for <linux-pwm@vger.kernel.org>; Mon, 22 May 2023 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684753667; x=1687345667;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aK6Kf0asRV464IBaYiptxo3f4bLbCIHnLoUffj6qAuc=;
        b=lSDHfK3dISOhvvh1/paEMv8h5AylGLL8BfeaeZqoX3NLO/a1SEC9I6YkwVA+DJPzfq
         ASo0tR7IwTsonPeakI+1nwokLtIyFqHMCb6d9jQq+ySDoq+g1d0x/gBGNuNorkT30jAO
         ELxAKqGtlbmOPoEPBL3IqIwNTUkBSb2GpprVbqti9jECNxFa8BFYHaMDgAltkDSyAC+2
         Igw7PdXEEzRNZfY0JjZn7iDVHh8pggHBiO1/kOQh58OuMlUZAxdrGQRlj+QDZjIkUhar
         ftmgYRqmWP9A+j5fSlqSfVvupufsDEioxnEXlbe0qPL8SIU5OP/307k3kkC1Gn8StQZ4
         Z8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753667; x=1687345667;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aK6Kf0asRV464IBaYiptxo3f4bLbCIHnLoUffj6qAuc=;
        b=JHvl3qx0GWWutibZEvRfGX33Ce+7ng6xWNhd7O6TqMHP9tiIVq1Mm5tL8/xmrKp5OJ
         N0DCer5/4UPJ2A4cB1NaS7g/D5iKF8yEn077P5IBTQJ9kFbN4U4KdZzmDmkQF0jCGdwC
         w1JHtKJK0mO1KKPSEW50X483+YYL3xxnJAXNzbFq5auiNttssW9E3CVeI+Nf+EPPTpnz
         oxpS7PulDsTjX0GX3mOa6OiJwKQ0dCF3zhmtSUpaqYE9Fr7WuJ2EeS+j7iHZuikLP4q5
         Y3ft2S2ZHwsi7xz4mAlQRI6RNLi3BM8THOtx/7wy2wC6I+MHD/NtO3th1pb4I2ixEPYh
         D3CA==
X-Gm-Message-State: AC+VfDxk9loA79WvQ7BjRN3O7ziuox7/0iImr7+s+T2M8mYnF8beXvNq
        UMuh6lQkydabqDiKgAWuWfMakg==
X-Google-Smtp-Source: ACHHUZ5hL20G23vQVzQIDwJ2x9rWWfu4TzDI5xAEjRyuSUCFKgghRcCSDnguIQAgDfGwoOSQ3rPe6g==
X-Received: by 2002:a05:600c:24d3:b0:3f4:298b:d925 with SMTP id 19-20020a05600c24d300b003f4298bd925mr6548094wmu.41.1684753667109;
        Mon, 22 May 2023 04:07:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f50e29bce3sm7901485wml.48.2023.05.22.04.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:07:45 -0700 (PDT)
Date:   Mon, 22 May 2023 14:07:42 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] pwm: ab8500: Fix error code in probe()
Message-ID: <ffc1e98d-0db4-4b8a-9e49-eb87ef844cbd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This code accidentally return positive EINVAL instead of negative
-EINVAL.

Fixes: eb41f334589d ("pwm: ab8500: Fix register offset calculation to not depend on probe order")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pwm/pwm-ab8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 507ff0d5f7bd..583a7d69c741 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -190,7 +190,7 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	int err;
 
 	if (pdev->id < 1 || pdev->id > 31)
-		return dev_err_probe(&pdev->dev, EINVAL, "Invalid device id %d\n", pdev->id);
+		return dev_err_probe(&pdev->dev, -EINVAL, "Invalid device id %d\n", pdev->id);
 
 	/*
 	 * Nothing to be done in probe, this is required to get the
-- 
2.39.2

