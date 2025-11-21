Return-Path: <linux-pwm+bounces-7648-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B167DC7892C
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 11:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 40BF823EC5
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE2338918;
	Fri, 21 Nov 2025 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hYCLHqQ6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCC3242B0
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722198; cv=none; b=D8EFulO4klnIEccewWmCwVfnqL4sN2uW8P59RnZM6h/Kusln1czZOPZwLjZqMqlx8BhYvUKab6lpB2aC2Hkh8ufUcM3yAPnTyhjVuZSsHtGMwlNy26eBW/Bl8OZ27spkEDSQIqqQxOA1QyX7FPptub10MPOziPlmOyP6eS66vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722198; c=relaxed/simple;
	bh=o2GHD2vVQeDTY8Mc2lfZRouJFu7XDQtXdonIBFyUN0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CmzY9G9tMnhtBnGB6kVeHsOA0a4M/AcPiYTVSvSGsvoUmth+tVSeLz48gYJtnXVjBmC317zbdXBZnrIRHqJI3xmt9XwLeiTZHbSnFF9IGxKcnwUmyedmiAMcpWEgtcLHrDdXltkG/LgJo64B5X7fJXOnVYoH+7hPwew9gldltKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hYCLHqQ6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b73b24f1784so356120866b.0
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763722194; x=1764326994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=26UO1qci6mMHxAgNpoSORIQku7Kf9/6dDzmicLSqdUQ=;
        b=hYCLHqQ6Pau5HnEpqy9CQ19ftoW+HMKYvXGOw3bwkkCFjRqqT8lQvu3TJRGmavkm0p
         hP1iXqXCq4TTgq6ZygyEvKxj+XgnUtutFpaD5bq6YbhfeFk5AP2rpS23TID2UdHXue8X
         yqE4fSBIQFbfT4co4FGplk2uFM3JeOooeS630EEVpjfs3W8JaWViDuE0t9qk9pmjVjAu
         iPc98PHlcDraRf9CTFlygVzvfzGDa82Xibl/gwl5UsYXDs2n16R5Je4h/ksx2FFaJ8lA
         o3Gmz+M8uPLrC2NV0aJ92iYtsZorD6MOCBCp458fZomeuBonO7r0QhJn/izknQ5QTsZP
         1hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763722194; x=1764326994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26UO1qci6mMHxAgNpoSORIQku7Kf9/6dDzmicLSqdUQ=;
        b=U7FEwTqNAxgURwBF/TyRP5GPUGuonFSKjry1fh1oq4u4qt4UB3Mq3g8nS+9OjFjsb3
         Xx5W1VF6lDCZjRpRXINAY1cgeDEbs/bw1V/VNjtCQeB7nsBjtw9k826EO4bVbRM2nP7R
         4V0EW58NZ1soU69tM9lcRXvWXnoonsvJcoFuXg7v7TSiO7P5/9puYV5Y+V4G2Kq27r73
         HXDLWuq43JmLkwXKoDzYuOAxoAAPeRM8JDvX23B78BKtroYtz8epR82wlfyc9NtE4GjT
         Ctay2162g2KsZ+VhSVXMCRUwARnq1i5EBgCOALA1IqSmiC4LNqVNiin/jl6uB9hqBk4K
         4GaQ==
X-Gm-Message-State: AOJu0Yzgbu/Y8ZiFguL5y01vf8bX5Y1ScjS7VXNa/2NvaEVNECIDbWr0
	kK03F7wo5cKaQQYk/I15PmxrAmVAxewQB1CsuLFHOeJRMzoqMEiTIpV1asVa3D3ZWDQYWxPWHu0
	q+gfV
X-Gm-Gg: ASbGncs4tDuDBs21xmGLKzNtKFtVvVXaSqmr6J4n3ANh6HPEYaeeUG3WdTyoIPiX0m0
	ouQy3fmQkQdTMGPyX5MF32BqZ+SPSFN8S2U5CTP5bUFjqhDA7W0YDePDIKLF8agk22/0ASNE29K
	acNGxwVz6K4LL08a3rUoYwlunyQGw1haaXyMx2ULg78bp1t/2dYu7+2RfhHwBEY3NRzro2CdOc3
	C019EZqpmXCio79fhSHf5nLzde8VW4MB6aGB0/EqI6rBAaKoKiYymnUAqjytRQcoxGsmmb2Ko1G
	7KTQMoidaTwXlt0+FkLwuiaU8ge1ALmpu0w4LBr1L3mZRtuVa4RR5ylrTjbywPr6m00e0WRKJQS
	W4FSCvbhg1krEYEXBdVcEXdGZCJosHBUdiwzYhcOoyIt2JtoOWlBdPDlDj7ubozybCTVn9tfwEr
	clQLtFdozUahpvaLPjf6ECh7ljdt9uO6JFQrSxje6re0KCxO1ix4y8nfb+gTIdMW4SFEU08WAxO
	lM=
