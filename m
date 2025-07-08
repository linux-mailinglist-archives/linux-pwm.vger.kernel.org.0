Return-Path: <linux-pwm+bounces-6792-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4B9AFD547
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DDA188CE9C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1D2E613A;
	Tue,  8 Jul 2025 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A7g6Hbt2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C272367CE
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995486; cv=none; b=U4pSMrFfP5wuCNgwhRNkItCf1cvqEAjMh0YEwR+KGlzUTfVu4g1UzVIGqH6VI/8kU10LKeSqGSbfaT9dlZ+1Lk8TpAmzgdPoCayDMeGGV9cKqZJpMIZj+oQ97q5oQnqeKrhtfjbBRaNdxX9S+n+lp/PxGcsT86W9psMKxtzx9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995486; c=relaxed/simple;
	bh=poFBbFWr41hkW0MVwf7u6sMkEq8nnx/qDdk2Ia1bluQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfEnPaa+a3brTZ3llIKwaoDmdOdcmzg9EFUWTSK+in0Sbfoet6PJ603oukC6DA8LqtXiIc8M6/sKDZSUHMQpqcF60/qCqMuS0IyQpONP9A4GG6SaqkItnNgILneBU1CPdytm3tmNlW/veUTL79N8T/ZPEwxW5K4T3mNZoJiEwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A7g6Hbt2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so738216466b.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995483; x=1752600283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7uIrZ2WsytBsqy+vMaxHUtDkPcoQQbc6TiQXB8X2n4=;
        b=A7g6Hbt2rUeHj0T2SXUupZA2Fs3Hgt2kY0l8oIrGrsyPUK1bgkeDp99iSy/g2C/qYQ
         pi0XnXtwwWbJhr2sbXlK5QVF1X1MMqM933mRW+yu4MLQg1wKltkiS9N/rhm3xLObJLU/
         i63DTyp3i3ltF2etN7l+QFCrYEDOybkxVGwrDmOUSOLaPpVFP7KPwB7j6JHFUFzYkWRv
         ub6i0ZwxQPGLQ6zyqt4e3TUWGUeGQfyNVRYe4p0BKQ2JWV0zhZvpZjMBVlU+LYmAcsmT
         IlTsg1myIo5Eo5PNt6A46+L+Qhm2CNxg/kIfMuLuo14EOAEALmmHvdol2vbQ8es66oza
         2m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995483; x=1752600283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7uIrZ2WsytBsqy+vMaxHUtDkPcoQQbc6TiQXB8X2n4=;
        b=N9WQnHZgHR8N8allpsYsY3zSpyaA5KdKo3fPw7gBkOGwSBsW1xmc9Ghaj2MhXqylmd
         CE8rudtGnhTtTq1wpS0JHBHTSqrj5FNE9DaMjqYXAF62X72SceQBrciwqmKi5chB6l6z
         ArCcI3DIt8jgqNz+YYKfUVayLAqclv3SpaXVZ6AZQK/g1toPtDVgu7BCrWHFK1+eh79v
         a4HXLiqLUvaXiBA3tWwBcJ+6b37uf+3/TrpgjKijGehIC5tf5+5VYGv3o1X6Gm7Ohm90
         KHHHsrHa7ACJQ1AZxB3e6Mzm1Wqgi6zIjVCu3DGupl3rsaFsX9SCSZuS6zfDxLWuBkoE
         leCw==
X-Gm-Message-State: AOJu0YzrD5C9OW8s2Qafpg52MBVh8Z2gp5M58VxxwIndAB2YlxOi0G8h
	LyJy8xEGbqJC9Hhj4Bxay6zY8kk6DO9Xw4Q0ZonmKE8pE2Ze/a3+iLE/7myoOIYA2wJOoe8aBWy
	1wfhJ
X-Gm-Gg: ASbGncseYLhE0N4YV1H3I1ngwNHoJsIYwTOZx9Z5ns8nkugAXdQn4RkiyUzAs7hQ3D2
	bGicxxAuV7UfmEkAPL+qrYMPftSp/5TxVcsAHmhOD0PDu19L5fmX6i/e9/k/701Nq1Aag5oXMPO
	F/tQUsACBJlvWP6GW3Y+PGTS38uemjUx66uavG5MXYsd+H1mGnijsu6nyeA1PtXw3fYaB3XrgWd
	dH61rD0UljxOllX5+qx5rvZbCdffJ/5WIdPMqtiNZczh91irKCVw+ELjXVelrLjZrH4OCnxNZ7p
	jsA6dgXAwxKLbGNp+IcGtSF5JbTJtt1vaN5GQvzLrO2mJnMNXize4Q9eE3FcyxPH9zeCvyFyWlZ
	Py2lkdCNP/3AoEX0YdCxaV6c8tLHe
X-Google-Smtp-Source: AGHT+IGD5/L3OABD8tp143eIwzk0cV56BudrL0P8C4cknHfbvAT9P4dsEMNXwoFFRzZw47IAu5tooA==
X-Received: by 2002:a17:907:2d0e:b0:ae0:b604:894c with SMTP id a640c23a62f3a-ae3fe7fd106mr1810759166b.48.1751995482742;
        Tue, 08 Jul 2025 10:24:42 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f6b5e6d2sm919566566b.154.2025.07.08.10.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:24:42 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH libpwm 4/4] sysfs: Implement fine grained cache control
