Return-Path: <linux-pwm+bounces-5471-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3782CA86CDB
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 14:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DDD1737CF
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 12:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BB31922E7;
	Sat, 12 Apr 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JVai7hR+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CB813A418
	for <linux-pwm@vger.kernel.org>; Sat, 12 Apr 2025 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744460500; cv=none; b=XQVFegrEErO9iewprZUt+06e/JzhRXproQTQzZD4Yw9G7BMSrdCKZ976ij1tbxMlCmtE/+SW3aFERvzHA0GrOc+tsGwI4UcQ16lk0yCtw6k49XcBIrcP8J6CnvsUhhV9H5SyGu3Cp3yGYd0AEv1GXFhtedYW3FNn/T1goxeoU9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744460500; c=relaxed/simple;
	bh=d0ropSt938ckaA0ucc1sKh7jf0SgdGjqg7QdnbhZP8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WHHga0FLMkPlm/sDZWibmAGKJijGEGiLd+IvBfZmfrALHjOAKPIjcBBQjUtEmPYc0f4M1w1tL9t8vBdAmCSR/GFxuxuahdamTLKNqOTqiN+evME38QSzyiZ9Brg45byNkSv5rgx3tn1cl8AVmyBcBwg8vze2E7tvKl7VciYrWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JVai7hR+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5f0c8448f99so5840790a12.1
        for <linux-pwm@vger.kernel.org>; Sat, 12 Apr 2025 05:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744460495; x=1745065295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPA89UhcB5PMVk0LgGmF87NPMC7DQWOFVmg24ACIxP8=;
        b=JVai7hR+pb7J98MBsBiGcJ0KqaSuw8jrPtpiAffkRj3d1J1hjpUu+KWsMqpq/tPQvL
         nmLERBvB9iKuVDz+E+GuIGLrDCd14YBAf/djUvHc2m1Sjyjj0WKtxVUtzP4h3YGf9qkq
         cmNigX86eMY+SXr6iuajq+NVBxX9Ms4Xac7hD05o1QjoshBxS1hc9QEh3KFXegT4G/lA
         +ZyQM+OlSac5zaWSzfy4b8zuoM8cWY72SoK1pB6szXePD0Z+fFDAhEkd3hksT5rZ3MHg
         TH36ucH4YSe8O8ssoM0ZAp08bYlPUQLaV9gjyTKNaEfzlMD5Pvk2IaWOU2COrs9j2CFc
         zbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744460495; x=1745065295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPA89UhcB5PMVk0LgGmF87NPMC7DQWOFVmg24ACIxP8=;
        b=fLnKQ61PHJSBMfBoWFnLGczjw0zFWEEFU7MKd5QLQRZ3gsY09XE0d8vF7jSu/vF/i1
         9tgrBu9LLF8OSZwVzrcZNQ9Gog0TvMsGL/odNSKJ1HlbhZ+UYONaa/qS0K+LZT6Xk+ir
         +FC/ToKfIdXBxZGOofe5PWpK++/5Hd3beNSVmV+8ty8NL+dmAM1KnUzMjqGvtxGb72B4
         8NZDot1xHIa7awC9emXcfH9CbuG/Q2ZlyXEOmSCmJy0HFcBlCbXYd6I5VjpzZUHCC7RF
         SLmCtMolSe8E7kpoc2w8u/IcYzd1cg5cmCNLFfacpRWQKnKYA+Yd/v5JmMviqc0G22gT
         MZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCVKwaQ7mrAqXhQUmfKsXwwGPt6+4HFPJKUXOgGPavuOppJ/vMDAC6m8SvXpx0cvk3z0h2eJRctabZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjMkUPJknQ81bXL2glMKXugroqTRwm6PKj3r7VPU48BC1it2GZ
	I9mnW54MyorekjXRwFDXYj15kg6+FKefJ9c/E/ouflqWrrReWogTriZUVPS7Hzg=
