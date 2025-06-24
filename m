Return-Path: <linux-pwm+bounces-6518-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BBAAE6E7B
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 20:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C347618896B4
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC7D293B46;
	Tue, 24 Jun 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PdC2A+s/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAC4C74
	for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789002; cv=none; b=rro76yjnPdl1z1S5GbDT/hdzOCoN+1PZAazeyGl9pr+obrB2SuhFP2Z3DYTjNCJAczB8oY1J60xxqD4/4jSu/1+9v2S6+htQ4Vdn5hKyYjJ8DAs3dNJulJrHWSYu3cYQSXGXgJlnxgqn5wx3F2/ziqZkwKAYoc2vh5RcnFL9VHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789002; c=relaxed/simple;
	bh=07qUO0a/FFU+2XxsPvnERnYAeT3OnzxdRrCYJ4JyoxI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKxckUDuAUe2TSb4gS8O12WBzPWxa0GnaKnhOxTS17/wfqHCHJtNc4gG2mFQpnAnKbeGrInGtL7ByQkvfY4cJMC11oLeZ2UhJqx4EpMNlq6aV2I4JxPUuJgcFxl4kufOG011htUQxFFXgc88FlbaD5ntYetoOCXGeadhuCKfRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PdC2A+s/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so1554264a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 24 Jun 2025 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750788997; x=1751393797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avThZpHCsqnaSDbXwixa8tEDkSJs0kRoED3M/W9F2iA=;
        b=PdC2A+s/3yd/+Sthtkc24fp2nvVQ3w3rVCKykq14JBQNqrFWxrWW17D+lDTXG9CRNe
         pJK43P63rVgveLf0YQNJA6S9Hd0oHldqCGqp91JK7sRMcuSksHZZfAripzUb+/AhOMKM
         RcBCKPStNqTxa3gnUAd1+6WLQEpNsaUZfOJ53PodtjYg8jXrnFFZ+m4wmSg64WH1XL+Z
         NlYQHHSa+VQsW+MDdOtfRRdDDSKYYAQFmMxNIwBoAOGIF5/IQx+wZe2DMjeDPDH+7rjj
         vtJdWTvFBDNsGESoahcDXjgUc0ZilJ1Dted35/Mag9BNJn82lP/yj/NeV4ENCpts0fdy
         phsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750788997; x=1751393797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avThZpHCsqnaSDbXwixa8tEDkSJs0kRoED3M/W9F2iA=;
        b=RxyyyHnlhPNiGJp3exTP5NKDrRr59FTeWQvOwPeJoOd1G2pTE82dgWSlN36ioafDJE
         R6Y37b+vMa4OKkAU4+0VWkNWuzUW+vXTPTWByYBZAKxR3RUO/psGj/iT29eLeUDoySxl
         7JNvfLSOp0iquqt4YaLO8w0m7EeCwz30uWiy2TczH1gx+JKmYnWyso188Vb3YpZNLUrR
         lqiPNMrtVY3C1yV7nSDkkvY3xER5iobSBHbuk91HbqyoVbOORt7IqT74lXB6Dtq/jP0e
         EFdbY/bN7ETnba3ehaJjWE9wVh3UKuJLyNKwQyXPUmkmzCtIhRGJ7NSLt+k6p7zNuNFU
         gQIg==
X-Gm-Message-State: AOJu0YxgsodE3dJUTw6gMMQKBC1wZ67ztI1cwL1fQfyW4trQaNlsuCKw
	AS53ecVKAb3lgLbd+ZRqFdhRtUI5OX9wI+ffnyL3hetqXpLp6yK5LQ6SMk2WlukDerZW4f/MOQR
	wOpJs
