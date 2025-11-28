Return-Path: <linux-pwm+bounces-7711-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6DBC9070E
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 01:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970313AA0E8
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 00:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D391121D011;
	Fri, 28 Nov 2025 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaCk3aFV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4701F7569
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764290336; cv=none; b=FnmpZdI0TIrhRY/4KfXr0Gz3yIJ4KLiG+B17T3+m5kWMGZO0wE+FwoijAaIO+WRhQWm77bpTBbMFE6Xp7gHeWlRRAWvvJ79IlWDYJctT3fJJ11FKOkd4IRu1UF//WRq7hvl/YkMKDWsV54vRY/NK1IcjFCRh62TSfj0ueae/CBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764290336; c=relaxed/simple;
	bh=C9HWSAYR2q5uIph3FkUJ6BXnEDzjVAiaIx01sV5GSo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt6BuYQLpv4ekuiTb6z5gKVTnDVnPZ0D5X1Re5VxD1dPvyxir/xQ0KHO8D8s3ErzvqII9d8JJS4Qkpji60jZ2HfYoVxtONXjmHLnN6BBGO1cLNDDZjDFrMClDH4tAHVGLcLHz645LVl9yt0e6RPYj475nHZBskB9Taa7jazCIxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaCk3aFV; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3434700be69so1811778a91.1
        for <linux-pwm@vger.kernel.org>; Thu, 27 Nov 2025 16:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764290334; x=1764895134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgsTYW6mw6gvo8cZFovvR+8R0CxGh+JuEoeXNZCt3LY=;
        b=iaCk3aFVAdlrS6f8tD9p/swnsRfCRAcQRKV2i3nwYYwRCD+k4cPXdVZpH+nCXMCZ+l
         tMGjCPxUu6gdEY+XKE3pBqzuzZJ0R9RwXvVop8uBVR8lOZ5IOF+GoEU3Q8Qs8kKeMy0x
         7BHHO8/H0Rw0CLKAP3OiYThJwJiIhciYB2jDYpDn7D2QaxoOTs28pf4smIdZorWWkcgy
         /lGh0nkVsbTgzRuqsD4jpiM3WlycHE+UvML3e2wPLnEfgr9f55Tr+6uLb7zl8AMyF+vU
         8tqK/QwD0A7ykPOtnEWtAoaTPpy2RPHgMBQFvGohKGG6Gi1Kv5xuHNbYJAqFGgbTUNPR
         7wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764290334; x=1764895134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rgsTYW6mw6gvo8cZFovvR+8R0CxGh+JuEoeXNZCt3LY=;
        b=kpB9MMByE9ca2GEfah28SLpGSZpCF2vQnyOFUXSn/B+utZHMqkb8lH6KdjbS4Umucc
         Y4+7PD6BccMGFAGFRXEZ7+3jQ57KoGi1q+dwQyy4mh6Yk64tbsF48UubYIO5tLICHIFh
         xSMGLjiH/6QzMwbqfxXUN9F/dlLKuFiPVqZULQ/I/tGo5RJM/fQWH58VERE5+mim/g/o
         IpTD5M5G/R/G12vbKYtZpD2YQWM2XhH44wa7llFM/4TIWBltKmjOgJpCRMh/xQzbh8Lq
         Ia2uX4jff1ZLqxloT9p6EuZjpgKAlftRQQ+GKmtl+no4s9cVxxSzdWZLZx0TErEmrWfY
         TbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXGgytS77udcRSubd6TVb+LLqi+WYAjrtzoSW8b1kLLSgxwReqBj7ROw8efOscFi5OVZ14x6MLr3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YymHlP/ZzD3zyqLgP2YbM6ZCB9M00k6vZ0oAy1hw8pkFTY3KPlQ
	CcV4tZIh7LvWNMiri+Ems+uxTZWHkpgbp/RaM0mdpAw1BmtY2Xevgbkv
X-Gm-Gg: ASbGncvAZ2CmaiizirrFYcEfQEYxffUHfMaEPpmg1obTRYxaX/FAn5rX247tJ+fe96S
	CuIvOGGx5SUhYPIgS7elUoZ1tDrn4TN8k3oWsON8KmKP4WAIxV76IBafLsEthcBknxEAwRsAYM/
	atbB0+t7PYetD0NVyA8Rt+jE7vWCCogBAMRA9JUm962AIxfom/N++ua3tBB9wo1yKcXq3gW4gzS
	Dhvo+GPEvUZksG/zdaQHU7Oo9RqM0jlI1lnk+mnKJTFj992SaG3DbESPYpoBxemJvD9Ob9mCAbJ
	/k81bHD6bG5nmsysTRq/D0Kr32qZqlKdMICSsLFVhyrQFbU1iOjbiogkH3n+T9E5Frwgz+l0myL
	8ydehe6dlw/RijQzXD79dseKoo4IWGl6Iuuvs8KhRJeFFMKtE0ZEOjEXbDtbmyH6Lh1JMAVhBqc
	OxBeZiPHYTbn1LprV6mhlEJNfMYNw3+IlFNkHUrxlZbDU=
X-Google-Smtp-Source: AGHT+IH2td1t/oW0i1EB7gUksIIhTxGZlvPY9I6xxcILQJWAMleUCN55gA5CEaxqO/av+YMGSKO5Cw==
X-Received: by 2002:a05:7022:922:b0:11d:c86c:652e with SMTP id a92af1059eb24-11dc86c662bmr3515299c88.5.1764290334396;
        Thu, 27 Nov 2025 16:38:54 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm12404561c88.4.2025.11.27.16.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:38:54 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v7 2/9] pwm: tiehrpwm: drop _MASK suffix from TBCTL PRDLD field
Date: Thu, 27 Nov 2025 21:36:27 -0300
Message-ID: <20251128003634.247529-3-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
References: <20251128003634.247529-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename TIEHRPWM_TBCTL_PRDLD_MASK to TIEHRPWM_TBCTL_PRDLD so the macro
name describes the PRDLD field itself instead of carrying a _MASK suffix.

Update the single user in ehrpwm_pwm_config() accordingly. The value of
the bit definition is unchanged.

No functional change.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index b6020b2210db..f8625394c056 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -20,7 +20,7 @@
 #define TIEHRPWM_TBCTL				0x00
 #define TIEHRPWM_TBPRD				0x0A
 
-#define TIEHRPWM_TBCTL_PRDLD_MASK		BIT(3)
+#define TIEHRPWM_TBCTL_PRDLD			BIT(3)
 #define TIEHRPWM_TBCTL_PRDLD_SHDW		0
 #define TIEHRPWM_TBCTL_PRDLD_IMDT		BIT(3)
 #define TIEHRPWM_TBCTL_CLKDIV_MASK		(BIT(12) | BIT(11) | BIT(10) | BIT(9) | \
@@ -283,7 +283,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	ehrpwm_modify(pc->mmio_base, aqctl_reg, aqctl_mask, aqctl_val);
 
 	/* Configure shadow loading on Period register */
-	ehrpwm_modify(pc->mmio_base, TIEHRPWM_TBCTL, TIEHRPWM_TBCTL_PRDLD_MASK,
+	ehrpwm_modify(pc->mmio_base, TIEHRPWM_TBCTL, TIEHRPWM_TBCTL_PRDLD,
 		      TIEHRPWM_TBCTL_PRDLD_SHDW);
 
 	ehrpwm_write(pc->mmio_base, TIEHRPWM_TBPRD, period_cycles - 1);
-- 
2.43.0


