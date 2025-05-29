Return-Path: <linux-pwm+bounces-6173-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94685AC7694
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 05:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD49C3AF89E
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 03:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37F824FBFF;
	Thu, 29 May 2025 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GkHcaWNq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479324E019
	for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490203; cv=none; b=BrLatLhMTFxHem/duA3bS5fd/fhB/nGCt2/yjvjEnrpZc+lNtCSu/qJUpTC4EPQX9fG73lLgr1Tb6k+c1bVYFmJIYOW3N4QfVFXjuuIAcc8eCjDKJEwkpPwalJTW0wEUqY4qeeZMmKQks3HXiIGCkP1INmyyctbhRdC1+aO12lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490203; c=relaxed/simple;
	bh=flsrf78ADstduszuNfIIsFasVeoYk0NLoNIljnBjXqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pV5AP3+dAwVOEWqxikJn1oF5wxb/lzlpc+vHJfrEhBsKarXBTBCZcrB7hRAGE6gPvtll9ynZR+W5W9TZVORjGUYx2zarHKGgj9HQ+meeEPbJWN9mQ66EQe+QU/jm938TFzTsEl+A7CUEUnEhZwN/gYQ17kU9B+CuaTVLE1y7DDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GkHcaWNq; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2347012f81fso6704285ad.2
        for <linux-pwm@vger.kernel.org>; Wed, 28 May 2025 20:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1748490201; x=1749095001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7f3IyERhfqlZ+9BGF7A4Kt5h9pzQNTOt7gsFORfraM=;
        b=GkHcaWNqB3uf2Dku/frlVWBLunpSO/ZkqI/sJDlR2zIYBQjIAesFOGLs+weES9F6Vi
         XIMN0Hgx+9I4IsnIkmMqjUEaYxbuuutWHf6FBMcRSJFck1xycY4u3ArkfwH7T5zBrZAk
         Bpr5VFh0dmytno/nbJmWY7SKncJUJpSI+ZzD9YcNWCAHCDIKYLYBvRqiL8eFLLKrOikY
         KOq0S1zdQlJgMFgi45NddXxd88sAFisarW6wb/b0gaxDSvUToIvOK+yZSQ6IkZTRyOKv
         YDQGI9JyLHZXtFNyHdAt3P2/TTrzzP06ohqZH7S8bwwa2m/eJVA2WODi68q6P0/ljGXG
         tC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748490201; x=1749095001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7f3IyERhfqlZ+9BGF7A4Kt5h9pzQNTOt7gsFORfraM=;
        b=Jzg87GwQUraz0WdwL2mk1WyIH4keO6ZtEXOUlDool+NUf8AQci3Vm5aNpfZgzsIZ6K
         A6l0AKOrITfV/m4DnPTEpEw1Mtt1a9Ec7zuDHU7w6+7KjCDMbo7gnwQjX+dqi4W9ifyC
         AOBYCrtItk5MSL2WXrCgIxB2DahYZU6f0Lpr+kMtXPyfb0Ix4sQD0s5ZUub3ptqB3eRf
         6I1k78KSGK4y3tSMIPM6uofi/GA4ahgUz+FhYcesL79mRyHAigzZLEwy3jvmNDin4VVY
         V/DH1BCTc2MfghjUHKb4NDpFbpJZx51yuGY+C6/6p4NBCAZAxHVWFCo5X+az+Dj//A8V
         HMZw==
X-Forwarded-Encrypted: i=1; AJvYcCVUo347tQZzCTpN475UE+AJzy6sRTHKOTmGco62qw8oWqjm8hSqdj5krbkNZwz5yrIZP9k+D7Tt8j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdkVtJJDoEVUdZeO0aquMOrPEvmcaVQH0mNcMplpwsILcYHZo
	yJhcwWxIGKp+Gog2RnSgt4ena983zYlEZ8CjszPK87eKf6UdtgSZGUp4w2EuKT7XCJo=
X-Gm-Gg: ASbGncsHGhuw7qFX/9+1jP1gU3WM3kpYLQgySaxuNXdNAVRcnd9DyDORgiMeMn3SDF9
	PXITg2PTCmn4yYHrVNUQrtch+YlAsogOWyyvD2/GA5lTHB/fNzV+yo50e9jrJf45tVX2OWW0TNp
	GyNi2qknVzFjVbWT1uPMVuLTwrg5R7beHsVpjH6h5JyH76/29kxT6h2Id4RgRiarXJUlYKbJmdD
	v+IWzoaqHsrXvdNECnxxaRAB7WIKh49huNCx3y/R+GST5RJhgf3spf/t4wlg8D1n2RaqRn8qOr8
	rWfPC+0RLWLN0+7cQPh73lncSK9fR3EONOGAwYt2s2l0QptQWEJXrJTkP+vTDY54wR72g/3O510
	U+DhZFO4t2UQc
X-Google-Smtp-Source: AGHT+IH5Y8EDMppSiMya4T548VEwYkSKhJqKlchdDU2Hj4M6cj23ihri+hOVMR8Z2nfo6I1IKGtyrQ==
X-Received: by 2002:a17:903:4283:b0:234:bfcb:5c1d with SMTP id d9443c01a7336-234bfcb5cd4mr70545935ad.40.1748490201163;
        Wed, 28 May 2025 20:43:21 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd92c7sm3425905ad.62.2025.05.28.20.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 20:43:20 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>,
	kernel test robot <lkp@intel.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v15 3/3] pwm: sifive: fix rounding and idempotency issues in apply and get_state
Date: Thu, 29 May 2025 11:53:41 +0800
Message-Id: <20250529035341.51736-4-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529035341.51736-1-nylon.chen@sifive.com>
References: <20250529035341.51736-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix ensures consistent rounding and avoids mismatches
between applied and reported PWM values that could trigger false
idempotency failures in debug checks

This change ensures:
- real_period is now calculated using DIV_ROUND_UP_ULL() to avoid underestimation.
- duty_cycle is rounded up to match the fractional computation in apply()
- apply() truncates the result to compensate for get_state's rounding up logic

These fixes resolve issues like:
.apply is supposed to round down duty_cycle (requested: 360/504000, applied: 361/504124)
.apply is not idempotent (ena=1 pol=0 1739692/4032985) -> (ena=1 pol=0 1739630/4032985)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505080303.dBfU5YMS-lkp@intel.com/
Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index f3694801d3ee..4a07315b0744 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -118,7 +118,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
-	ddata->real_period = div64_ul(num, rate);
+	ddata->real_period = DIV_ROUND_UP_ULL(num, rate);
 	dev_dbg(ddata->parent,
 		"New real_period = %u ns\n", ddata->real_period);
 }
@@ -143,8 +143,8 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->enabled = false;
 
 	state->period = ddata->real_period;
-	state->duty_cycle =
-		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty * ddata->real_period,
+					     (1U << PWM_SIFIVE_CMPWIDTH));
 	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
@@ -159,7 +159,8 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long num;
 	bool enabled;
 	int ret = 0;
-	u32 frac, inactive;
+	u64 frac;
+	u32 inactive;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
@@ -178,9 +179,11 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * consecutively
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
-	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
+	frac = num;
+	do_div(frac, state->period);
 	/* The hardware cannot generate a 0% duty cycle */
-	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	frac = min(frac, (u64)(1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	/* pwmcmp register must be loaded with the inactive(invert the duty) */
 	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
-- 
2.34.1


