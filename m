Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F38218EFFB
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 07:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCWGxr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 02:53:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37945 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgCWGxr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 02:53:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id l20so13407199wmi.3
        for <linux-pwm@vger.kernel.org>; Sun, 22 Mar 2020 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DuqutkfVD4m7NtyrXjd1qFiuKaLZ6gnOOVtPX0RgVTY=;
        b=TguF1o1/qlgnZwU27lTm96jgi4/VmGaBU9Eea/Y1AGY4nm0JxN1hlQq8gngr0eXvRZ
         COkqUxmF+S78f7qM1i7WsXFrGqJBmuvAzIxi/Mx3KFXr2kUiPBQfEB7TEazWvWf1EJ8d
         kBhyfPSYv7fRe/9sVm6xPmpCcJzBLyo9FjBsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DuqutkfVD4m7NtyrXjd1qFiuKaLZ6gnOOVtPX0RgVTY=;
        b=c8ZzJLTSsBe9wkRVxcaMPfzomInQ1ZZUFuJoo0Ri4nWRjW9e3MVN1/HaOqRZnXBh1c
         GKT8BrLdrxkUL3q+W7imNlWi6HFXuzL4nAjWxeM+n/ju6GraLP3HRrKnfN157uV9zRxh
         qydc86GJVWUyw0ITOssPRYc7AKIe7AKIQq03wIIENOrSlGbpjCTHeDGJR/OFSf2kRNtM
         BUPiToj1Es8SfZMTzyx1USvAgN6XKyZ1TxNUH3AD1RzS/jnAr5RozoDTH0CA+agqSUUA
         AZxHx54vGSnBQAGkmvMtn2Wx3xNiOBiWyCV5j8HIYNyD8CwqjsV7FbuJJqmTbrzAhSCq
         N2Gw==
X-Gm-Message-State: ANhLgQ33YQcscETIHoSIXnXxT7EtwwxS8riILYhjRAIAnruJQmXdSyQ5
        0RuinMlVK5ExPDkYSS3Q6eK5/w==
X-Google-Smtp-Source: ADFU+vvTcWQvI4pQ74ETn6iuJkGTxDPyFfqkWItYiIQQfNbGj4qUUZzKTb7JO1lqWDauafYBB0xF4g==
X-Received: by 2002:a1c:196:: with SMTP id 144mr26056577wmb.100.1584946424816;
        Sun, 22 Mar 2020 23:53:44 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g128sm21127453wmf.27.2020.03.22.23.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 23:53:44 -0700 (PDT)
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
Subject: [PATCH v1 2/2] pwm: bcm-iproc: remove unnecessary check of 'duty'
Date:   Mon, 23 Mar 2020 12:23:18 +0530
Message-Id: <20200323065318.16533-3-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Variable 'duty' is u32. Hence the less-than zero
comparison is never true, remove the check.

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

