Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A01AD18F1B7
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 10:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgCWJYy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 05:24:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46022 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgCWJYx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 05:24:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id o26so387236pgc.12
        for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2020 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A/0NRUsfnu7n/YoGxddH0xC1BSLSDDMn2mXtHQEsBCY=;
        b=H0/vrJJc4UTp4a1L7+UIrsXgbN2ZX+7FVzPetQZIdA9e76ziulDaDd2NAhYkIPjkxS
         YT987yydfco9sXyReNE47Uy1nFABe5RZIGH+tsYqgmg60OQudmltQHH7WVpP7G8VHogy
         +GLzGp5ZIudGxaUkMdcxKmubUoLfIMq6950kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A/0NRUsfnu7n/YoGxddH0xC1BSLSDDMn2mXtHQEsBCY=;
        b=Kbu2SL4+wCG62MZYQoFoUA6D+py6DrXsBX0lTmgXgJF0JyQpFiNCeENP5unjeE0Mek
         ufA0IS/hpepsTIdpNZNLaPmyls5M5mXkUjth+Z/5j+B8/yAZ7PPCA/H6QowZifOrCuXc
         PO/H8dvQ1zXqpWY734MOkU5Fr487joA/lk9Eni0pGIJkbuicgs7dGhzcSOfZ5oIdOWe7
         QXEX/ZVAE68aQI75IBgQxwar4nGs5gikYv88/Yb9xL9KtamDZrBJg6YTcBk5KOCq7pCq
         eLLmG3BMp/YL5SopBRT6GVMSV9YOFVPFa+ySM3DXNK+TT2rfmsvyW58tP5nUJvezgZsr
         4LWQ==
X-Gm-Message-State: ANhLgQ1l78Dta5fMwKHGanYxcaZGgErV7eQFGF7/EYK1oqcKtb+YUZGo
        8UWXu1OxiBpu1gh3U8xBr1pdCw==
X-Google-Smtp-Source: ADFU+vsQVINq2XB12jFlGwrLlldGkGz/5WxUV8cQYnSGPxofZHvKAe+lIqQmXoaWxjTZF4JRtCVP8w==
X-Received: by 2002:a63:794d:: with SMTP id u74mr8709869pgc.15.1584955492897;
        Mon, 23 Mar 2020 02:24:52 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t186sm1093068pgd.43.2020.03.23.02.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 02:24:52 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 2/2] pwm: bcm-iproc: remove unnecessary check of 'duty'
Date:   Mon, 23 Mar 2020 14:54:24 +0530
Message-Id: <20200323092424.22664-3-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
References: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Variable 'duty' is u32 and IPROC_PWM_DUTY_CYCLE_MIN is zero.
Hence the less-than zero comparison is never true,remove the check.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/pwm/pwm-bcm-iproc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 8bbd2a04fead..1bb66721f985 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -149,8 +149,7 @@ static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		value = rate * state->duty_cycle;
 		duty = div64_u64(value, div);
 
-		if (period < IPROC_PWM_PERIOD_MIN ||
-		    duty < IPROC_PWM_DUTY_CYCLE_MIN)
+		if (period < IPROC_PWM_PERIOD_MIN)
 			return -EINVAL;
 
 		if (period <= IPROC_PWM_PERIOD_MAX &&
-- 
2.17.1

