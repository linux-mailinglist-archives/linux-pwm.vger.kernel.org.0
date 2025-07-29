Return-Path: <linux-pwm+bounces-6906-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C101B14C4F
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 12:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F57B54579E
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8A28B4E3;
	Tue, 29 Jul 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ikVhMw9E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F6F28A1FA
	for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785400; cv=none; b=W10VlAK6/4Prves9UShkTJ0xK71ezDWuvVV6Kw3vnCC0dtAHCcqYFeGZhXcqYu/D3SN8trICZBMesUAmQtwH4/FIHKV7yNA8dJQfbPdh8Y5h1xoB6h6aYv6yZYSYmhCmQUrQrR0gLyTKve7xNzAFxgeOcyrxSTWm8bdEu10Kr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785400; c=relaxed/simple;
	bh=xVCQ0H9cdadixp4wtnM9PE8JviA4z1kl3G/Q1/TlS2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ja3SSdoFOsxzY/UJ9yBufm/iV5W1mqmRUxgMhDJ71u/GOfHZBNHUVEM9NA1DrTSr7/kAEbZf6kH5BXV0/sjOJoCbMUmkyZnLEOB53l3cqAn46CH2Srcu2Y75ZzvQSeZtssNGucrwrMydoZOcy2FB88+NhTRtRAu+r/B17CyXrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ikVhMw9E; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso1053408f8f.0
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753785395; x=1754390195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOT/FGVWZXt1k9nEtD7r2OSEKfVEuUP//VH1iukiEmU=;
        b=ikVhMw9EP14utVrUyZzTt8vXSxYR+99KaYziRDjooGT/5vRq1fhPRKgz5HF+IcVJr5
         z+ZH2229PVJ1m6msbmPnWg4TRkma/XU1RYaCaamBKRGvpU8PNt3k7cuYVAYKSSFIzIIp
         EuAI/oJGlHMPW3YIgHW4HLk+Ib1J3FoSlzpFPG6AFMD6FpHRxKkSozLjcF4VGgu/Pi4+
         tzCPmiqY13v/ba9Y0R8sDTZlryosw1SnTkA142i6t39QZuILYYU6c/UUxav0ctUXVL9e
         BLaPXQsolLJxvD7L/CwO4xQTshwNGvx2Qpu2Ytq1QY1tCXTgDHOd5hGx8fwD60ImwzLS
         Ie6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785395; x=1754390195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOT/FGVWZXt1k9nEtD7r2OSEKfVEuUP//VH1iukiEmU=;
        b=CpqnBKRkz95UvlMTk+Z+Bv3tbt6NkD6P4bhiyi1wpDMir3kzs0cjUmSSyC1Gg8nyyU
         O3THceDqRn/NL7JrKOGQomtztd7sEo/gomeBa0Z5B5bVESw2uL8MrYac5aeCWKgKMv4+
         eZR/x4M09XV966Vr8eKHo03U8uNEoP/MLtXQqm6ZT+bGsK+rqCwGkrNMz0CbJVM3QoWv
         tLKKhGqH0o4HrPJ4hqkZpP63+EACBfvNFLAxRsfTuA2rSVN4/V8ZgNz9gbLOU5uxe2Sy
         /DMnRJwthfPd4f1OIJm7f49Mh0fscuWTrJouUpc61VNvgpWPw/Zjb4CiYVVsTjSEazpa
         FJBg==
X-Gm-Message-State: AOJu0Ywi8l4h8gBcxyzuAZEBvbzgrtb7QkFf1JxHEf4dAGrElWATA+0w
	aYr9uCOEGRjTQWA5D8OQDPRnhTfF+W+R2OG1UTU1u1blh4Dw2EbnbuFYU8xhXhN/NXA82qR6u7e
	VmRjs
