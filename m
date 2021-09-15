Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD0D40BFE7
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Sep 2021 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhIOG5K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Sep 2021 02:57:10 -0400
Received: from www.zeus03.de ([194.117.254.33]:34020 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236505AbhIOG5J (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 15 Sep 2021 02:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=MKuNVIxx3nvizD
        rJ1e94aXzRhsuvHTdZPjvuEZqvKiY=; b=Rj5AqS/NMNcTFRamgJJNPXvBOXE91i
        jPLIsgq6RyvaOOz0sl7gD/4amqzsi5hZhk9EDPBagIRrIOODArhVyTGIMrw3rY/1
        DAAWHerx9QxWlM4Ef0+0mUzkPKTrMXvC+qrxaVOJE+5thT+JTNpXQjqVYZfuke7o
        ANJwuZsH7g8qc=
Received: (qmail 696330 invoked from network); 15 Sep 2021 08:55:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Sep 2021 08:55:47 +0200
X-UD-Smtp-Session: l3s3148p1@xZQXMAPMnIsgAwDPXwzFAFG7/ghv85hq
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-pwm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pwm: renesas-tpu: better errno for impossible rates
Date:   Wed, 15 Sep 2021 08:55:40 +0200
Message-Id: <20210915065542.1897-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915065542.1897-1-wsa+renesas@sang-engineering.com>
References: <20210915065542.1897-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Duc Nguyen <duc.nguyen.ub@renesas.com>

ENOTSUP has confused users. EINVAL has been considered clearer. Change
the errno, we were the only ones using ENOTSUP in this subsystem anyhow.

Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
[wsa: split and reworded commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/pwm/pwm-renesas-tpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 4381df90a527..754440194650 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -269,7 +269,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
 
 	if (prescaler == ARRAY_SIZE(prescalers) || period == 0) {
 		dev_err(&tpu->pdev->dev, "clock rate mismatch\n");
-		return -ENOTSUPP;
+		return -EINVAL;
 	}
 
 	if (duty_ns) {
-- 
2.30.2