X-Gm-Gg: ASbGncs4yzIO1/PW83J1nasmu1pV71SnTw6rJdIc+n+DFESwVC2HdyKol5cXL0QVijK
	RZ0cmYe7pLAcwbOwmTA001QmhBI8c3CQRhtoufk8FNNFBD8ZEP9wQUC/ZqJ8RpEvfvw57fI3/q7
	yIBurCeivMeTWxmgpEN3/XMajt0+t3T3Poid7TQZvdwCiyBucXk73QfRyjhw9kDExjQCjVMzMnG
	/4rGZhX7YWizx5b6DrEJpmQZZxoNwa1XwiZjR7Rja2Sc1cnlXFu8clHgUfL/1Sm8x8guto3DzDW
	t463Z6XZklmLbH7MTzGHu1z8ZExcCB4RXfqQvoEthqRHuw==
X-Google-Smtp-Source: AGHT+IH/LRQBAm+Wibjn8nEFre80WnaMy7pfuJJcc9ih63wXx/SpiQr/pFGcsPn3d1Gj6INaxYV32Q==
X-Received: by 2002:a17:907:3d4f:b0:ac3:97f4:9c08 with SMTP id a640c23a62f3a-acad3520153mr570432466b.31.1744460494927;
        Sat, 12 Apr 2025 05:21:34 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-acaa1ccad01sm589583066b.125.2025.04.12.05.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 05:21:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Juxin Gao <gaojuxin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: loongson: Fix u32 overflow in waveform calculation
Date: Sat, 12 Apr 2025 14:21:24 +0200
Message-ID: <20250412122124.1636152-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=d0ropSt938ckaA0ucc1sKh7jf0SgdGjqg7QdnbhZP8w=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvRfUUc2d/9QvF+eZBLCW1Z3gGXecW6+N/+L7Y13zvZ+0 5DXfsyik9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJeAew/3faWXvG9OjW0E0+ edt7PLjXcp5lv6Mi+rs5ymDbKivdbyrpHKa6ltc2BG5r+a2w4df1G6//Hl+0N0fDsuefeeiZ+Jf vy5ty1QSKor0uPp3jf0xm83QTF95iy77ogK+2KuzcqW3VBwp6fQ1mnXcx7Nh/bkn3+7VFn1ZqtV wNZPhkZt+SqCE/v/jIZmV+68S9jFvePvyUuyct/5G4vNKLqSLVEUtVEs/8/v+Bi6H5re4dxpVvn mfK5/vvcV5nEhjbYB6/6NnRTXI5meHbWG6f7phaFLtkH6PPp7mvH3I3GmgtW20klMsZlsFXeZO9 uYr178pF961zLZdtW8K3Uulck7CN+t/QmY2OQraPE+ryAQ==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

mul_u64_u64_div_u64() returns an u64 that might be bigger than U32_MAX.
To properly handle this case it must not be directly assigned to an u32
value.

Use a wider type for duty and period to make the idiom:

	duty = mul_u64_u64_div_u64(...)
	if (duty > U32_MAX)
		duty = U32_MAX;

actually work as intended.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/44f3c764-8b65-49a9-b3ad-797e9fbb96f5@stanley.mountain
Fixes: 322fc380cea1 ("pwm: Add Loongson PWM controller support")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is the approach that Dan suggested in reply to my suggested fix. This has
the advantage to not involve a very long line. I didn't check but I'd expect that the compiler produces comparable results for both approaches and so they are more or less equivalent after compilation.

Best regards
Uwe

 drivers/pwm/pwm-loongson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
index 412c67739ef9..6392c4e34136 100644
--- a/drivers/pwm/pwm-loongson.c
+++ b/drivers/pwm/pwm-loongson.c
@@ -118,7 +118,7 @@ static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       u64 duty_ns, u64 period_ns)
 {
-	u32 duty, period;
+	u64 duty, period;
 	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
 
 	/* duty = duty_ns * ddata->clk_rate / NSEC_PER_SEC */

base-commit: 957062f2ba4790c495de606ecf8bc7398c0c710f
-- 
2.47.2


