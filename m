Return-Path: <linux-pwm+bounces-7684-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D4C7E9C7
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 00:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEB97344EC8
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 23:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC3321D5AA;
	Sun, 23 Nov 2025 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1FjoSFb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18A219301
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940963; cv=none; b=Mf1EcMWZRUe9/XptilcuX9xHzOslrpsTZPC+WscegMgGuyzx5LsqAA/J7FWcL6GGqtufG9Jt7Ihs39RkYvz4GU6nkv0bTT8p09O5O8gRTEzeF1MG3EIn2jvwB0OQYm/ZhioZQuHbzrwtCjGh3qqY/+5Dky0rHRrFPNuyxWjh84o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940963; c=relaxed/simple;
	bh=Yutmgf+0zyJZWuWoc4EvaqK1BLYpmqadzFnOz+6WxF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2CbP3DDrZvnEHXAzgvmGtRVeoYvmCKg1TS8XATZgDqiT+Pp6m+hPvu/XNbXaD5XG4iFF9SFH3ZPDfvl6BylvXhZ+e5vwjqi3/0Q52pj4oHj+9dXcq4NjNIKydHjVzVakhQruNnWMskEqjFHh3rzZx6eIArzW0/wwqjWDeUfI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1FjoSFb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b55517e74e3so2639518a12.2
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 15:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940961; x=1764545761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFD8Pckcnr35T6zxdtvCeol/7VJEDag2YusN6DWIaNo=;
        b=W1FjoSFbnxYhNZLpfgzsuuVzGsV+XeRj0gTRq3WDrGBYo68YR134hPkxEfGUGnK4UC
         T2FGWd+8HggDyNjO5WSFmmfTi6KKIzmHVv34P5KvK+N9tCehcwC8Stkrr8izfD2U9XAQ
         cxhPxwhSIzni9USJ5Y3FmHIpGwp9M4XGhgyAHHZuqyexuyJok3kFwS6JouyqKmQPKu/o
         DXkwrb4wl0x6N9d1zUmIDTN59FlAa+xsEYQm1vYMUpru+pWSw9d+27acWP+rgnasEUYr
         R4wfIqbd5GykrSuYtLq8LwuN58eXcWAOZxeCSKtJCucb5V95Mdr/xE5Vpi74dsbf5e2F
         wh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940961; x=1764545761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lFD8Pckcnr35T6zxdtvCeol/7VJEDag2YusN6DWIaNo=;
        b=uaVIHjZIk9oG85l7Qx7DZ9ijoLXbuIIo6U4dhJeX12h4+9NabsPAyUaS+ybrhoCokB
         ntzQQp0XoXUlvh+m60vUaDZGlKBrX3iOMX1BlBa9qqyZwEr3/SraABUZ61ARtj3Ike7G
         643/mirba5WYCuBJ8IDzx7M5jWkY6+jKA59/aunjaVBv2JNrMbQn4adYbJLrLBX+bSYM
         6wEEFGoEA9tLIoaMqkIpMTd6PtxvNAi0SWQN9ANlXUfdIs/GbZQnTVSaK3DBXvBeWBys
         gNaJc6JcxvBWb448GGzt7uXemIi2TRFObF60fOdsGmq2id89UI2VMWhHE1AoMCjMojko
         fyuw==
X-Forwarded-Encrypted: i=1; AJvYcCVztnoDAUFaiowDgGQWTdw0KwF/WEadyLebbiGYuwASnOUMbUid3l22TfUx8afAHvX8C3FWmS2uwl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAIO4m5PDmHXwfupW55Vuvv11VhSEA5xEBbbf2kBfhYER5xqc
	OAbWftBgZFCnem56VDTFVyWZB3NNL9zHMV1T+ON4pl6cLVs6KMm6hGbA
X-Gm-Gg: ASbGncucVKKJxRXwRFiHCvAVgXrDbT8lZz++zaRvlMamdlcMvqUqfRSMNQ9+xLpWa2I
	wl95YOOHtPO8nGHs6dM1AgOPQalq+/WReN9M1JpT9E5muh6HIeCM4cUoD/NkMY9qGKeSSwX47t6
	JHP7zzx97ndOORbQtzoZ6w5oJIKwH5AzX0Gcboalq2PtVGSM3tI8+ll2Uik1sk2DPggZpCSfIv1
	QFtmGoutoncHOIGCPKWnBHrD0i0y43qcmMMhVDYQ7mVplHIFBiIsNjCZKSPo+eJPmcgPJHqr+LJ
	MFU1EsrwZzNTMf88wQI+9KlKrYXTPQdoMXN/pe3Wgno0D/g4Jp+mhzacGEkiMGvjScVtuHw+H0q
	WBsnpohVP9wISySglXhfHO2T/Ve22XIQ9a74RkE5GvkcDWSply7+ic5wNOiwFi5boh4twFY0Q0u
	72LpaMIa1G0wmrCiKk+OeDTcVYnSQTuo/3njCpjmOYqTs=
X-Google-Smtp-Source: AGHT+IEPLLfW6rOEQuuuumu1AV1T1oBcwJJfyO4BUUJyfhUSDenTuVs5bx6aN/8vpxpt4XbgFbmnuQ==
X-Received: by 2002:a05:7022:60f:b0:11b:ceee:a49f with SMTP id a92af1059eb24-11c9d60d675mr5942070c88.8.1763940960848;
        Sun, 23 Nov 2025 15:36:00 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93cd457dsm60576987c88.0.2025.11.23.15.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:36:00 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v6 6/6] pwm: tiehrpwm: tidy period conflict check
Date: Sun, 23 Nov 2025 20:35:54 -0300
Message-ID: <20251123233554.2140-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251123233349.2122-1-rafael.v.volkmer@gmail.com>
References: <20251123233349.2122-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy ehrpwm_pwm_config(): drop redundant parentheses and keep the
period conflict condition on a single line to follow kernel style.

This change addresses a style warning reported by checkpatch.pl.
No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 4def04fc6b1c..xxxxxxxxxxxx 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -233,8 +233,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * same period register for multiple channels.
 	 */
 	for (i = 0; i < NUM_PWM_CHANNEL; i++) {
-		if (pc->period_cycles[i] &&
-				(pc->period_cycles[i] != period_cycles)) {
+		if (pc->period_cycles[i] && pc->period_cycles[i] != period_cycles) {
 			/*
 			 * Allow channel to reconfigure period if no other
 			 * channels being configured.
-- 
2.43.0

