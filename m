Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDCA20E638
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 00:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404058AbgF2VpS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 17:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgF2Sho (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 14:37:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8AC00F82F
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l17so15272640wmj.0
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXWPj65SsgiOS9zBWng/y3B2dHdHCzzNx8KN4IFF3T0=;
        b=Jlf/+bu6MQO1H2Y1nOpHwS2pO3hXcUe/HKZCIAl8BbtiP7Kf0yEVgv1uZN932HwADc
         133TMwpc3TtvSaPRg1M+WFSrLYTatgIZv2mcd/+YFO4O6JtO2y//GGZpwk8nnUrhGdYQ
         hMsTYPm9uxGpufCX1GKnRNjRNFLSlDT5dQXKo2WuBUcsIN677aUB958DsS2Ufpw3Ef1L
         nFdL6uQVDk5/7DG88H8PBdiJnSa0JYbh6CpzKvzVtC54HCTmX3MW25q6eJUouLqxLHNI
         k0W+rWsYph1/w8326KtVbvoRim9UDd1hixtZ35evPkPMsFz+gjbP/UFmtrYOWW786+7s
         t8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXWPj65SsgiOS9zBWng/y3B2dHdHCzzNx8KN4IFF3T0=;
        b=HtHk9XX6Dob9z1CmPXiHanm/th4yJFKmdhPwQ4SdbnqUOaQQW9Jkh79aB+8hK+SmNb
         AX0gmFTp5YCGfDKZjvBpBt+1u3W8lcF6Qnt8Nyz33nABPZehhm4fLlNKisJdLp7VhVAA
         lAUbIteIFYW4JHITxDRjcDGpJKFgatuwPn9KZZW6RAx41qjPya2ki3l79Z/vYaPf2eUV
         41/sg7JA8+h19wh4zSNRUO8nnqNvteetd+XGeJomlQAfYNAxdlqj163po5havx6HJd5O
         UVb1Yfnr/3xd9QubldG5nAVcURAnw2wArh4LNTL3WBMO3H0YDTfmWRBIuXSHeImN/qRJ
         kezw==
X-Gm-Message-State: AOAM533a5beajZbsPv9aOb+meGzFWpFMgWsKif3hcfZRTBB8cYHHOfSy
        PiwuyjZGE61Eb1v6yRo7cq8cjA==
X-Google-Smtp-Source: ABdhPJwFsoOz7r0nFMjUVsQWVlIpJeZRYkCocmfI+AhlI+deNKBfMmUDPAunud4nny3pLzOyhu25ug==
X-Received: by 2002:a7b:cbc5:: with SMTP id n5mr16593514wmi.95.1593434876317;
        Mon, 29 Jun 2020 05:47:56 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id e17sm12995924wrr.88.2020.06.29.05.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:47:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 1/4] pwm: bcm-iproc: Remove impossible comparison when validating duty cycle
Date:   Mon, 29 Jun 2020 13:47:49 +0100
Message-Id: <20200629124752.1018358-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

'duty' here is an unsigned int, thus checking for <0 will always
evaluate to false.

Fixes the following W=1 warning:

 drivers/pwm/pwm-bcm-iproc.c:147:12: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-bcm-iproc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee70..46f0a45e9049c 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -143,8 +143,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		value = rate * state->duty_cycle;
 		duty = div64_u64(value, div);
 
-		if (period < IPROC_PWM_PERIOD_MIN ||
-		    duty < IPROC_PWM_DUTY_CYCLE_MIN)
+		if (period < IPROC_PWM_PERIOD_MIN)
 			return -EINVAL;
 
 		if (period <= IPROC_PWM_PERIOD_MAX &&
-- 
2.25.1