X-Gm-Gg: ASbGnctNM3f9UWvW+ReeLe2mOFXke0bWOrO+3Wxx/IEQwc+rWVuRjgfiD/PpqnlxMrU
	gMY6Zaq59cV2pIgBo3FBUjC2HM/HWcR3o8UVYC7g2gPcA3Br1R0qFrfxCvhH4ukBaKi/EOYpX1y
	RP3MNxzPug5DvMMEtKXMOh2HZ1lcwZFX74TGDpTwzpYbsoLAzyV0/bZsbvYm23SzeuAH3OrCr/5
	sL2VM7A8I2mv6fASTAYT8jjUnKBoavGxOcYvSukPD2AVYBhgoJN4OW/IPZJTZMEpJFQTLFabFOF
	ItlxnOQh4saG7p2Cb/uHM35iVoPykiSSj+BrnUqjt5AxMXNZBtwrZkWQK7rk60x0vDJKobcQT9W
	UV+DL2x5TEXGJN7NMo/+RGExjoCRtFV7uv4I7CGcHeVOq1szj3lT5yB1YfiPLvmZh
X-Google-Smtp-Source: AGHT+IEUDe5Y8ch5reMaJR+e1UFpIOuCDt4FLaqjklslZwM9SscKPmK3GMlaAo0W9OWsUQ8airUKaQ==
X-Received: by 2002:a5d:5d07:0:b0:3a6:c923:bc5f with SMTP id ffacd0b85a97d-3b7767298a5mr10328260f8f.17.1753785394967;
        Tue, 29 Jul 2025 03:36:34 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778eb284fsm12058183f8f.12.2025.07.29.03.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:36:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] pwm: pca9685: Make use of register caching in regmap
Date: Tue, 29 Jul 2025 12:36:02 +0200
Message-ID:  <dc25361908ad1dd790f108599bc9dbcc752288a5.1753784092.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=xVCQ0H9cdadixp4wtnM9PE8JviA4z1kl3G/Q1/TlS2E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoiKQYvIpI9MwDeOqnxPYjnZJTPNea9xJ6Rux4Y vHLCAtxEzWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIikGAAKCRCPgPtYfRL+ Ti17B/4qD2l36dVNP600NKdoY5Ft0nkFPN587ZhFvA4yMAWrWTr6u5NufyUWbuOIcgmHFI65X19 0UXABHvyhfqtECZhRzLSwa82q+zh6ZTLMZzNb6OQm7BPPJqYKsVfBMueQWF13bR8IWdLTHRNnAk m968ublJe/gsicp9OxjuVrAnoLqqKJR10OUuwn3Umkbg2XsdLFJWFA1tgKzSc/xOP40BK6cEZ26 jqPR3oUFNObN3rzEHi/S0m79KunyTywv8C3VhPosbWmIy+0CNphK2EhxknGmzkUJXWA/d0V8CZ/ zzGHrOmnE26xGk/tROM9WwXViXOygE+PggP7XoehZz31NKAf
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This essentially only caches the PRESCALE register because the per channel
registers are affected by the ALL configuration that is used by the virtual
pwm #16. The PRESCALE register is read often so caching it saves quite some
i2c transfers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-pca9685.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 75cf10f2b269..536a3e15a254 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -521,11 +521,36 @@ static const struct pwm_ops pca9685_pwm_ops = {
 	.free = pca9685_pwm_free,
 };
 
+static bool pca9685_readable_reg(struct device *dev, unsigned int reg)
+{
+	/* The ALL_LED registers are readable but read as zero */
+	return reg <= REG_OFF_H(15) || reg >= PCA9685_PRESCALE;
+}
+
+static bool pca9685_writeable_reg(struct device *dev, unsigned int reg)
+{
+	return reg <= REG_OFF_H(15) || reg >= PCA9685_ALL_LED_ON_L;
+}
+
+static bool pca9685_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * Writing to an ALL_LED register affects all LEDi registers, so they
+	 * are not cachable. :-\
+	 */
+	return reg < PCA9685_PRESCALE;
+}
+
 static const struct regmap_config pca9685_regmap_i2c_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
+
+	.readable_reg = pca9685_readable_reg,
+	.writeable_reg = pca9685_writeable_reg,
+	.volatile_reg = pca9685_volatile_reg,
+
 	.max_register = PCA9685_NUMREGS,
-	.cache_type = REGCACHE_NONE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int pca9685_pwm_probe(struct i2c_client *client)
-- 
2.50.0


