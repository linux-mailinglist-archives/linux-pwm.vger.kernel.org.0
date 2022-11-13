Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B60627384
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Nov 2022 00:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiKMXgy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Nov 2022 18:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiKMXgy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Nov 2022 18:36:54 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E15CE2A
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:53 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso12322842pjc.0
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhnmldC/KC8ynC2xFeluinhd/J6Lon5h4EuseZ1p76o=;
        b=le8na0PyeiQofD2uKLUTMevqmElaBkdpnHGNAw3uimRcTofF6HIiQ0xI4au3RxZHY5
         AaDYxfuErnsE/YpQ/M7Es8jXtIMRccIgV+73cGCp3WY8xlOQtMyuOlDn1ncdTASk8iTq
         DMh63N6oQJXoTKkJ9my2BsKbPZf1mN16xhqdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhnmldC/KC8ynC2xFeluinhd/J6Lon5h4EuseZ1p76o=;
        b=MOZoCjqlhuGGBsM3PktCwz2/KTm4YShd9GaUYziisRjRZn01laCj7ufn8uFtKwiyId
         U7aFjdc4wDvOWfIU3kbUl6irE3CWZtNL4vj0tQ8Dz4Y0+sWprN/cxa+d6+DZfY5+qvTx
         LGmjH1Dkms0ZGk5pQmQulrYdeZEsZgbc2hJOILkolmw4mZLWO4CBovuY2FMOUwdg3AyV
         QM8e9Da3UPihk4sBXb9tiFc1QrQb4Xo6zrTInV/jIl4SRQFCSLUJ2TowmJQ+5daApAP6
         jV0Rpl9Kxpxq7YrECXaExWesnLUIccHGkO573q+4pKjtmuxG5OQQLh8ZoC9tnvxwpfyc
         0IkA==
X-Gm-Message-State: ANoB5pnOkwVgnBerPOaMmVHaFuIgimlonsYcZFcLzR14uNE0BdaCDRxF
        8RfT+AaELRmFSYliBrz5wOiokA==
X-Google-Smtp-Source: AA0mqf60OVmuiSUl5IL+CpEZfJmNFI74FdqOxkcfLV6AQ2EebWZBQQeEXQ/fFw3QgO3EsHJnEqW8xA==
X-Received: by 2002:a17:902:8506:b0:174:a0e6:428 with SMTP id bj6-20020a170902850600b00174a0e60428mr11466540plb.124.1668382612963;
        Sun, 13 Nov 2022 15:36:52 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id q14-20020a635c0e000000b004597e92f99dsm4641990pgb.66.2022.11.13.15.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:36:52 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 3/6] pwm: pxa: Remove clk enable/disable from pxa_pwm_config
Date:   Sun, 13 Nov 2022 15:36:36 -0800
Message-Id: <20221113233639.24244-4-doug@schmorgal.com>
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

Now that pxa_pwm_apply always enables the clock first, there is no need
for pxa_pwm_config to do any clock enabling/disabling.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pxa.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 9ee9b41d62b8..cf4d22c91929 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -64,7 +64,6 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long c;
 	unsigned long period_cycles, prescale, pv, dc;
 	unsigned long offset;
-	int rc;
 
 	offset = pwm->hwpwm ? 0x10 : 0;
 
@@ -86,18 +85,10 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		dc = mul_u64_u64_div_u64(pv + 1, duty_ns, period_ns);
 
-	/* NOTE: the clock to PWM has to be enabled first
-	 * before writing to the registers
-	 */
-	rc = clk_prepare_enable(pc->clk);
-	if (rc < 0)
-		return rc;
-
 	writel(prescale, pc->mmio_base + offset + PWMCR);
 	writel(dc, pc->mmio_base + offset + PWMDCR);
 	writel(pv, pc->mmio_base + offset + PWMPCR);
 
-	clk_disable_unprepare(pc->clk);
 	return 0;
 }
 
-- 
2.34.1