Date: Tue,  8 Jul 2025 19:24:16 +0200
Message-ID:  <6b94a7748509ca1e714c4ca51185371a1e12da65.1751995302.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751995302.git.u.kleine-koenig@baylibre.com>
References: <cover.1751995302.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4202; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=poFBbFWr41hkW0MVwf7u6sMkEq8nnx/qDdk2Ia1bluQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVRLWZbbvhMHfiu4mElhNkNds3m/UiGbdBqCK IoRbEDVzfaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1USwAKCRCPgPtYfRL+ TrO+CAC5Vrti1Kd8oE+mMeRcnKfHYuyGmlHT7s8OqPwPz2Wmg/koxCXJI2QfydBNC14Jerq1/HE mXXj++CzcbDfWeBV7Q1QkEd4TDmMSxFFY4OU+DeYkmoAZ1FtbUKwQE4O3AiZVF9h9lQG/Jc+s+D Tz/hM4nMg1vvIA65WYTc/6tSUzVK5eLEu0e6/v9VkxzyIOqrn6jUBymCNrleTYd/mUyLBvKX1PZ mIKajATr7OnCjro6diB/HZyBGoW5u9XIrmyprGCCZs19vmOOmc6bskhBxk0GQPQ2HziKWLuAkeT 0uKuFyYiMifWYAxeScWkAp1kpDnsiGNfHGAnLlbZEkQ6hatY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

To save a few slow sysfs write accesses, track the validity of the four
sysfs properties separately.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 sysfs.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index 9eac066eb8bf..97e5b6e59ec0 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -27,7 +27,11 @@ struct pwm_sysfs {
 	uint64_t period;
 	uint64_t duty_cycle;
 	bool inverted_polarity;
-	bool cache_valid;
+
+	bool enabled_cache_valid;
+	bool period_cache_valid;
+	bool duty_cycle_cache_valid;
+	bool polarity_cache_valid;
 };
 
 struct pwm_chip_sysfs {
@@ -117,7 +121,10 @@ static struct pwm *pwm_chip_sysfs_get_pwm(struct pwm_chip *chip,
 
 	chip_sysfs->pwms[offset] = pwm_sysfs;
 
-	pwm_sysfs->cache_valid = false;
+	pwm_sysfs->enabled_cache_valid = false;
+	pwm_sysfs->period_cache_valid = false;
+	pwm_sysfs->duty_cycle_cache_valid = false;
+	pwm_sysfs->polarity_cache_valid = false;
 
 	return pwm;
 }
@@ -208,7 +215,7 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 		return 0;
 	}
 
-	if (!pwm_sysfs->cache_valid ||
+	if (!pwm_sysfs->polarity_cache_valid ||
 	    (wf->duty_offset_ns >= wf->period_length_ns - wf->duty_length_ns) != pwm_sysfs->inverted_polarity) {
 		if (wf->duty_length_ns == wf->period_length_ns || wf->duty_length_ns == 0) {
 			/*
@@ -221,7 +228,7 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 			 * minimize sysfs access, keep the current polarity in
 			 * this case.
 			 */
-			if (!pwm_sysfs->cache_valid) {
+			if (!pwm_sysfs->polarity_cache_valid) {
 				char buf[20];
 
 				ret = pwm_chip_sysfs_read_prop(pwm_sysfs, "polarity", buf, sizeof(buf));
@@ -242,7 +249,9 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 
 			pwm_sysfs->inverted_polarity = true;
 		}
+
 	}
+	pwm_sysfs->polarity_cache_valid = true;
 
 	if (pwm_sysfs->inverted_polarity)
 		duty_cycle = wf->period_length_ns - wf->duty_length_ns;
@@ -254,9 +263,9 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 	 * duty_cycle cannot be done in a single step write period first if
 	 * period increases and write duty_cycle first if period decreases.
 	 */
-	if (!pwm_sysfs->cache_valid ||
+	if (!pwm_sysfs->period_cache_valid || !pwm_sysfs->duty_cycle_cache_valid ||
 	    pwm_sysfs->period <= wf->period_length_ns) {
-		if (!pwm_sysfs->cache_valid ||
+		if (!pwm_sysfs->period_cache_valid ||
 		    pwm_sysfs->period != wf->period_length_ns) {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "period",
 							"%" PRIu64 "\n", wf->period_length_ns);
@@ -264,8 +273,9 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 				return ret;
 			pwm_sysfs->period = wf->period_length_ns;
 		}
+		pwm_sysfs->period_cache_valid = true;
 
-		if (!pwm_sysfs->cache_valid ||
+		if (!pwm_sysfs->duty_cycle_cache_valid ||
 		    pwm_sysfs->duty_cycle != wf->duty_length_ns) {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "duty_cycle",
 							"%" PRIu64 "\n", duty_cycle);
@@ -273,6 +283,7 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 				return ret;
 			pwm_sysfs->duty_cycle = duty_cycle;
 		}
+		pwm_sysfs->duty_cycle_cache_valid = true;
 	} else {
 		if (pwm_sysfs->duty_cycle != wf->duty_length_ns) {
 			ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "duty_cycle",
@@ -281,6 +292,7 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 				return ret;
 			pwm_sysfs->duty_cycle = duty_cycle;
 		}
+		pwm_sysfs->duty_cycle_cache_valid = true;
 
 		/*
 		 * It's already known that
@@ -292,15 +304,16 @@ static int pwm_chip_sysfs_set_waveform(struct pwm *pwm,
 		if (ret)
 			return ret;
 		pwm_sysfs->period = wf->period_length_ns;
+		pwm_sysfs->period_cache_valid = true;
 	}
 
-	if (!pwm_sysfs->cache_valid || !pwm_sysfs->enabled) {
+	if (!pwm_sysfs->enabled_cache_valid || !pwm_sysfs->enabled) {
 		ret = pwm_chip_sysfs_write_prop(pwm_sysfs, "enable", "1\n");
 		if (ret)
 			return ret;
 		pwm_sysfs->enabled = true;
 	}
-	pwm_sysfs->cache_valid = true;
+	pwm_sysfs->enabled_cache_valid = true;
 
 	return 0;
 }
-- 
2.49.0


