Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D473954C6
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 06:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEaEsL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 00:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhEaEsK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 May 2021 00:48:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81326C0613CE
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id df21so11970265edb.3
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QVg7Hdl4/ZVFOwC3zdm+BtLAL/F8bdjWGF9QT4YTdO4=;
        b=OD5S65QZS3iZyC4Zwlx2TkaDHQa6IzCi9DD8krUyi0osNRlwD/CF+7Q22MY+oOnnJa
         lvo3pxndm9A+HqC/jvsLwMOrRpROf7oKOXPOzzcmmbdUG0asCnUy9LRmZXj+W3vcreqM
         fqERsSCercBb8Dk0Y3aU/PfdrqFGpLFWS/VHgzV+IrcZGrDXL0YpQnPw2+kN2gTYRuPK
         IAjoRdliJBA64SgjMWpXknEfJZ5nkL4Mw3h1pxIhAyc8jRYY3cHnzh8HccH7csXR543C
         RseTB3a3ChOqipdWlv40xL5tFgkjznFX+XTnqDeELDLrqNmzKpN2C0zXeuSnAbRoeScb
         /JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVg7Hdl4/ZVFOwC3zdm+BtLAL/F8bdjWGF9QT4YTdO4=;
        b=nf79Vlbm1FtR7Q+0fUn4lWmqCSiU2vZoC4Uu40LNzQCBp4sw/7P7IJgtnHzAEiqgyy
         wLj2iUYoh93+U561W8XvXWRcfh4DyRAYYTv6UvMUcnJUpBvuHQhsEXGLQxMg8lyd+BLS
         48GAvpQuZ7Ca+cx+/Xns6/nLUVj51Jq+rx6vI/eVouEvnNNvHvoMk7yOXX4DAoApBfN3
         4OoVl5e1TTOeAJjCUglxtO+Xk9Ir7u3hwMth+1Px/pPSYrOX3wPSeqwur3UMq4R5IfYH
         6V17LnWv17oJVlfdDykRP3uWSsFtf5U8F06S5FUH3G0rI3OVkQPpNlMeb7XGvo+Oi9Sj
         0mnQ==
X-Gm-Message-State: AOAM532RKrgiJofdefLcU5YzFn3QOZ9BYqsZo3cMJnOurmmYfeJr3O04
        qHtmEuTbGluQqrA0fkEEpm3tGA==
X-Google-Smtp-Source: ABdhPJxsQ+/nHjpVQtyAxvH1LPlS/MyEUURoxZBF/XAqcXhXjL3TGweCjrGnBsD78Gk8GZai/gBaIg==
X-Received: by 2002:a05:6402:b8c:: with SMTP id cf12mr23173772edb.61.1622436383155;
        Sun, 30 May 2021 21:46:23 -0700 (PDT)
Received: from zen.local (ip-89-103-215-157.net.upcbroadband.cz. [89.103.215.157])
        by smtp.gmail.com with ESMTPSA id h9sm6238376edt.18.2021.05.30.21.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 21:46:22 -0700 (PDT)
From:   Roman Beranek <roman.beranek@prusa3d.cz>
X-Google-Original-From: Roman Beranek <roman.beranek@prusa3d.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Emil Lenngren <emil.lenngren@gmail.com>,
        Pascal Roeleven <dev@pascalroeleven.nl>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: [PATCH 6/6] pwm: sun4i: don't delay if the PWM is already off
Date:   Mon, 31 May 2021 06:46:08 +0200
Message-Id: <20210531044608.1006024-7-roman.beranek@prusa3d.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
---
 drivers/pwm/pwm-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6ab06b9749d0..88bd90498d1f 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -304,7 +304,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 
-	if (state->enabled) {
+	if (state->enabled || !cstate.enabled) {
 		mutex_unlock(&sun4i_pwm->ctrl_lock);
 		return 0;
 	}
-- 
2.31.1

