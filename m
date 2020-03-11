Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68B7181C92
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 16:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgCKPoA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 11:44:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39505 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbgCKPoA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 11:44:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id w65so1556924pfb.6;
        Wed, 11 Mar 2020 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7w1RxHtdaVcThI+BPwF+YlKMi5kQNW2IRPbbioSlIoQ=;
        b=cuZCB0wPKfaINm8GuI4Nvjqwn16Y/MLwhz74fH2UCzG9+BQD1xu1yWLd4NFwLi/zwH
         g+mk6CL1rAuuDewPwdOU/Embv3au9a322GRmJdKselwvmpOsXK7Y4TobX8I6I/AgM+z4
         ofQAxRJKc+sjUGM0+fgWTKv0E47QdDnruel00N2CKhO0vA9Bq7gdUtAzgF4y0fQeAIxJ
         ArwGRza31Wec5R0xUQJBLh9fekmfH6smqX7TuCRf8SBf5sQnLJykXe7IapPzMsokX93s
         vdAZiNm+rEHFLoHZt8CtDnQXn9lrTVBV9rNnjb0Aj5XgEFiqR9N9SUH51NISGSEgtUHP
         rvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7w1RxHtdaVcThI+BPwF+YlKMi5kQNW2IRPbbioSlIoQ=;
        b=OvvveDxrwBRGSvbJZAyPESebleNWM0pt+KjfRnIFQJ2aGX0Bx97FtLiszWis0dlf7u
         wFoOoxgVKcIDhb1n06piUsiTWiFZAnjy1eNOcglAuAYlD/jLqOuzDLExVLVw4m9x3yvd
         5HCICVwjCZxNCxc24lEo8MRVprlP0Jxln32hSHjjZpnEHGrz6UmvlSlfJl6oNQ+7SP9B
         IWBGosbkWw2aBKSFEn2tGj4EYiv4YT4J9Yedz4ry0S2DgqYAAZybW1n2jxLblG/86vJG
         mxM/lFRR1avpeRouY5f+xkmXPWp0PNviRnZ8cpqmh97YFYzVdcicNKpi+cuFwAJegb4g
         pHOA==
X-Gm-Message-State: ANhLgQ0whiAhffDbBPA4gdkdb2VdzUeUyAHEUEK46cWrEwDFWk3AhddG
        QqpOMZ62/th+5RjzqIdH1492awWc
X-Google-Smtp-Source: ADFU+vvZJA05C5Hwe83t4vj/tHRjjx06YJItfDu2bqSzhb7kDXGmMY1ekFS4QfFKov8K8d5SUQmJAw==
X-Received: by 2002:a62:18cf:: with SMTP id 198mr1410237pfy.277.1583941439259;
        Wed, 11 Mar 2020 08:43:59 -0700 (PDT)
Received: from localhost.localdomain ([106.51.109.105])
        by smtp.gmail.com with ESMTPSA id b133sm50903760pga.43.2020.03.11.08.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Mar 2020 08:43:58 -0700 (PDT)
From:   Rishi Gupta <gupt21@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        s.trumtrar@pengutronix.de
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused to prevent build issues
Date:   Wed, 11 Mar 2020 21:13:49 +0530
Message-Id: <1583941429-10921-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The __maybe_unused attribute is preferred over CONFIG_PM
to prevent build time issues. This commit replaces CONFIG_PM
with this attribute.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/pwm/pwm-pca9685.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index b07bdca..b2a9e77 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -512,8 +512,7 @@ static int pca9685_pwm_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int pca9685_pwm_runtime_suspend(struct device *dev)
+static int __maybe_unused pca9685_pwm_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pca9685 *pca = i2c_get_clientdata(client);
@@ -522,7 +521,7 @@ static int pca9685_pwm_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int pca9685_pwm_runtime_resume(struct device *dev)
+static int __maybe_unused pca9685_pwm_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pca9685 *pca = i2c_get_clientdata(client);
@@ -530,7 +529,6 @@ static int pca9685_pwm_runtime_resume(struct device *dev)
 	pca9685_set_sleep_mode(pca, false);
 	return 0;
 }
-#endif
 
 static const struct i2c_device_id pca9685_id[] = {
 	{ "pca9685", 0 },
-- 
2.7.4

