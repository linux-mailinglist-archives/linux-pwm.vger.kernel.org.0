Return-Path: <linux-pwm+bounces-6814-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BAB0082A
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 18:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1114F16750C
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Jul 2025 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7D198E9B;
	Thu, 10 Jul 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dhsQ6K+s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686E271441
	for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163475; cv=none; b=QgWJ4GLBi4LhwiL1Oq0VfiymyFcmGMCntyvfFnCMBbrVJW5/SzgjyeMtUuKSduFxmYMpBfkyNRMzdE6GdnkI4BmY1NF8jO5UrtzfI89Qd9XGWuTAGbccJlG67KaoNlp3YWAsPKHnWOBe/C15dTZrFzFfDfhJCRT5z49yAaGX6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163475; c=relaxed/simple;
	bh=h6itR3ghj2JqUTT+9BV9AGn9AmwkvZzKvcQUXaYn548=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fj7kBdtvnVmK5zSp3LmswPH2rnyEX6MDHhZi5DLqUzZ0XMn5CPocYoOXZi+z/FKEx4uVJd7Y3+LE3r1b4lXkf8s+qR2z7rtLI/Sv4NVQWb2SsV7exbH7bdVVgxrhs4SWN/iYAUk3aBD6nHD7+95F7rEHDrnO6fV00W9TFGpJR7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dhsQ6K+s; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so2391218a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 10 Jul 2025 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752163471; x=1752768271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d1TwLB8dIO1lOi7BSFaI3hsDRPn3KXX/zTDFy63gJTs=;
        b=dhsQ6K+s8+5fUeLl3U1lCor76UoBjql1vlTwSAGY3P/ijq2CVL4JVvBkNK8z0VOdbd
         iCpwuP8Q56Lwva8fElKiwPY9Ms8gZuCIHOAMDFGG7QXj0D6VHI7F+M2MQshPP0YQB6Q8
         WZKEV9++UuRwcQThO6pRxLY99baFKJlxOO6aQLYp+1UasoP8D7+WCFPYbl1BzynTWO9F
         TpmJVTzbesFPbIZK5mafHfzE2PUKSQp5jK8tFWW0FFY6yvbGZE2mfvgdUFpZWpEA/cRQ
         hkOWJLSOgYNjKz+tfDoyuUQfqF9C7MsmmxIl8J9oEAhBlU8Aw1ZC7Z0P5oBvNkyYDWHJ
         5SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163471; x=1752768271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1TwLB8dIO1lOi7BSFaI3hsDRPn3KXX/zTDFy63gJTs=;
        b=VbK+xPwC6s+39GgqgvCkmLIxRtrUqd1iHKAYVK/VlDy9Je/rRhjmfopjDr8rWXA0gM
         4A+mgAiji/ilkhv+MzlzQdGslYW9FRfQwVMWO2lRkMA+snGmaT474VUo9oxZ+ifEmh0H
         mdypaOhxZR9as+W95J9/Qurpvsx8ZDfli36/xVPsbowjYrv2XZzAWk+vSGMaUOAgwyBj
         QxcIO2yBdHC0vsFfJFULDEAziOROARS9UL0DZqi2hhRJyCYDmy8W9lZ8kqNZZOTT/ow2
         79/i2nnVsvUsdl2n780y3betfAHOw2nhfAee85yjHT+A98p1LpaDKsfEApafd5BtRV8r
         rUCg==
X-Gm-Message-State: AOJu0YzJuuEeLPDRLRrNxLU3/3wGTWUYK76BAAndMnsJUukVKvoZUsib
	+7h/m1hR0PMZ/YmrjlH2mztnXJcNeu/3qsm90eDc1fa7dgIlmLBhxUxC4ubjU+0v+SQpTaJyVEp
	oZP83
X-Gm-Gg: ASbGncu8EPHstgwWhwD0BxqNk0LVgZB86Uvk4J/flEzxSzTxeCS9/Hr6ZXWtW6Hu6Vf
	IuMDhLSnI3Xo83v7QSy8rzbZ+JnZ7H9BT7KlMT3bqzF7cd/jqTSaZy0KmsJdQGoVmA4KL/J8n7W
	nMRHnu9A9VQPq/d0v97AH+RTpRe37UZZgqc8dKQaXjtE/vEs9MZIZT2kozNSMMtiFuE3x/4IbaY
	TPvvwLGfZ5G3yT0nLgUZuvf9sLnPjCmfKADdIX2q4hY2VoVItiiKEa+9WnxPAn20n/092BI1J74
	9dHI8acUTkHs8MjwL5SamuXGjZZBQ2TpiqdC5hKEtkdZ+o2ejTwcPj2kHK1TgNBWQ97+gwwulxB
	pbl427IV2yPg599W/N/R3clZMAXTU