X-Gm-Gg: ASbGncvl6iZTVrp3iqkZBHZWvo65gSyX71KKkazSdaxj8ipB+ccyjOUXjilIqFibQXn
	tGOEKBAoEZwMDRsP9Ym/9U+uAFlEZxzVJ0hJWlNJnfetVXxU5DBeZfKfQXxWikpQEi8hEylek8h
	waEuUYElqYs998sbqgzu1ifdw4+i+E5uJ3z4cCZ4JIpOhhMfVgDo7v+3iE02bRq6D1nPoxcbCPk
	sslfS30BuSfW8FP/ZtKRN/0xl8vCoD4pOcsgPZua4jFhtwqRWg57EOTFHBxTWb8lZwObYHHfufJ
	VvFB7ppXOW1LJxxgRCgSj+SiDswhXmzP4kDF+4zsY3SYqKvFZ1CEzt+o6zIaqg7Hn24=
X-Google-Smtp-Source: AGHT+IEEBCKZix4/4YtiitKFgSGiWWMurVfPX8hmEEp1MOM2P8NirjzK4LP1+hfdlKFtnS6vXIxFxg==
X-Received: by 2002:a17:907:e885:b0:ad8:9e80:6bb8 with SMTP id a640c23a62f3a-ae0be7f70e0mr33290766b.6.1750788997131;
        Tue, 24 Jun 2025 11:16:37 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae054209a52sm923319966b.179.2025.06.24.11.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 11:16:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 8/8] pwm: twl-led: Drop driver local locking
Date: Tue, 24 Jun 2025 20:15:44 +0200
Message-ID:  <c1c7f646190f7cb2fe43b10959aa8dade80cb79e.1750788649.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
References: <cover.1750788649.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6398; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=07qUO0a/FFU+2XxsPvnERnYAeT3OnzxdRrCYJ4JyoxI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoWutkTCdqYLuRo28Y9x6Xd29GxbAUJ+TbM52kI VeRcG99bt+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaFrrZAAKCRCPgPtYfRL+ TkX0B/4qv1ztqD67ikWe5hW6NXDMoYZbX0Fx2c0YTGC6qA9+kQHOFuzhrZqZbyBY8CjYUoP68S6 urLZmVd7IwEIWswpHulx7I2vlY/P+JYJQ+r4hF/4B2yXIHclhaLUAAWBmMs4w/H0YkU1dNtygm4 BfQ5YHalnPcpxyzWTto0y+rfdmjAvN65o+C/kniNIcxMOWMgxm3fd3YIHyQUjQYfjNmKTnDLIKY 4Yz5Dm/idwzZ8WBw/dc1uq43sisXwl7G7KSw+SysP/jkAhM2ZekeMsKXT1jxT1LHQ/7rdJjnBnk qQ5VoshgjEuFe8AchBXvZDqKVJhSNKivhhXsWDHCWRGYt3Ax
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pwm core already serializes .apply(). twl6030's .request() and .free()
are also already serialized against .apply() because there is only a single
PWM. So the mutex doesn't add any additional protection and can be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-twl-led.c | 49 ++++++---------------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 4b10a8dab312..a555cc3be4b3 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -61,10 +61,6 @@
 #define TWL6040_LED_MODE_OFF	0x02
 #define TWL6040_LED_MODE_MASK	0x03
 
-struct twl_pwmled_chip {
-	struct mutex mutex;
-};
-
 static inline struct twl_pwmled_chip *to_twl(struct pwm_chip *chip)
 {
 	return pwmchip_get_drvdata(chip);
@@ -106,15 +102,13 @@ static int twl4030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int twl4030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct twl_pwmled_chip *twl = to_twl(chip);
 	int ret;
 	u8 val;
 
-	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_LED, &val, TWL4030_LEDEN_REG);
 	if (ret < 0) {
 		dev_err(pwmchip_parent(chip), "%s: Failed to read LEDEN\n", pwm->label);
-		goto out;
+		return ret;
 	}
 
 	val |= TWL4030_LED_TOGGLE(pwm->hwpwm, TWL4030_LED_PINS);
@@ -123,23 +117,19 @@ static int twl4030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (ret < 0)
 		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM\n", pwm->label);
 
