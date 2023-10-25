Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFCB7D6A98
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Oct 2023 13:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjJYL5q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Oct 2023 07:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjJYL5p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Oct 2023 07:57:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF9C13D
        for <linux-pwm@vger.kernel.org>; Wed, 25 Oct 2023 04:57:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40837ebba42so40760065e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 25 Oct 2023 04:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698235061; x=1698839861; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6uVxf5kYe92K+O00MCE5FtASY43IgluJLHruF2586U=;
        b=yW8cRiy2S28hINm9iivjLPTYHXDnF3RaX0kTa3T6QkKPyMX8rQDb3fSYe4kJbY0RjQ
         IXHOQLG0QOy8EX2brbHLSzcPNUye+yeFQcvHIDcwJxeoOZMElRHUZvJx3OPa1Vz91Ed0
         cHworUftdcF4GwVgpVb9D9b1YLbxVKVV4pwtwOOSm6SR4Wn0eSQROQIe5Evxm2j8kmqC
         cAl8CI+ogGJ0erGyfi3h3lMzwVI5TmZlMDzweXSvZvRYt5ztHk+dFV8S0EUk7ehTxy/M
         AMF3gmTyP+Qmiq8TUHE8XXKKwnf759+G35iedNDBnuwrmsF5uF+Bj5aIpaDkS60jykGU
         BiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235061; x=1698839861;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6uVxf5kYe92K+O00MCE5FtASY43IgluJLHruF2586U=;
        b=aGSkZkVbH4Yq7RjtEvgBGwSLg2LQx6nuGUXCAeu3U9HzgZuREitfD5oj8rVPVO8H5r
         wzAvL92RXCuD6F6i7DjUA9DffX9YZl3pemACDyKqLF3Ahsxgv2oKCumvPkC4VdHEvPui
         NjsgUcQz4lNsijjIFS4TbgCjgRcfq2BwijfV/DfCducIgwIju1XeIv8+lUi2KhMqxGo1
         V4Pe+3pXWXvcnKUzGQRz+08kpitdJJHntbq64oknEWAS7jtmUdNpbaf6Zp5qfA0K89RZ
         IvauK+0tLDvwPA+4mEiAqGkbA2VCLUJoLsKGVrEarfAH+lGT8zDsbGhnRd011PN6MwUI
         YwxQ==
X-Gm-Message-State: AOJu0YxP+c+uGeGiNS3ZPGx9RkPCV+U/OsiwudD71lJaHefH7TevHNBm
        kvMi/SZdnvD5pBQG1S6kCmkCZA==
X-Google-Smtp-Source: AGHT+IFlcuVvisAHY6IpOp9uDQk7RA7FjTqkZ2XNTiaE5hdwCeCI/PV48ajajNqa8VjggLSkT9Do7A==
X-Received: by 2002:a05:600c:3b20:b0:405:4f78:e128 with SMTP id m32-20020a05600c3b2000b004054f78e128mr12172686wms.4.1698235061312;
        Wed, 25 Oct 2023 04:57:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p30-20020a05600c1d9e00b003fefaf299b6sm14317313wms.38.2023.10.25.04.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:57:41 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:57:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2 1/2] pwm: samsung: Fix a bit test in pwm_samsung_resume()
Message-ID: <e031db45-add0-4da7-97fa-dee95ee936ad@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWMF_REQUESTED enum is supposed to be used with test_bit() and not
used as in a bitwise AND.  In this specific code the flag will never be
set so the function is effectively a no-op.

Fixes: e3fe982b2e4e ("pwm: samsung: Put per-channel data into driver data")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Split the patch into two parts

 drivers/pwm/pwm-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 568491ed6829..69d9f4577b34 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -631,7 +631,7 @@ static int pwm_samsung_resume(struct device *dev)
 		struct pwm_device *pwm = &chip->pwms[i];
 		struct samsung_pwm_channel *chan = &our_chip->channel[i];
 
-		if (!(pwm->flags & PWMF_REQUESTED))
+		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
 
 		if (our_chip->variant.output_mask & BIT(i))
-- 
2.42.0

