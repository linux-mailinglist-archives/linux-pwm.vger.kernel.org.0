Return-Path: <linux-pwm+bounces-7238-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BDFB40212
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 15:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D87179739
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29202C21C9;
	Tue,  2 Sep 2025 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMqcxx6H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261A3595B;
	Tue,  2 Sep 2025 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818279; cv=none; b=JXVnPor6jF+bthlAoGViAz3TXJrmzjI4O2zdTvD4+H3nJsB6Mw19C+8kM7etImSb2bnhL755kecX4cdPjqnHgLVIokUUIj9pC/KZ1ErZfuZmqTd9BXE5DUgnEGRlmKIrAzzEntoPjggnTYsg6pAa7fNVZnfgQUeks+AfE98ta/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818279; c=relaxed/simple;
	bh=2MWuwC6idLiUHz4NEXYcdUZ9FGsws13CWVKUQhGJERA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G3s0QeWcS9gR8NGr3o42iOhv4edfNvGxJ2ZDITiapmaLSUAjfLOgUwZwWelSAm5PMqJgXFXQZSGTe9TrdUTgOg+A2ux3MKSRlK6tFYNZRW0MX+II0AgehYxK9a9M/B7IzQzU/+HZCbB+rNSrt99L8qIolj1awpB/imF9nL+Bwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMqcxx6H; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b82a21e6bso25231785e9.2;
        Tue, 02 Sep 2025 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756818276; x=1757423076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/hSmzdKwsxwF9sV5EJodr8gQuiA7uc6g9hecYUVK98=;
        b=QMqcxx6HLJ1hmFce1TAbVwsAYIc7xRjJix+wFBfULsmK5eogtxPNLArl6KIbYkEIdq
         9NZlYp6H4skY35MUN6nB5tiEEX7YiZRxvxtyEvbqSvHBORVyigMQt/UlFDsjdOBf0Y4x
         vOHMsVBDX7/fzCQjk0qS1xFdFJfrDjEQfA/q/w9zKiubpsOchU61bRZdRvzhqQRLWPuZ
         /Kd5f0Shtrgarkxata/xVcCaTe1SDuZz2tMgAWvDgLArwLx86+v+Fp6OYcA+a7Ai9Axt
         jwoaG2WV82G1fsd6E0poDY9cFTPZKmYzHxHNYHuvnjEC3hkG0WoX4ZryMEUmaCSO94Kd
         f6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818276; x=1757423076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/hSmzdKwsxwF9sV5EJodr8gQuiA7uc6g9hecYUVK98=;
        b=aHaDijAXIvqCPMO2DM0nJGXaU9+6E1KM4vI9rHOHK+bnvGJfwIRtJDJORYHz+4siX6
         n1hPgk24uDGzGPMnXkr9v67/zSMwLSsryGpxhR3DN797PF51Q5jNpEVIgarjb2gJ9Oeq
         t9bGc8QEBLvxrdXGKRAGjKwAVEnkpI0sUlkSTQPHnZAX8npmDdeOtayjt1FLtBVTFM0d
         3ZMet44QM4SqPrKNuFdTRvsxrwmsgy0xO9Uv7vVGPT2HQaX93fZBi2C4T8f7b+SEF71N
         R1lm8+XfRAzwXTH6cgI4sN3LzIKffg6e5OCW0wXbSEjHM8tjp2nUqJnmg4kdIXtrzQnA
         PMIw==
X-Forwarded-Encrypted: i=1; AJvYcCWZU8BF/dEv6GTWCZKT15BEI+7n/3XATyHISb3biCqOCLWlC3F9NCslHeDE3V0y8Ku24yXM7twR0zlm@vger.kernel.org, AJvYcCXjzY3X9xB9irBk1y15N2kp6YYEePTXKezN8bWJSg0twoBP6Fddx/25Cg4vDPQ7Xwr7sWcEvl+PhDTdMaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUKnHP7y9vJ9aIF3jnJrMBqJ492ioehFfTIogOBbBWhJX3Evp
	qmPmn7sG4r9gntgy8P73G9sLoHfAlNzR2rfUdDZ8jOa44zHndsfpwUSx
X-Gm-Gg: ASbGncvcaAjI5VxIThgXX3+8EFLa54RiYeI9Yfx2FLWVFO/vU4dbY25HqYs9C42sRh+
	VrTlZIrl7d9mRKJV5kJ7iNzgAy+XNGx3aTEzj0L5BlNmZ/pUWhapPaRUM1QhqqbmEFxJcVsKoV0
	wN6BfY1ARKIQ+8IUk7oWqX6S4pPXgh+7ssgKVSMlMnLH7tQl0AaW5G+E9WtN4O1evTSsDT6g+aK
	DqywH4UOuvi3cpgy2CffE9dhYmnURenm6j8+whPl5W5GGcYBpgQFyRO121ND3upti7iSFw1u6CA
	Glbc0CksFAXH+HSKEZALynlo1/xrdJQGyfMu3dxIjBU4e36G9yeLqn7Fk6g5weo5SvCYTxyFDQ3
	j7pRRUpBO6ch84WQRI84DDxFF6iGN5CE=
X-Google-Smtp-Source: AGHT+IG566maRKZLCvJ92e4BN99INnc1oShYNndu0Q6aU21m4trlhpFpyGI9KwOOLQJz/bi1O04Gjw==
X-Received: by 2002:a05:600c:c0d2:20b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-45b85cc80famr55260455e9.12.1756818275950;
        Tue, 02 Sep 2025 06:04:35 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b85090262sm147888285e9.17.2025.09.02.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:04:34 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] pwm: Fix incorrect variable used in error message
Date: Tue,  2 Sep 2025 14:03:48 +0100
Message-ID: <20250902130348.2630053-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The dev_err message is reporting the incorrect return value ret_tohw,
it should be reporting the value in ret_fromhw. Fix this by using
ret_fromhw instead of ret_tohw.

Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for waveforms")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ec4112e6209a..ea2ccf42e814 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -276,7 +276,7 @@ int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *
 
 	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ret_fromhw > 0)
 		dev_err(&chip->dev, "Unexpected return value from __pwm_round_waveform_fromhw: requested %llu/%llu [+%llu], return value %d\n",
-			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns, ret_tohw);
+			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns, ret_fromhw);
 
 	if (IS_ENABLED(CONFIG_PWM_DEBUG) &&
 	    (ret_tohw == 0) != pwm_check_rounding(&wf_req, wf))
-- 
2.51.0