-out:
-	mutex_unlock(&twl->mutex);
 	return ret;
 }
 
 static void twl4030_pwmled_disable(struct pwm_chip *chip,
 				   struct pwm_device *pwm)
 {
-	struct twl_pwmled_chip *twl = to_twl(chip);
 	int ret;
 	u8 val;
 
-	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_LED, &val, TWL4030_LEDEN_REG);
 	if (ret < 0) {
 		dev_err(pwmchip_parent(chip), "%s: Failed to read LEDEN\n", pwm->label);
-		goto out;
+		return;
 	}
 
 	val &= ~TWL4030_LED_TOGGLE(pwm->hwpwm, TWL4030_LED_PINS);
@@ -147,9 +137,6 @@ static void twl4030_pwmled_disable(struct pwm_chip *chip,
 	ret = twl_i2c_write_u8(TWL4030_MODULE_LED, val, TWL4030_LEDEN_REG);
 	if (ret < 0)
 		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
-
-out:
-	mutex_unlock(&twl->mutex);
 }
 
 static int twl4030_pwmled_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -209,16 +196,14 @@ static int twl6030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int twl6030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct twl_pwmled_chip *twl = to_twl(chip);
 	int ret;
 	u8 val;
 
-	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
 		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
-		goto out;
+		return ret;
 	}
 
 	val &= ~TWL6040_LED_MODE_MASK;
@@ -228,24 +213,20 @@ static int twl6030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (ret < 0)
 		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM\n", pwm->label);
 
-out:
-	mutex_unlock(&twl->mutex);
 	return ret;
 }
 
 static void twl6030_pwmled_disable(struct pwm_chip *chip,
 				   struct pwm_device *pwm)
 {
-	struct twl_pwmled_chip *twl = to_twl(chip);
 	int ret;
 	u8 val;
 
-	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
 		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
-		goto out;
+		return;
 	}
 
 	val &= ~TWL6040_LED_MODE_MASK;
@@ -254,9 +235,6 @@ static void twl6030_pwmled_disable(struct pwm_chip *chip,
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
 		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
-
-out:
-	mutex_unlock(&twl->mutex);
 }
 
 static int twl6030_pwmled_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -287,16 +265,14 @@ static int twl6030_pwmled_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int twl6030_pwmled_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct twl_pwmled_chip *twl = to_twl(chip);
 	int ret;
 	u8 val;
 
-	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
 		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
-		goto out;
+		return ret;
 	}
 
 	val &= ~TWL6040_LED_MODE_MASK;
@@ -306,23 +282,19 @@ static int twl6030_pwmled_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (ret < 0)
 		dev_err(pwmchip_parent(chip), "%s: Failed to request PWM\n", pwm->label);
 
-out:
-	mutex_unlock(&twl->mutex);
 	return ret;
 }
 
 static void twl6030_pwmled_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct twl_pwmled_chip *twl = to_twl(chip);
 	int ret;
 	u8 val;
 
-	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
 		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
-		goto out;
+		return;
 	}
 
 	val &= ~TWL6040_LED_MODE_MASK;
@@ -331,9 +303,6 @@ static void twl6030_pwmled_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
 		dev_err(pwmchip_parent(chip), "%s: Failed to free PWM\n", pwm->label);
-
-out:
-	mutex_unlock(&twl->mutex);
 }
 
 static const struct pwm_ops twl6030_pwmled_ops = {
@@ -345,7 +314,6 @@ static const struct pwm_ops twl6030_pwmled_ops = {
 static int twl_pwmled_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
-	struct twl_pwmled_chip *twl;
 	unsigned int npwm;
 	const struct pwm_ops *ops;
 
@@ -357,15 +325,12 @@ static int twl_pwmled_probe(struct platform_device *pdev)
 		npwm = 1;
 	}
 
-	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*twl));
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, 0);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
-	twl = to_twl(chip);
 
 	chip->ops = ops;
 
-	mutex_init(&twl->mutex);
-
 	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
-- 
2.49.0


