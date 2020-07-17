Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92281224170
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jul 2020 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgGQRH5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 13:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGQRH5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 13:07:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED37C0619D3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 10:07:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so18242913wml.3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pXdlEIgb0R2eqM6YdIY4bxUBQ/fZpt56c2B8bap1rNQ=;
        b=eu/Idpav/OdqgVR6qapiS1bO3wnmOzjcE1OUoAvo5H5oEuDQbjZcnZ+Fbax2Yv6hDb
         HYMFLf2931dNSUpYBsBUTl9Zm0XUb9PdV3QDWbh57oxIiVXlcdwlcLrvYUaKOUu+ULVg
         C8DAKsbnyY7FKcOTbxqFPARhb4SuJOPnFzQ7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pXdlEIgb0R2eqM6YdIY4bxUBQ/fZpt56c2B8bap1rNQ=;
        b=KXzrsvguf46aYDsi0gH074bEYI1jub+K/gJ790gIbZrVPZzDvIqsT8DDSgYRIpdvKk
         5DwmjhMFIi9hESKO5Jnf7IbG+rOU371tiKC6ckRi8pBzQ3FkCfigOcNFXrKeQ+YYto6I
         eTXHIMZSPS+MQtUPIhtapF1GHXXvrWk82QVXVKmAu+ElvktkDAieReVZVt831QDmg7dq
         vQmK2u+aElr/f1V3PWfvxBcbsnXZE2zte1p4Czd7IgzSftZ/5aW9ZiqqZJ3KTCSMFLDq
         Vf5BD1e4FCI+Vo51WTlOzHdP/DGroCGHseLrg6fTpO+CyqdE7G5J+gEQa0rsSbx1l2GD
         /rsQ==
X-Gm-Message-State: AOAM531zScO7VaDCy00HIHzRaq3jHigybIaYjL52mj40J+Sr+z43a8hr
        qf8Bt9sWxJDZHdJPGqK6OREqcQ==
X-Google-Smtp-Source: ABdhPJw7tLX2tF2i9i6qGLjeSU1c50yI8HpYW5M+zZP+AASu4hYwehwUPlCKKWkBpC0SRRk/QhKm1Q==
X-Received: by 2002:a1c:ab84:: with SMTP id u126mr9951175wme.43.1595005675222;
        Fri, 17 Jul 2020 10:07:55 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g145sm19294145wmg.23.2020.07.17.10.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:07:54 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Fri, 17 Jul 2020 10:07:43 -0700
Message-Id: <20200717170743.25466-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Handle clk_get_rate() returning <= 0 condition to avoid
possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pwm/pwm-bcm-iproc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee7..72a8607b6c8d 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -86,6 +86,11 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 value, prescale;
 
 	rate = clk_get_rate(ip->clk);
+	if (rate == 0) {
+		state->period = 0;
+		state->duty_cycle = 0;
+		return;
+	}
 
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
 
-- 
2.17.1