X-Google-Smtp-Source: AGHT+IF0TfelBkjxiYQc0GE74sN1diUpzXarIyeJRib2oKiYskHeLncA/Ko0KFtl3rlsdf6NY7439A==
X-Received: by 2002:a17:906:6a1a:b0:b76:4082:c60f with SMTP id a640c23a62f3a-b766ed82cd5mr266413366b.6.1763722193756;
        Fri, 21 Nov 2025 02:49:53 -0800 (PST)
Received: from localhost (p200300f65f026708fb6c1faf4b8beb83.dip0.t-ipconnect.de. [2003:f6:5f02:6708:fb6c:1faf:4b8b:eb83])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b76550191c8sm417081966b.54.2025.11.21.02.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:49:53 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Emit native configuration in /sys/kernel/debug/pwm
Date: Fri, 21 Nov 2025 11:49:48 +0100
Message-ID: <20251121104947.2652013-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=o2GHD2vVQeDTY8Mc2lfZRouJFu7XDQtXdonIBFyUN0g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpIEPLbmVAFJhuzXbzjrc4pVWyunCrf+6GXEZ5y iBco6EanleJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaSBDywAKCRCPgPtYfRL+ ThhxB/9qeooeEeRgPKp1l4MlA0zhgi/KUP1v9JNWY4pcSnR2a496IqCyBXjG18TCJoFwC3W9EnC WWlCsWUdqqviZgMinCZdrwofmKOyRQRScNaMCzuloZGj+l3iAw0pQ9rtCMcG1hZFfxwu0qRZMln QKBFwabcwvutzT3ZXNsMX93SAzJo3NSXH59gbNzaQLK0YuX8JK/8jQSxds0IP8UOuwYE5ACDOe9 p5xoHeVYiTA2my4yCTJAU8QVFu8X9yJPH9gLaGBvgqEpKVuWcsDDe0czCPV/nizFRsfwZcmHUoA SdyGF8iiNZGuubXcfqdtvbdtAYxj8qia/Vtadqhoryxo30i0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Currently there are two abstractions for PWM drivers. Use the waveform
representation for the drivers that support it as this is more
expressive and so tells more about the actual hardware state.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index cd06229db394..515fdd16f733 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2636,10 +2636,10 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 
 	for (i = 0; i < chip->npwm; i++) {
 		struct pwm_device *pwm = &chip->pwms[i];
-		struct pwm_state state, hwstate;
+		struct pwm_state state;
+		int err;
 
 		pwm_get_state(pwm, &state);
-		pwm_get_state_hw(pwm, &hwstate);
 
 		seq_printf(s, " pwm-%-3d (%-20.20s):", i, pwm->label);
 
@@ -2655,9 +2655,26 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 			seq_puts(s, ", usage_power");
 		seq_puts(s, "\n");
 
-		seq_printf(s, "  actual configuration:    %3sabled, %llu/%llu ns, %s polarity",
-			   hwstate.enabled ? "en" : "dis", hwstate.duty_cycle, hwstate.period,
-			   hwstate.polarity ? "inverse" : "normal");
+		if (pwmchip_supports_waveform(chip)) {
+			struct pwm_waveform wf;
+
+			err = pwm_get_waveform_might_sleep(pwm, &wf);
+			if (!err)
+				seq_printf(s, "  actual configuration: %lld/%lld [+%lld]",
+					   wf.duty_length_ns, wf.period_length_ns, wf.duty_offset_ns);
+			else
+				seq_printf(s, "  actual configuration: read out error: %pe\n", ERR_PTR(err));
+		} else {
+			struct pwm_state hwstate;
+
+			err = pwm_get_state_hw(pwm, &hwstate);
+			if (!err)
+				seq_printf(s, "  actual configuration:    %3sabled, %llu/%llu ns, %s polarity",
+					   hwstate.enabled ? "en" : "dis", hwstate.duty_cycle, hwstate.period,
+					   hwstate.polarity ? "inverse" : "normal");
+			else
+				seq_printf(s, "  actual configuration: read out error: %pe", ERR_PTR(err));
+		}
 
 		seq_puts(s, "\n");
 	}

base-commit: cda323dbda76600bf9761970d58517648f0de67d
-- 
2.47.3


