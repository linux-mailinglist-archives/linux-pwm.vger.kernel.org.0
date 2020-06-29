Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6945B20E60B
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 00:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391419AbgF2Vn6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 17:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgF2Shr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 14:37:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0DC00F835
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:48:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so16359429wrj.13
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jun 2020 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwP8JJPtcWzsdQkUuHadbU0oZNWmZu/tGYbst3cTQzw=;
        b=ml6IcAS0tlGAbS5Yi35OokE45RxF0PlZ3JGt98gnPLKHcCqHbUXqmS9PdkMcW8MEeD
         nAdpEJRjuEjU33LDGSs8mOeNqej9cQUUwV1oCjYWIHXAYFjc4hoa+NFfqLh2BrXsxGwU
         Aey8Ph72mumwG5PBRJkqa4N/anKJnrLqbygS9IIuId3q0EAMBtuaQiQXgQyF6j0tM5NJ
         JtVTP07i2EIYkDv2ZhkHbxs0BLIMjYw+V1AyJY+Fvv4337ZFXkSSEqBTG0yBYsjHR1+N
         KQfzuVk2r5gIZPDsYhj0V7yJQ2QsN/K2PUwgfx987ITORglch9ODjqGaZTYGtKkfKysx
         VoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwP8JJPtcWzsdQkUuHadbU0oZNWmZu/tGYbst3cTQzw=;
        b=ffvgpX41hIA5urOJDPU2bzguiJFhLrSwC6GT/ER3saumToCWNTkBSC+vN8AmL2uwTD
         TZr+DrnomtHVdrmeix7YFjRe9ay/8v6sfXVKFg1tpyUBLlV1ZjPYkdHKw+vdSQsfyvMu
         dUoA+idI1+PjljT2uFLylal4/FfSW/v4k5AdEBIpZj4hXJi1w5fAlShfv3Ghc/XLXjaF
         qL6sxgYII745AqOapaDG10s3KKI6taQpFtiRZMdgMIEDB1suQLEhz+jdTztS2E47QaHd
         EICELYnWIw3HhlcLw1zJkkGHgpthu+VaXsXkQVj4QcP/lyTRNxgG2BVs+ggsNZKptSo6
         mHBw==
X-Gm-Message-State: AOAM531Rl5d2jDDc5vtGfCID67T8Jt4Vfxl1dVy2pmofj4IEdKUb4kho
        oxBmTDX250HS3HuymtJUYNlmnw==
X-Google-Smtp-Source: ABdhPJyQbkunaPWZht+ebwYU90pHFsz7tFovsxHwg6ZqsdgLm+mjM/1dJO07LLGXW+vHYNN8S/XRew==
X-Received: by 2002:adf:f350:: with SMTP id e16mr16440164wrp.43.1593434879632;
        Mon, 29 Jun 2020 05:47:59 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id e17sm12995924wrr.88.2020.06.29.05.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:47:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Joachim Eastwood <manabian@gmail.com>,
        NeilBrown <neilb@suse.de>, Grant Erickson <marathon96@gmail.com>
Subject: [PATCH 4/4] pwm: omap-dmtimer: Repair pwm_omap_dmtimer_chip's broken kerneldoc header
Date:   Mon, 29 Jun 2020 13:47:52 +0100
Message-Id: <20200629124752.1018358-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629124752.1018358-1-lee.jones@linaro.org>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Argument descriptions must be prepended with a '@' to be understood
by the kerneldoc tooling/parsers/validators.

Fixes the following W=1 warning:

  drivers/pwm/pwm-omap-dmtimer.c:70: warning: Function parameter or member 'dm_timer_pdev' not described in 'pwm_omap_dmtimer_chip'

Cc: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>
Cc: NeilBrown <neilb@suse.de>
Cc: Grant Erickson <marathon96@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pwm/pwm-omap-dmtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 0d31833db2e2c..75cea7f2aff5e 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -58,7 +58,7 @@
  * @mutex:		Mutex to protect pwm apply state
  * @dm_timer:		Pointer to omap dm timer.
  * @pdata:		Pointer to omap dm timer ops.
- * dm_timer_pdev:	Pointer to omap dm timer platform device
+ * @dm_timer_pdev:	Pointer to omap dm timer platform device
  */
 struct pwm_omap_dmtimer_chip {
 	struct pwm_chip chip;
-- 
2.25.1