X-Google-Smtp-Source: AGHT+IGu5hFyng7HuYZKDIZ0ko3w+3oHE7HgVpxx2Y1xH+Ql/PBj7SaY6BYLKd6+3UcP4IRbB8COlA==
X-Received: by 2002:a05:6402:35d3:b0:60c:679e:b957 with SMTP id 4fb4d7f45d1cf-611c1cb733fmr4141489a12.1.1752163470879;
        Thu, 10 Jul 2025 09:04:30 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-611c9796432sm1033411a12.73.2025.07.10.09.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:04:30 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH libpwm] pwmround/pwmset: Fix check for invalid duty_offset
Date: Thu, 10 Jul 2025 18:04:18 +0200
Message-ID: <20250710160417.2089742-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=h6itR3ghj2JqUTT+9BV9AGn9AmwkvZzKvcQUXaYn548=; b=owGbwMvMwMXY3/A7olbonx/jabUkhoz8J43VfgJrWX4FGb0S4ezZF5/d6PTldcZavTqT/RMfV lzunWXayWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEupM5GJbohSTHsaseCst6 ciHpYcuGSkeHu7FNDMLB+ZPumv+blCP8JMbZ6a2wmfmJjmrOS7xfJ04LuSrxqPbr5pQL9TmNGVv eim9NP3wzJss8ptfJtrPfk4vN3VjmLLuQc8LeBRe/P7G/VaDxulmFsahv4RSWfEvWJc8f8y5gkG /Zu0Z3wiq/9MJIEfHlpR8lO29Z3Fnq+7lvi3/MVq6dAv3rWVctK+X5UfjcuFDbf8E0cdVp7boTD dOYeL5o698pZLh7cXJ50cv7H1fMel6uVdKmKOxmNE3M7j1/jP2dbVlfJvuHOqsF3Ij/9XGjZmDY ysDcFXWhMvekLJ59V3r+4nTSjL1TrNzn787JV16jvm0aAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

.period_length_ns == .duty_offset_ns == 0 is a valid waveform that
shouldn't trigger a warning.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 pwmround.c | 2 +-
 pwmset.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pwmround.c b/pwmround.c
index 860446668d3a..da3c018c4494 100644
--- a/pwmround.c
+++ b/pwmround.c
@@ -61,7 +61,7 @@ int main(int argc, char *const argv[])
 		fprintf(stderr, "Warning: invalid waveform: duty_length = %llu > period_length = %llu\n",
 			(unsigned long long)wf.duty_length_ns, (unsigned long long)wf.period_length_ns);
 
-	if (wf.duty_offset_ns >= wf.period_length_ns)
+	if (wf.period_length_ns && wf.duty_offset_ns >= wf.period_length_ns)
 		fprintf(stderr, "Warning: invalid waveform: duty_offset = %llu >= period_length = %llu\n",
 			(unsigned long long)wf.duty_offset_ns, (unsigned long long)wf.period_length_ns);
 
diff --git a/pwmset.c b/pwmset.c
index 0fdc1a34cc2f..4c3d50109f6a 100644
--- a/pwmset.c
+++ b/pwmset.c
@@ -69,7 +69,7 @@ int main(int argc, char *const argv[])
 		fprintf(stderr, "Warning: invalid waveform: duty_length = %llu > period_length = %llu\n",
 			(unsigned long long)wf.duty_length_ns, (unsigned long long)wf.period_length_ns);
 
-	if (wf.duty_offset_ns >= wf.period_length_ns)
+	if (wf.period_length_ns && wf.duty_offset_ns >= wf.period_length_ns)
 		fprintf(stderr, "Warning: invalid waveform: duty_offset = %llu >= period_length = %llu\n",
 			(unsigned long long)wf.duty_offset_ns, (unsigned long long)wf.period_length_ns);
 

base-commit: 3a9a9d36d95e8aa5ed563590d53c1715285a5ffb
-- 
2.49.0


