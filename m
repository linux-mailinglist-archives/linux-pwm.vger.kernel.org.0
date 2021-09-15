Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4434940BFE6
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Sep 2021 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhIOG5J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Sep 2021 02:57:09 -0400
Received: from www.zeus03.de ([194.117.254.33]:33996 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236469AbhIOG5I (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 15 Sep 2021 02:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=AInh+WKqpKc2/p
        xWOVf+CRsBWo6Mu/9mGPb/cSxMIlM=; b=BCbUMADu+uFKHLu1gWYmB9MOS0rBLW
        2w8JqVpEu4pYiB+VEzr9k4AWYHeZPpVRQrbWPZYOvzrUtzj7/o0I18Ibc+MSCDAW
        Y8ErMx2iSK+a7ECjf+Q7h+T5iS+bXXPDZVbz1BHnculN93ozDaGIUeEoa4iSGO8B
        d4IdSEX/Eq+lc=
Received: (qmail 696365 invoked from network); 15 Sep 2021 08:55:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Sep 2021 08:55:48 +0200
X-UD-Smtp-Session: l3s3148p1@Z0khMAPMnosgAwDPXwzFAFG7/ghv85hq
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-pwm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pwm: renesas-tpu: don't allow no duty if duty_ns is given
Date:   Wed, 15 Sep 2021 08:55:41 +0200
Message-Id: <20210915065542.1897-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915065542.1897-1-wsa+renesas@sang-engineering.com>
References: <20210915065542.1897-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Duc Nguyen <duc.nguyen.ub@renesas.com>

We have special code if duty_ns is 0. But if non-zero is given, then the
calculation should not result in zero duty.

Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
[wsa: split and reworded commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/pwm/pwm-renesas-tpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 754440194650..bb51156e4bda 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -275,7 +275,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
 	if (duty_ns) {
 		duty = clk_rate / prescalers[prescaler]
 		     / (NSEC_PER_SEC / duty_ns);
-		if (duty > period)
+		if (duty > period || duty == 0)
 			return -EINVAL;
 	} else {
 		duty = 0;
-- 
2.30.2

