Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4524820E628
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404041AbgF2Voy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 17:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgF2Shp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 14:37:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DCBC00F831
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so15252241wmj.2
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3CtQwwHBAUYt5tWEUptOpRirDIZjfKx8cL/+kZ0aGU=;
        b=TqYbZi1IpvUJDffa5OV7Qjrr0N+cDJ9cZOajkmxHXTv6jjxCNtpB2is8KLr+GUNZ6D
         wsWKBVDUmapCkLaM/97Mquh2EEnsU4aZLcuUyRYGkjA9TdTd3MvA8NhMxPf9bSdIUiuf
         sesF6dNfGI25PtjY4+evZRcAg+Pj/rNSZgcudJgTOg4rBIkEPZhFvFPt/hTc20elA1AT
         W07BruFYC45AsFzkmPBPtwvfC9B5Cbe1Zdirxm0UNAQ8oGSf3UL5DJtsts8XTQsP4Oec
         +2n10RLzXOTsbHl6bR1aWOWxe0cfxgqBp4/RhSW6l0vlVG6pun/AG8d7Vahpwcdjd/br
         RGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3CtQwwHBAUYt5tWEUptOpRirDIZjfKx8cL/+kZ0aGU=;
        b=LVQmVS3pif9t9sQYPAHX/3psqIQaJWrorj9+qHO5hymx7dj/nu0Sd0La1wJ0eRbcVz
         8BXAWUxDOfCxoMg8xKv+7ZETEARPeFCBsUw7otfNA/YhGg4689AAvHld4Kmoa6iZ65y2
         L/OHTKs9IA9bshjZUQFwCyBNcNKrfwMed/ngNII5hZ4dmDezsg0TkIQ4qzS2rsbMvLBr
         h9r3QoZ+tmjEfz6+8XabIRTo33UWrmIDA4pIy2/G4DIluHCYkPAGyH97zqHTRjanYPd0
         c3cfxvd+ujlxklBN8J7Z0/krxjwWv4gbY9N/uk+CZ0+DYlBHEodg95rh8UC8gZSk+t25
         Wtyg==
X-Gm-Message-State: AOAM53178739Pqoe3R81ntrkxwPEQczXZKutLAKO3GXx9ewlwawNqJdK
        jkaoe/MfBvNnJ8qg6Ueue2Q9WA==
X-Google-Smtp-Source: ABdhPJxeGeJLZE8P8dHdFHVkY80hy0oIW4BMYmEqs8sF7naCIUyVXxBQDOR2f7ZO+bDIvrZQdliD6w==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr16091687wmc.132.1593434877370;
        Mon, 29 Jun 2020 05:47:57 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id e17sm12995924wrr.88.2020.06.29.05.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:47:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 2/4] pwm: bcm-kona: Remove impossible comparison when validating duty cycle
Date:   Mon, 29 Jun 2020 13:47:50 +0100
Message-Id: <20200629124752.1018358-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

'dc' here is an unsigned long, thus checking for <0 will always
evaluate to false.

Fixes the following W=1 warning:

 drivers/pwm/pwm-bcm-kona.c:141:35: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 81da91df2529a..16c5898b934a8 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -138,7 +138,7 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		dc = div64_u64(val, div);
 
 		/* If duty_ns or period_ns are not achievable then return */
-		if (pc < PERIOD_COUNT_MIN || dc < DUTY_CYCLE_HIGH_MIN)
+		if (pc < PERIOD_COUNT_MIN)
 			return -EINVAL;
 
 		/* If pc and dc are in bounds, the calculation is done */
-- 
2.25.1

