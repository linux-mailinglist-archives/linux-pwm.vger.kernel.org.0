Return-Path: <linux-pwm+bounces-5870-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F9BAB0F65
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128821899C13
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65F28DB78;
	Fri,  9 May 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kHdChev1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788B18E02A
	for <linux-pwm@vger.kernel.org>; Fri,  9 May 2025 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783715; cv=none; b=P6WqcCNxcw0GAjuhvDs9A3apw3bVpAAC8IqJBtvsf1deGmRg15VqWZtbFtxke5xdD/mWqHD3kuV2CZoBlo27c2K9gDRUylSVDV7NuzhzGw5iUrudhhBNNZ2Ctv3tfxUoKL/YM58ci++Lx91wI9KKlsJzNdoTF4t+nfThCHPIT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783715; c=relaxed/simple;
	bh=5Fho6oc6oCSAcMIq7sBJ+jJgp2mgJUTo8ceJNyolcho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCiKvz4HqRZZQWz5Xh4L2/OIHoQzJl0hPUsqm2p2kt+74gaQifQBwv6OIhMEz90ouOkqrPxQNIwsaaV8EczJrk5DLGGprOZmbZVJ+UVWZJolJIMFdFeRN4C5im/43fYPAA34BDjqhcQDSfCA1RKDef0+fsHdyf5MTSXMryxETgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kHdChev1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e4db05fe8so20433445ad.0
        for <linux-pwm@vger.kernel.org>; Fri, 09 May 2025 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1746783713; x=1747388513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugS8tql+ZkgpltWYLoVv6syziSyX6JXa04P6wg0Uox8=;
        b=kHdChev1wskK6yqwWjc+uqHTpFb+3/dS87tx0oepj28/fVmx+ougmKYFRDUE4GrAvO
         H0D1gWmp0WPhXXiRZMKu/9H/S3ifoeBugb267EjL9vy7ndvjJ7xc6UAtLmWl0IRZD+XZ
         w2N1Q2nYGUZMk5Ytu6E8IrDna/vu/6nDLYXvSq+H/bFI7jt1dzdFYlO7qI7rUdSjwb9X
         1yOATX7ORkA/wWUhrwJCDkRb6iZjbwBt3n1Lj/Abnx5CQvZGPAwkmC88aCt8zA/aak+K
         gyvSmdL3vA9dJ9NN0QTt38O+JZTB6fyEx4yn2yoCiprj691fHlAsXSDP66cNBZMcY+hk
         ZFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783713; x=1747388513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugS8tql+ZkgpltWYLoVv6syziSyX6JXa04P6wg0Uox8=;
        b=ZjfblzT+N1CXvr5k6vJrI/RjAFGvfYH4dUsWmDCeGD2PpKrrsbHoxjpa4YlA/IhWXN
         a/XXVgnVHtfWopuuE28Ey0csQUd4NzNxGx9yu3y3G3ondOW1CXqgTSMIdx38vHAbCosk
         ss2YHBktCA/oMR10JDoFHVaYOAzbA5+qSFNAK74BmPq/TsaVuNtlxVu4VXqKzIdg+uII
         57q79oIvomP5LEgcCznyrrKH/v2cLgoTDzS3iUrmnoSu6+kqO4mdMw2dJLdCWdV0vznY
         WYvEXjlSXnWERiC5nmBjNHbuvFfnidI1fHtmVwieTxoA+rwhlRMFRtJb36Yp9Z93XqvG
         dUUA==
X-Forwarded-Encrypted: i=1; AJvYcCWvaEclj0i9WrUgr6KmJEUmXhgbNnQsJdtvxKI1mA+CEWrqTSOMmHxPF3Lqy1b7L1M81iId/RM6bwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ1FqwqpFLa/nNH0A3dlwm+5c2iQit8KsHYEqGZbNCYnZr+FVn
	wWRao/726svMGAmGbCaiHZFvaK+uTlAKoFSLV//3ufT3KNseOhI3buaeAIPHioE=
X-Gm-Gg: ASbGncuN502Lu/m6pLoFhmL1FsgJfK09U7lwlTQ/lUejqq99i1DcYAER3Wec6Ksvc78
	imTgCKVPxQ8uMAgcDwkxaoMxiwDiN0wqEzzpqWWexCr4hz3ANaxVf2+5i7PacxffO1HXTjI+mUu
	shsZj2LfL0DH9OHnr0SnsrSXoNNN5Kx0dhPKhvEmpPeJATYocugYfx2JbRn31IKp49FMoWYUIKB
	Cq1o7PZ2JUNgYjewtzXNRFrXp1hrnKzYv00pbhytbZhQlOAqda4ki4hJBG9gNKvR6+A+ZF+6okw
	8T0U9f2uXzOnqpj8dITL5LTVpvFs7vu3Tgyk29/pRcYy84eOavSkUTQHPrjw6WPPUJZS+ZqSi3E
	aBYy3Vbytq4fD
X-Google-Smtp-Source: AGHT+IFbQW40EyZrlZRGe5s6zM9YRrKDGJY5Na8xxo2g44zO+suwtj7zXhUWYQw4VTbBqnhb3rIQfg==
X-Received: by 2002:a17:903:3ba3:b0:220:ca08:8986 with SMTP id d9443c01a7336-22fc8b3e338mr38936145ad.22.1746783712936;
        Fri, 09 May 2025 02:41:52 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c38sm13271035ad.119.2025.05.09.02.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:41:52 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	Nylon Chen <nylon.chen@sifive.com>,
	kernel test robot <lkp@intel.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v14 4/5] pwm: sifive: Fix rounding issues in apply and get_state functions
Date: Fri,  9 May 2025 17:52:33 +0800
Message-Id: <20250509095234.643890-5-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509095234.643890-1-nylon.chen@sifive.com>
References: <20250509095234.643890-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix PWM apply and get_state rounding to ensure consistency between
setting and reading values

This fixes the reported errors:
pwm-sifive 10021000.pwm: .apply is supposed to round down
duty_cycle (requested: 360/504000, applied: 361/504124)
pwm-sifive 10021000.pwm: .apply is supposed to round down
period (requested: 504000, applied: 504124)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505080303.dBfU5YMS-lkp@intel.com/
Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 6259f8500f71..70cf644cde4a 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -122,8 +122,8 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->enabled = false;
 
 	state->period = ddata->real_period;
-	state->duty_cycle =
-		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty * ddata->real_period,
+					     (1U << PWM_SIFIVE_CMPWIDTH));
 	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
@@ -138,7 +138,8 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long num;
 	bool enabled;
 	int ret = 0;
-	u32 frac, inactive;
+	u64 frac;
+	u32 inactive;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
@@ -157,9 +158,11 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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


