Return-Path: <linux-pwm+bounces-6905-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B06B14C4B
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 12:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309C43A05A9
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDFD28A1E1;
	Tue, 29 Jul 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3bzUXVXk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA72288C85
	for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785397; cv=none; b=WWhVHFl4EPZQeO8O4lmdFdVNblsJK+TdQZX1JMOB5VY34DhS+zQdBFojXibX9o4Ms7pB+JyU5x+T9jjmSKaAFcF/+ojlxBHhuYBD0+vG6sap7dPS1DvJN4NcsICVD3RTCT78cPQyJdXLsgKCXWZUzdZp75Y4nO+esqLC7u35Xx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785397; c=relaxed/simple;
	bh=vFkS3MCcz044w85i6x5Sg9hS8f9ssjZYZP9S3l0oUV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwpGghrSmgx94p61/aq23xAqrGro/CwreT8XJOaFNg5LDBY3/LNGiOf1C+kmen0L5nhJdLq4gTowWjQVZSGf1WTpvRuY4hs8jE2m0+PIveXjdLJlhesldLz7jdabc6cr9O20hSztvYr9F2IVnMP52iu+A0h6tZly+tDTiQr/6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3bzUXVXk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45622a1829eso18870705e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753785393; x=1754390193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7jjlbIUi5gdyqWR9uROLdSWPZjnUGwKYOi8+eCrVJk=;
        b=3bzUXVXkBdKFW4ev8y9adFFqwMtwmK6moQiLCAdHIptAOKAa7GteLDse9/Q8dX7Llv
         Ptxp4Q9ObH7LZeflnp6MZw7uEmmi5Aad2kA1wj/+iquBKNv+t1ZKzKWb3C44XhYtf0t2
         EmlduSgtL9bCcUlS5VzTLU0gGYV/HcKy8yMO/JMXjLN+XZSdSN7m3EQqkj8+t+uAYJLs
         mbh44q8uVn7m3Hk6ARqrqVIWZyr0FUsSetbJUlUAggw1D8AiAlFcDzZ+oQxkl+fACsJ+
         qA+XRKaOAhJTpSfs6/U8Uesyp78Neu5dKhsSJSduKlYn5rNJGz76PtmEPfXrcVDZP/0h
         N+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785393; x=1754390193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7jjlbIUi5gdyqWR9uROLdSWPZjnUGwKYOi8+eCrVJk=;
        b=fyiFo3DKx2xJxsfrvAdBtlxPrg9/F7tv5xoRj44sf+YGVyxTaEZ2u0KS+C8xO5hfv7
         3i0YDqxYPLFWuysffGptSFwABVERHBXHehgzKPKBZ7JUSXXs3kTyZnObYvqiSzutpuet
         kN/WJ0qx0Ix9dpZpGQH9KYWKCs1poTuLC2DXBV6rH+F27H/LPgnlQHpBaVh18Hy5tAiX
         /44TLEq89MlPY4AeC1+E/ju8RlOFFEFxK/iXChTn/hCtqIs4YEIcXe+RALrGgEZ3eZh9
         p5GT/+6r+us5/zihhsBMCY8fN8i/dpCXieD3A+AyNLojrUHiIoUHM69GwzBknYypQ4XF
         25JQ==
X-Gm-Message-State: AOJu0YyRJGS2TC+cP+IW+N9Mo9pUGvbMBlj0mydp288jN6uwAYGqJlmB
	vmxz0J0ZZN4ZuB0VmirPW6TnTHl/9mNalM6/aKbXqodADOjx8XujgNuFN4Gok1uVYKhLzpvDnLf
	kk3Wq
X-Gm-Gg: ASbGncvD/rJZjuEoUFB4vtmMJ//qQSHt9Vxcck9p2TuPPSQqANTO9ff6gCy/HP/Pcl0
	dPS5fScwT4JnuM99/2xa0ZkeHL+Rs+Xy1zrTLl8hQgPL9vUZy38EfuJ28l+qr2aDK0Vu7qa6l3E
	Iq5Goxs9zhw+LQqCXRNqlOuWzPZc/6M2bCGiiN6egWUkHLlBmUVwgtQK0JnFbcDKnqrcZKGtOud
	DxJgTujOF+Ph5HQ8paxQv5rwc+ZXimqZ0aw9HzbbTEEmMOswOktWzHizqnyPVotbRybg2GZiu7q
	JfdbGMNYPknKyE392pQoncQygAy70JoqGdI/KVrM2KzuR12YD4/FOqaGh+X/BoJEvPjYTJBRZ5d
	TlRz7uihL+MBAtwC0RDZKqtYySqXfO5z893Y+qDbrR3/f2NmX4POHl5eWRodTqMBpIhQcP9YQHG
	8=
X-Google-Smtp-Source: AGHT+IE489WzUw79++E6gpy0AVRKNP0OEKvG0wlAV4wlHbkf4ZyMvxG7le8uPm/54WoWsYCi2U1tXQ==
X-Received: by 2002:a05:600c:680a:b0:455:ed0f:e8ec with SMTP id 5b1f17b1804b1-4587c828227mr104851665e9.9.1753785393456;
        Tue, 29 Jul 2025 03:36:33 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4588d86f1basm14853635e9.0.2025.07.29.03.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:36:33 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] pwm: pca9685: Use bulk write to atomicially update registers
