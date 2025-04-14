Return-Path: <linux-pwm+bounces-5478-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10851A8821F
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 15:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC69D163A7A
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 13:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906C252285;
	Mon, 14 Apr 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPCk/UM9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59C252281;
	Mon, 14 Apr 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637192; cv=none; b=CxLvu6YA+/ZtfOkDbDPVbTWxK4QyEBDtknUYD7/qNM6GsYG6pAMNYbGO3Ci76zbzq85WLSg+rEEd0PqfzcsmfuPgG4j8jkyfLq4LvgoPNJnFrxzftzoqnTV2GmtnBXExZrsUJhrdgxyQbku7d4en6gpySjbb7xZYVcDDI/vI52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637192; c=relaxed/simple;
	bh=W9a1bZacIMHZgIEupV7PVdZLCgm8bqcqKRtbQq4Ex1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5ywbhUuGv7m2tzkgbETSp4C2VRqiGy3zHnKPBYyDiswHb/mW0ry/7aYXM7XUdLO4OmQ7UdHK2Pi9YL5MMiKKGcsFNhvieM03iyFzdTrIhUdakeyyhSvrZ3Uwh+QoLdzyLCTXIIM+LwzYRgVxwEczQTvHGWBq0y66i4b6yCCpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPCk/UM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B118BC4CEEC;
	Mon, 14 Apr 2025 13:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637191;
	bh=W9a1bZacIMHZgIEupV7PVdZLCgm8bqcqKRtbQq4Ex1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPCk/UM9LyzOgFWqXUSkY9cuvHQmHo73F03qkm4ddOUhWNjUVuRf6vXotVwPCMIvA
	 RWEP2Z4n/2q3BrnjXZ8NO5PxxCtZPFpBRkpcRPoy0FlOqgN6iD2DRgfxttM7RYC7tW
	 VanU1Otd8DVtgKcIeyFEcSRfqsPXWszUW1982jNnl57zO7odF3IyeM7ZETuh9elnaX
	 Qw3bT62rfW8hkByemF0nzuxuBzgoqytkKw7/8nyAyjtULCWHxaWSzsPSAsaIFCom8D
	 cdO2GYjxYg61XwhYLoaQa0B5wub+oeK8WRNNr2nM2VZP6JYHxHyxnUkH3lpqIEaOt1
	 bath8vEIqw2gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 09/34] pwm: axi-pwmgen: Let .round_waveform_tohw() signal when request was rounded up
Date: Mon, 14 Apr 2025 09:25:45 -0400
Message-Id: <20250414132610.677644-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit a85e08a05bf77d5d03b4ac0c59768a606a1b640b ]

The .round_waveform_tohw() is supposed to return 1 if the requested
waveform cannot be implemented by rounding down all parameters. Also
adapt the corresponding comment to better describe why the implemented
procedure is right.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Link: https://lore.kernel.org/r/ba451573f0218d76645f068cec78bd97802cf010.1743844730.git.u.kleine-koenig@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-axi-pwmgen.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 4259a0db9ff45..4337c8f5acf05 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -75,6 +75,7 @@ static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
 {
 	struct axi_pwmgen_waveform *wfhw = _wfhw;
 	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
+	int ret = 0;
 
 	if (wf->period_length_ns == 0) {
 		*wfhw = (struct axi_pwmgen_waveform){
@@ -91,12 +92,15 @@ static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
 		if (wfhw->period_cnt == 0) {
 			/*
 			 * The specified period is too short for the hardware.
-			 * Let's round .duty_cycle down to 0 to get a (somewhat)
-			 * valid result.
+			 * So round up .period_cnt to 1 (i.e. the smallest
+			 * possible period). With .duty_cycle and .duty_offset
+			 * being less than or equal to .period, their rounded
+			 * value must be 0.
 			 */
 			wfhw->period_cnt = 1;
 			wfhw->duty_cycle_cnt = 0;
 			wfhw->duty_offset_cnt = 0;
+			ret = 1;
 		} else {
 			wfhw->duty_cycle_cnt = min_t(u64,
 						     mul_u64_u32_div(wf->duty_length_ns, ddata->clk_rate_hz, NSEC_PER_SEC),
@@ -111,7 +115,7 @@ static int axi_pwmgen_round_waveform_tohw(struct pwm_chip *chip,
 		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
 		ddata->clk_rate_hz, wfhw->period_cnt, wfhw->duty_cycle_cnt, wfhw->duty_offset_cnt);
 
-	return 0;
+	return ret;
 }
 
 static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.39.5


