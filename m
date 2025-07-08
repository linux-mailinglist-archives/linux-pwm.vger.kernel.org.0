Return-Path: <linux-pwm+bounces-6779-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A7AFD524
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C1F16901E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DC2DAFAE;
	Tue,  8 Jul 2025 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NoXFCBM0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6752E5403
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995145; cv=none; b=aM6icCQzIZkXBrRu/z3FxdJT37U4D0aYpYqRXzQiIgvBmiJMoFZhLswLOaEDCf7CN6r5w0AnQJMMLqeBwjR8tk1jCiSY2cEXA9vAul/FVLCxbc7dTRRBaL0967U1lsTFXgnqRjQww/4IN//dvKuPb+ujJtbQu72yXse9LLCAwC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995145; c=relaxed/simple;
	bh=JOXG8LBbhkmPcwt0LlDsJ6pBd6Fa8cmBh4Mg0M2MoAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHWagjBjAuLW2cCLFvtUGSzoBZpvDzKjgezL5+JzOzKACVHFgY9PNgkVVbC1X+N1Hv1UdkfY72gVMY/ubemzApizKvQ4zxkGGYRczgKIBsfAMRvSnJ/gyxK9jlfacZkLIRNm3fCd0rSXGAiLDT0VlOaPdPKz4ONaqVnRfYq2vRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NoXFCBM0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so8667837a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995142; x=1752599942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLyqT+xILuclBbcabGc7fi9R39np5F7oBhDxlkOWYXQ=;
        b=NoXFCBM0DXelcPq40zeWpgLvG1M6MnyURPAbvKAYZCpWjkDR16cg4VaV6zHJWWnPwb
         XSWK7E0f0rDitwFFIFTCXU+9TTlAyVVf7nJkQ7s4nfk6gk2IgjMiJqp6LtBsoxAfu2OU
         RYL7MW4rI2/glNbm+gtMj07igPoNV8c5m1+ZbeIuoS3f/7QTEOp/m0Ykw5ey0RYv5yqq
         H7ZvPiC8VAnwSWbrqHSQEd7HLdLFCzAL+l7iPsoTVNaPhy1dl1rRMrQMt2rLQWlSzb+x
         6pzhSj5yFefV8x2Cvo7Q87lmt2bdw98Apo28E4OT+nTaSjik+4Nk8KrJ/OwyCsmPw3sJ
         feIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995142; x=1752599942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLyqT+xILuclBbcabGc7fi9R39np5F7oBhDxlkOWYXQ=;
        b=rN/Y+Tay5C7LeQQ8xah/9hGrSzSMnnniJHe2rHGaSKt9O1Fc+0pJMz9/G/zeMLRNUE
         PvPEG1gFvCGSKuIXI4BLSAJQlyM+89KGsa9DlCE9icC5YfPCJF64YainxPpbe92d2AW4
         qS14ZvQ8MoQKVzfcyO+Mo2KAOJJrftX/5d7XpJEX9idOWFG4rNQsUZoXppcQ1J0WyqZm
         BSJdFc8/tRuK+RuWNmv+mSz9bEEAJoSC/8rJ+RU3BMySxyOSu/2GEZlOqVBHvZCObjxU
         JW+6vPyzekefzHjhuo6LxyLLU9D78FE0wzE1dgcrBUs6ZAHwLYdI+rmmVJ+jIF0vO6qQ
         LEQQ==
X-Gm-Message-State: AOJu0Ywcme5U54a4zp0O/eHKTAvfgKA/G1h84RXj5cp8K1hS44zELDrl
	xbsxAIv9heN93IL62sz92i+HefCfiyGhYO+ArW9TsJ9OKfSw5Pj4mh9odmMUDSHQKL0=