Date: Tue, 29 Jul 2025 12:36:01 +0200
Message-ID:  <bfa8c0267c9ec059d0d77f146998d564654c75ca.1753784092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
References: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4024; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vFkS3MCcz044w85i6x5Sg9hS8f9ssjZYZP9S3l0oUV8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoiKQWeJfvL02YkeNuhdb3nFbQJem3gmbhqK06N skiqzjuh3qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIikFgAKCRCPgPtYfRL+ TpY0CACdPgmKq0PzScj3jiGMLo8lamDzzLLZOz/G4MlOknxDQDIz8iJkKeWKlNtjOU33ecu9PeI jgp4YtGjb+ai5aiCmgqqfo9d1/kcVIgDYMB0N8keYJNRLaJOaFyaDq8I2wy2TP6EFNeyieO+6Xu gDxeSlpc5zBH7OpN9yCz8KgEzyXedOOf8pSMtwLc1bN6h/qFw9ZhonPKQuFbwyzkQCePOHvUNdD GhbTxvHrXGthKx0txJ10tjfdkWftWjCMv5NKosO2Izmo3pBb59Z3WNkVDT5dBHJIc/cniSm3SIE M6U1asG2zV8jn7S13FjUe1wlTnbY7qQ7T0KflFMNhxoI2P2Y
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The output of a PWM channel is configured by four register values. Write
them in a single i2c transaction to ensure glitch free updates.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-pca9685.c | 46 ++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 41eb8e034828..75cf10f2b269 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -61,6 +61,8 @@
 #define MODE1_SUB2		BIT(2)
 #define MODE1_SUB1		BIT(3)
 #define MODE1_SLEEP		BIT(4)
+#define MODE1_AI		BIT(5)
+
 #define MODE2_INVRT		BIT(4)
 #define MODE2_OUTDRV		BIT(2)
 
@@ -131,6 +133,19 @@ static int pca9685_write_reg(struct pwm_chip *chip, unsigned int reg, unsigned i
 	return err;
 }
 
+static int pca9685_write_4reg(struct pwm_chip *chip, unsigned int reg, u8 val[4])
+{
+	struct pca9685 *pca = to_pca(chip);
+	struct device *dev = pwmchip_parent(chip);
+	int err;
+
+	err = regmap_bulk_write(pca->regmap, reg, val, 4);
+	if (err)
+		dev_err(dev, "regmap_write to register 0x%x failed: %pe\n", reg, ERR_PTR(err));
+
+	return err;
+}
+
 /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
 static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned int duty)
 {
@@ -143,12 +158,10 @@ static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned in
 		return;
 	} else if (duty >= PCA9685_COUNTER_RANGE) {
 		/* Set the full ON bit and clear the full OFF bit */
-		pca9685_write_reg(chip, REG_ON_H(channel), LED_FULL);
-		pca9685_write_reg(chip, REG_OFF_H(channel), 0);
+		pca9685_write_4reg(chip, REG_ON_L(channel), (u8[4]){ 0, LED_FULL, 0, 0 });
 		return;
 	}
 
-
 	if (pwm->state.usage_power && channel < PCA9685_MAXCHAN) {
 		/*
 		 * If usage_power is set, the pca9685 driver will phase shift
@@ -163,12 +176,9 @@ static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned in
 
 	off = (on + duty) % PCA9685_COUNTER_RANGE;
 
-	/* Set ON time (clears full ON bit) */
-	pca9685_write_reg(chip, REG_ON_L(channel), on & 0xff);
-	pca9685_write_reg(chip, REG_ON_H(channel), (on >> 8) & 0xf);
-	/* Set OFF time (clears full OFF bit) */
-	pca9685_write_reg(chip, REG_OFF_L(channel), off & 0xff);
-	pca9685_write_reg(chip, REG_OFF_H(channel), (off >> 8) & 0xf);
+	/* implicitly clear full ON and full OFF bit */
+	pca9685_write_4reg(chip, REG_ON_L(channel),
+			   (u8[4]){ on & 0xff, (on >> 8) & 0xf, off & 0xff, (off >> 8) & 0xf });
 }
 
 static unsigned int pca9685_pwm_get_duty(struct pwm_chip *chip, int channel)
@@ -543,9 +553,8 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 
 	mutex_init(&pca->lock);
 
-	ret = pca9685_read_reg(chip, PCA9685_MODE2, &reg);
-	if (ret)
-		return ret;
+	/* clear MODE2_OCH */
+	reg = 0;
 
 	if (device_property_read_bool(&client->dev, "invert"))
 		reg |= MODE2_INVRT;
@@ -561,16 +570,19 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
+	/*
+	 * Disable all LED ALLCALL and SUBx addresses to avoid bus collisions,
+	 * enable Auto-Increment.
+	 */
 	pca9685_read_reg(chip, PCA9685_MODE1, &reg);
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
+	reg |= MODE1_AI;
 	pca9685_write_reg(chip, PCA9685_MODE1, reg);
 
 	/* Reset OFF/ON registers to POR default */
-	pca9685_write_reg(chip, PCA9685_ALL_LED_OFF_L, 0);
-	pca9685_write_reg(chip, PCA9685_ALL_LED_OFF_H, LED_FULL);
-	pca9685_write_reg(chip, PCA9685_ALL_LED_ON_L, 0);
-	pca9685_write_reg(chip, PCA9685_ALL_LED_ON_H, LED_FULL);
+	ret = pca9685_write_4reg(chip, PCA9685_ALL_LED_ON_L, (u8[]){ 0, LED_FULL, 0, LED_FULL });
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Failed to reset ON/OFF registers\n");
 
 	chip->ops = &pca9685_pwm_ops;
 
-- 
2.50.0


