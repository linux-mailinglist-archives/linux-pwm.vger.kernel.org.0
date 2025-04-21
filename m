Return-Path: <linux-pwm+bounces-5611-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A008A94EEA
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818B67A8231
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E1425A2BF;
	Mon, 21 Apr 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BKVBjIQi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D525A2DA
	for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228649; cv=none; b=dFxNfvbdirOdM4pWtilZgwM3mjRzWQsMs1JIojm+EXhf7S0hdrIbUcrtVdzbqJ7pgCL8dRX5lyWBhk2SW6bNKRrnSOLW13ULCNL5GlgQAPq/H+ed6ei33TxQ477Fe7uIQyNwOQg7b13BjuM2TgHiOOvwxpLVvb9/ET5gVpBao4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228649; c=relaxed/simple;
	bh=glrL9frKUynd0eooWslKXIli7Wwl1Of8mWNqeP69AkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4WWqfKfh6g09B/DetiybAK4MpOJ6vrR38e6+5YETx5Otv/OIAWCDfAv/Rjfl4Fc9kcpDdGjonF0oVRDpGQkKm/QfW9SJLjw8+DOZZJ27NO7xRHLmv4BPKHzGzXseB4W8N7EHVaX1UuD23iNk6uHBvI7bRkwHMNVRJWIile/XPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=BKVBjIQi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22928d629faso36884315ad.3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 02:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745228648; x=1745833448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Cqj4QIom4PNiBzVEbYX0WUBXZ7DUraiDzK4MrzGYzY=;
        b=BKVBjIQiismrP4d2X2knFvFA7hR9TLKSswE4YKaV8x3OUYCKNg/M4cXzFmAatrHKzZ
         d12z90rCPVpLmA3KWN/j/s4a/MoWuCQWw4wulweJX9TDH0T8PVpRptbvyn3pUED/PXnJ
         1uEGkGUbyCv497+45A3L/It70ZpyYAymLvNojtg7h61xwuV3ACJBV04RRLSRyoefSJ/B
         OiWUHVPQn+Gq+cNeWze3UARklgsxjF5zc2XR6w91kCZZ+hMFcs1gjwnDrqwTHIIhK0Ue
         Oez15cqJTdjBU/mC21vRolYdVLVb/xsQWO/qpk993vGx+5XXjzj76+g5sjWAAvKPatzm
         93UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745228648; x=1745833448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cqj4QIom4PNiBzVEbYX0WUBXZ7DUraiDzK4MrzGYzY=;
        b=OWsAXriKHf9BoinlGn2nFDIDrjXrmVrvgAY2cizad533rf6FhAEIveaHD+SrC23U1q
         29rv69SBKfWz8o2YVaL+HpLWzjLYOl/9FPsQjFCvM6NynBHeVIS6nsDKtlcuVfEVjlEs
         FgKclhvutV0Vv7ySA7kt/WT/s5PPZxMcAxEJAcJnMFA22nJi0n8tmu3sK5d4HK/m/MPZ
         xjQmRIqgI/t6P/cAa0vP2qmgWOXVUEfQzfdWr4ijgsHNx3GUqceCTVm6RtunROEaT1Dt
         WkkQbd9vbsuhe/4xHKt7/VL/LJSxCQBfNyNkqXG9k1mXu4T7+3S0zrU3Cb2OZt/mIYUl
         pGpg==
X-Forwarded-Encrypted: i=1; AJvYcCU3TfYVhqGhzHyWdztW0nH6rTk4ajT3Y1QwksLx0KiQ7RODxv1IIkU4XsUlGoCP8jRqnfhHP57za08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzph/mBNJhBmD1uxBdBjYsP7vtT8hAMPLi+PdbF7THUXWM/vbqV
	9yOkJgfQTCiqHgMeSq12knMnCL6N7DytxZjvBgTd/rOR6c192gU88Xr3Tn81TFo=
X-Gm-Gg: ASbGnctBb4VGIM+43Zw7M4CyetLKz/vnuJ+5Q4RvbehBmcGVR/WxqAvCqEiDKj7pU6+
	RTRyEK8B/lLurMzSLgyqBuiC/UNrl2V/bYGnyKlI6hcPTzKYYFVxp47AfNCA0tfBPufBRP/H2W+
	ebabSEJ7KG7jzXc5Pxf7yC7qyJwN+O1SWrX14c5aT8DHnej1TdNviH6vbI9KdP9Fr/QgLiAKvxq
	tqRgSsA83RDnB7AfDE66ciPaE0OQl25obEPxw/74ELA3TFa0SMygaHaiJShIQw+Y3EG1QDmRvyX
	Q/+gGYHH3/adoSp4xEfOilZcBRDeFsceE0vR1djujEqwg/zXSER8djdYhJBP1aQRjB92zVJHTfE
	ZxA==
X-Google-Smtp-Source: AGHT+IH9vCtDb7HvKpxpcy9CbAe2VrwR7fXTtTGN3OzMwQYcW6ogAY3TNTBrPavfoyTFcga48z7v2A==
X-Received: by 2002:a17:902:e88f:b0:220:e9f5:4b7c with SMTP id d9443c01a7336-22c53581248mr166754085ad.17.1745228647812;
        Mon, 21 Apr 2025 02:44:07 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaacf32sm6371965b3a.142.2025.04.21.02.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 02:44:07 -0700 (PDT)
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
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v11 3/5] pwm: sifive: Fix the error in the idempotent test within the pwm_apply_state_debug function
Date: Mon, 21 Apr 2025 17:55:19 +0800
Message-Id: <20250421095521.1500427-4-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250421095521.1500427-1-nylon.chen@sifive.com>
References: <20250421095521.1500427-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Round the result to the nearest whole number. This ensures that real_period
is always a reasonable integer that is not lower than the actual value.

e.g.
$ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/brightness
$ .apply is not idempotent (ena=1 pol=0 1739692/4032985) -> (ena=1 pol=0
1739630/4032985)

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index bb9146267bc5..6259f8500f71 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
-	ddata->real_period = div64_ul(num, rate);
+	ddata->real_period = DIV_ROUND_UP_ULL(num, rate);
 	dev_dbg(ddata->parent,
 		"New real_period = %u ns\n", ddata->real_period);
 }
-- 
2.34.1