X-Gm-Gg: ASbGnctzQEF5BvRbrXFxH/ft5rJqpC66KtxhVD7cbFvqKoyYUaj9NcddnM57IZ4b+fp
	yLK1RLWoVCuSP8cEX8u0OrztyFK4u3rWHx5DR1v0XsjUP1167lR3bcyLv/b7l7BsgRoTL4V1fqm
	YGJehIvBSISkHNs1yFniy6yab6ffbiPk9M3jNda1Ytje9BmXxRJlfEFqhkdsa0ZPisei25PZ8eH
	+y6CV85goVyJQieipS9qD29J04+G8/WERDhFuqqiT3DHrYY0FlsDICJHWVA+glwGiH9WfkFc+n2
	z6xlhQzOh4UYQjIfXuf3+07478tm6lwITiDWYELpTvwfLSnIymTW0l/myZnv5JTQkKgGAZTLSGH
	ql+azrdcDadClySnFiMoTIKph+O18
X-Google-Smtp-Source: AGHT+IGX/NwWOkwFLXujzCHW7XovaOBzMDe2z1U1HjJW1JNezxlOayLu/X2MMKSGGW5j6xiogVApeg==
X-Received: by 2002:a05:6402:32b:b0:5ff:f524:90e0 with SMTP id 4fb4d7f45d1cf-60fd6525ea2mr13940909a12.11.1751995141685;
        Tue, 08 Jul 2025 10:19:01 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60fca66410bsm7426227a12.1.2025.07.08.10.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:19:01 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/8] pwm: mediatek: Convert to waveform API
Date: Tue,  8 Jul 2025 19:18:30 +0200
Message-ID: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=JOXG8LBbhkmPcwt0LlDsJ6pBd6Fa8cmBh4Mg0M2MoAI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVLnNn1ldDvMQsM8b+Zo1DdJTZXm+JuvH52QQ UWuaJKoYtCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1S5wAKCRCPgPtYfRL+ TrivCACBxEQA0w7JemLEzIvOyLsYqx/bUAPrN7KlveEFbxvo+zaOiDaDtO2zmn5sz7Jhr+6+Txn fPMK8tRJnqqBzXT+oe0SNgIN1Yejp0UBPIviz4Sh8KsIe1MWep+j6SeJU/G30RE35/AySduHGzj wXSOvjV+VB9TzRLnatbmjXMRJ/JoWspLY0Bw1unzDZ1x62U7nbun25s06EKd0wcI2ssQ9EGejNW n9S5FBR1ZHsoUksjGLlZywzdYcce9orXFlrHwm4HIq3BJpAbqzg4je5bc2fyMMjr1UJBpytqe6E kAc6vb1dchMn0Zavtv2NuHZV5HnVpMXitAclkxA0vcA25qWt
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

after a few cleanups and preparing changes .get_state() is implemented
and .apply() is aligned to the usual PWM rounding policy. The last
patch then converts the driver to implement the new waveform callbacks.

While this last commit removes functions that were created and adapted
earlier in the series I still consider these earlier changes sensible.
They provide a good intermediate step for both testing and bisection.

I don't have access to hardware documentation (yet), so please double
check that the names I introduce are sensible. Also one issue that I see
is that after poweron the LED that is connected to pwm0 on my mt8365
board is enabled, but the hardware is in a state that is detected as
disabled. So I'm open for feedback, otherwise I will address these
points when Mediatek will have given me access to their manuals.

Best regards
Uwe

Uwe Kleine-König (8):
  pwm: mediatek: Simplify representation of channel offsets
  pwm: mediatek: Introduce and use a few more register defines
  pwm: mediatek: Rework parameters for clk helper function
  pwm: mediatek: Initialize clks when the hardware is enabled at probe
    time
  pwm: mediatek: Implement .get_state() callback
  pwm: mediatek: Fix various issues in the .apply() callback
  pwm: mediatek: Lock and cache clock rate
  pwm: mediatek: Convert to waveform API

 drivers/pwm/pwm-mediatek.c | 498 +++++++++++++++++++++++++------------
 1 file changed, 344 insertions(+), 154 deletions(-)

base-commit: edd3bcb1801e1bb98f4f81485140e18c86406ced
-- 
2.49.0


