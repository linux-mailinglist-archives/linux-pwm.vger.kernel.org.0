Return-Path: <linux-pwm+bounces-796-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCF182E870
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jan 2024 05:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666381F237BF
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jan 2024 04:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3465410A1E;
	Tue, 16 Jan 2024 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gS8mDw+N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB710A25
	for <linux-pwm@vger.kernel.org>; Tue, 16 Jan 2024 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ddf05b1922so3958058a34.2
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jan 2024 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705378283; x=1705983083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYo9wXWOZdh4xBQbuTEOxrcqZQMwofEU/9c/S0MDuwU=;
        b=gS8mDw+N0vl5VxlTMOykZ6FXiQKiZHSNmUcHzeZnM3hFM5Iv0J9/gfdAg6g+Ltlk9n
         tuMFXI39vsauahLQDcmXYsnzUM0kPp3MoVGMyjO99Yru0eCjkV14Cn3qGWNkwwJVCBbf
         Vi0ZwU2iH8n1/IhTp/ugdF0WcyoVrWdTf1R3Vk3vvbr1pYVl7FJ7O8Q2KGldkcpOmH9t
         6pptrDMM4Z6DUpRTwi9zqWcD3ob0IqktCwNfMSOex1Qwi2KuT9W9U7kIiGAJh9SL5hyG
         ejulNh3cNfm0qNNnCeyeRWhwL/iDMo5J+wtqicp0EfX3v0C+HTj5/TqjQORv1+8cOwGP
         9LhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705378283; x=1705983083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYo9wXWOZdh4xBQbuTEOxrcqZQMwofEU/9c/S0MDuwU=;
        b=e64D20Jprk0x5gCxdUf6V736fl5EU81dRdGxzLyNCvVp6ZoDrqCPQgDoZYzSyL5Jua
         /iF+PKgd7riNmrbi6/M6skhcK73DeUzHO0KoLMgu7PuHRybc2YMDPGbdYckerISoCEIc
         Kc5ru3FnKvpuRwLZutG9odL5fSUHOmwwhXb5i1CMV/yDAETS8Cg+h07foQ8n8JnkuGPm
         y1oogU6a8W8Jin/lFGd99UZxIvi3V6KWBKsIdatFIorhkLFDTnmZbyipB2Z+OAXH4DF9
         FZuz/8injm4c0WYpLvC3KSzLsMNcR1PDozMaEBETFkE/2pPO15Lpa8ki2hlO1hTkeOZK
         EBbQ==
X-Gm-Message-State: AOJu0YwJNzZvX/Lhf0LbGgOduEqxGUUHVZieLadPXFPEzBL8heBKJ/2o
	FdXCxkpsQu9aY44Rm0pk85dnQrXhwtmOnQ==
X-Google-Smtp-Source: AGHT+IHY8wqSPbSfWTDr8kZnGoqer2JRIbsG2vuaQFhUvm3Jtx2vE59XTqMvUSiKzXWuROP6xyBF3Q==
X-Received: by 2002:a05:6358:924:b0:175:d42f:6c63 with SMTP id r36-20020a056358092400b00175d42f6c63mr4731065rwi.36.1705378282820;
        Mon, 15 Jan 2024 20:11:22 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id e3-20020a056a0000c300b006da14f68ac1sm8348585pfj.198.2024.01.15.20.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 20:11:22 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	u.kleine-koenig@pengutronix.de,
	thierry.reding@gmail.com,
	aou@eecs.berkeley.edu
Cc: zong.li@sifve.com,
	vincent.chen@sifive.com,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	nylon7717@gmail.com,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [v6 3/3] pwm: sifive: Fix the error in the idempotent test within the pwm_apply_state_debug function
Date: Tue, 16 Jan 2024 12:10:54 +0800
Message-ID: <20240116041054.11641-4-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240116041054.11641-1-nylon.chen@sifive.com>
References: <20240116041054.11641-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Round the result to the nearest whole number. This ensures that
real_period is always a reasonable integer that is not lower than the
actual value.

e.g.
$ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/brightness
$ .apply is not idempotent (ena=1 pol=0 1739692/4032985) -> (ena=1 pol=0 1739630/4032985)

Co-developed-by: Zong Li <zong.li@sifve.com>
Signed-off-by: Zong Li <zong.li@sifve.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index b07c8598bb21..7cf7a76cdb44 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
-	ddata->real_period = div64_ul(num, rate);
+	ddata->real_period = DIV_ROUND_UP_ULL(num, rate);
 	dev_dbg(ddata->chip.dev,
 		"New real_period = %u ns\n", ddata->real_period);
 }
-- 
2.42.0


