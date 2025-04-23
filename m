Return-Path: <linux-pwm+bounces-5666-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE5A98447
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 10:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3991C16C3F1
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593CF21FF4B;
	Wed, 23 Apr 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Je3+X2RF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8C21CC68
	for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398412; cv=none; b=XzDCVIlzxPx+CbT5VHpHuj4ult64PEuiRW0DQlzwMO8nDgU8wbMnpORVAjDNLer2VqXiycPtUumFDj4oIud6qU+S+UVjgWBim3HNbAj6AIxLDe13Whj9WpxqOaYeCporeMUglAYaPo7E9uaPbf8J/eyNkDvHKMJ63HgAKveQJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398412; c=relaxed/simple;
	bh=glrL9frKUynd0eooWslKXIli7Wwl1Of8mWNqeP69AkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Evlil6acqm/TaI7rrN5tFUvQa79NyMzv1M3RMCHVnanl4iD4rjwRToLSlF67oYmq173CufA0uO7hGc2Sd2zPnNhjlB6XU833Ed8y2MMBcJ9SBH9DWFvz4ILSmqhYV9OZgISlJ13J1rG+Q5G+/V97rTdFMzaKA5hG4kQi2upCssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Je3+X2RF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224171d6826so87447005ad.3
        for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745398409; x=1746003209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Cqj4QIom4PNiBzVEbYX0WUBXZ7DUraiDzK4MrzGYzY=;
        b=Je3+X2RFbmoetOeWaMTvz91B0bPTc1ji5n+8tY4MLRPm4zjuyj3+SUpMGZMszWvGrm
         BhaW6Npt3zDL0FoQkUqh3edl5tQ1CMuLx6YE9MrTyjFIfLC0teAd57ozhSPvKQKdjzlb
         lePqj8nbtySvaok/kAaE/jwKjmjP1+X975uR5So71dwRi/w8OGof6zrkcwG+9n8RFnWz
         4gtMSRCXG1Hg5LvU6AWo1EF6x43YxFhggtPHGnz9NCdHY3ag9kDI0av5S17vBfcVSitf
         j2vigeY14qTkdw9eydn2u/74VdQRdj6UAogRg2N6TTtkKb71nnbSi4Kj07VCi1OlkY7L
         AzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745398409; x=1746003209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Cqj4QIom4PNiBzVEbYX0WUBXZ7DUraiDzK4MrzGYzY=;
        b=NdSNUnmXx1+db8IXKxdlRTnKLvp4II6kwHsoIHu0iN6w/KDDyTcOPIOF7Xw2wXZ+Rr
         1YRE9jGWGzrTKUOXuEF1SFqGXPV/V1EdVWTibUHy3USViQLC4oy0PdWfd+TRmAVugFbu
         ElNgUDurWJnKv/C5hd1efzopWmaASMnnF/evk7t565fiKZ1TVXTalZ98hz7Z+F9KEIbm
         D2HGjUWxPbGkkzZogBkZhR+y4AGa5YnY9GE13a6kTR/bUYL7Cbw8QtNC5YLoACy0uIVN
         RG2xCxxJedfsizC46ubP+KJ9M+a6ZQJMq5rXykuaS+c1OSQj0N4ld1BdqdYWXsO1Oem5
         nitQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUh0jKliHX2qOP5XneftGVwWDwd9rA/Jj2xCo4aoAFUKBmicaUteuuuhTW0F2yHCnNpfzILAyNdG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW2tbDLqCLKqPzfzQ4/ZNZQQD/jsec/ij3zWMCCdi1ajBO87tK
	QPCD93f5l9OArzpGi4QQDo20mUktdYk8Cf21XNWlLNG0tyUjA6wWaPct8jwcwTc=
X-Gm-Gg: ASbGnctqIuVXHUBTZofDaNr9h5mPs54kvXNIQMS8/vNS8DBSAOAu9Pb3fmV8/Mz6OdP
	aIIgpjFuUilRjrrHxYfRqfaukkTBgX5cuJYfsPhDLIbL4k4lW3glocVvNvk7iEbCLBf8Khu+VIh
	40bAHjRGe8TDm5U7F+t+52N4PQvCn/BGaOg6aYOZVwTcfheb4cMiO21j7UgzgiYFflcuBE2ikDv
	c9EUJW9KMHL4gEM+zEldc0caKUqwW8wxmIdGjLW7hEJE/4wnZYpCDgAe+dg+2StJWue0S8PzMFp
	LIlNi/1xB1GfHR+FD/Yjrwqek0nCDgeNNT0I/IceF738tQcqdZ23p/vU/tzHXNf0kExpLXUAxVX
	raDHHwiIezxvp
X-Google-Smtp-Source: AGHT+IEAalrda38aOkj4B5+H1noGQ2OTP7JrL0DoyWnhW03mGn+cIvqfLp/tgOSUaOiNbvMPyvUE2Q==
X-Received: by 2002:a17:90b:380f:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-3087bb5336cmr28685643a91.10.1745398408957;
        Wed, 23 Apr 2025 01:53:28 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309dfa5f880sm1047611a91.38.2025.04.23.01.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:53:28 -0700 (PDT)
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
Subject: [PATCH v13 3/5] pwm: sifive: Fix the error in the idempotent test within the pwm_apply_state_debug function
Date: Wed, 23 Apr 2025 17:04:44 +0800
Message-Id: <20250423090446.294846-4-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423090446.294846-1-nylon.chen@sifive.com>
References: <20250423090446.294846-1-nylon.chen@sifive.com>
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


