Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9480937775
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2019 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfFFPLV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Jun 2019 11:11:21 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56215 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfFFPLV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jun 2019 11:11:21 -0400
Received: by mail-it1-f195.google.com with SMTP id i21so471773ita.5;
        Thu, 06 Jun 2019 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=5SPGUHVlJick6kceIZSXGPsmfdklx5MdvZ8RjbvntVc=;
        b=lrI7P5Rot6lc2fVWBsIJrP4Oypa0f7ksHYaGart8/4oMRbKAZ2QnW6yv6fWzYSzna+
         bPqb54q+fRid7mgfDhoJBC3fqu2PrIYkGOAdWpZkfGxnGLYSDb8+5Zp09oi7+kmYEuH4
         ZBsvk1iXBaM74qdc+uH4NmU3uI0DmXHNg47/AlznzNrrAj98WXRYGqsQDKKVedHK57Bm
         0yaFXrgbbYzIEmwfXSKaYaDsPGYBo0GKs4tG7UwwnuqEd4XaeC9kbhM359vmo3kIiqK8
         s8oBNuVJHpxUM302ThOTM0AIIe1qWd1wdNU0teQMdhiFsbDpDfxh5rWQTbbTeN3laSED
         dmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=5SPGUHVlJick6kceIZSXGPsmfdklx5MdvZ8RjbvntVc=;
        b=aMt11uBmS2Fa/8BZnjb2xgnIo+7mZHUw1yyOtWf+Gh4CBMOKVhSkkjr8KQWfknlfP9
         rSHsV7vbq8GPkzZZAFlaZHqTHcBsFcxMa9Sdlg8bVZ8/XOZ268be8J4+R5AbvWzG4I8c
         9iXgEfeK0gg2KBw51R9eQ6fP0yM0/Y/cpkZRzIHol64zjhqMFjASAy/y1Ta2P+Eovg5T
         OMdZLuDI3Ygrmnes9RfwDu1q/vq4xb3RDCq5Gltu/SXDl5rxt3oMqG1ftIyTciJOgwq3
         Hkw6noWFDBqP8/s3b0j6VX1TFwv1Y2zXMA9Vm05e6dpc8MDuwsOPOr5gTCW+IDI4lD+/
         z8aA==
X-Gm-Message-State: APjAAAVl9BxTqHzmDlZCVDiXVYWDEUW6/hnbyDLb42f71QlW0uoKhDKZ
        mWa/nR4TSRBj4wv31HDPGmg=
X-Google-Smtp-Source: APXvYqwlXsCpqRur+5Jt8bSFc2RmTw8rvQOpzXBiESeYlHmvIFZOWZwtUO04WsLUlQcc9h9YymsDfQ==
X-Received: by 2002:a24:fcc7:: with SMTP id b190mr478252ith.122.1559833880661;
        Thu, 06 Jun 2019 08:11:20 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id b196sm1028238itb.30.2019.06.06.08.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 08:11:20 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
Date:   Thu,  6 Jun 2019 11:11:11 -0400
Message-Id: <20190606151111.14237-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

I was able to test the patch [1] exclusion mechanism without access to actual
hardware - by giving it a dummy regmap. See patch below.

Test cases (all via sysfs):
1. verify requested pwm cannot be requested as gpio
2. verify requested gpio cannot be requested as pwm
3. verify pwm "all LEDs" cannot be used if pwms/gpios in use
4. verify pwms/gpios cannot be requested if pwm "all LEDs" in use

All test cases ok.
 Obviously, I could not test multi-threaded correctness.

[1] https://lkml.org/lkml/2019/6/4/1039

---
 drivers/pwm/pwm-pca9685.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 259fd58812ae..c059da5f86f4 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -83,6 +83,7 @@ struct pca9685 {
 	struct regmap *regmap;
 	int duty_ns;
 	int period_ns;
+	u8 regs[PCA9685_NUMREGS];
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
@@ -446,11 +447,31 @@ static const struct pwm_ops pca9685_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static int read_reg_dummy(void *context, unsigned int reg,
+			unsigned int *val)
+{
+	struct pca9685 *pca = context;
+
+	*val = pca->regs[reg];
+	return 0;
+}
+
+static int write_reg_dummy(void *context, unsigned int reg,
+			 unsigned int val)
+{
+	struct pca9685 *pca = context;
+
+	pca->regs[reg] = val;
+	return 0;
+}
+
 static const struct regmap_config pca9685_regmap_i2c_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = PCA9685_NUMREGS,
 	.cache_type = REGCACHE_NONE,
+	.reg_read = read_reg_dummy,
+	.reg_write = write_reg_dummy,
 };
 
 static int pca9685_pwm_probe(struct i2c_client *client,
@@ -464,7 +485,8 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	if (!pca)
 		return -ENOMEM;
 
-	pca->regmap = devm_regmap_init_i2c(client, &pca9685_regmap_i2c_config);
+	pca->regmap = devm_regmap_init(&client->dev, NULL, pca,
+					&pca9685_regmap_i2c_config);
 	if (IS_ERR(pca->regmap)) {
 		ret = PTR_ERR(pca->regmap);
 		dev_err(&client->dev, "Failed to initialize register map: %d\n",
-- 
2.17.1

