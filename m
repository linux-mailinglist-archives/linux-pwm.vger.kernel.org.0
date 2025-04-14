Return-Path: <linux-pwm+bounces-5479-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5E9A88289
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 15:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A883188A4CD
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E4428BABA;
	Mon, 14 Apr 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IioLIqY9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7F28BAB2;
	Mon, 14 Apr 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637267; cv=none; b=CAMWQXbOUXcn8BaspX8LLX6Aw9HFG2RMSvgsP2XGK1tNEtFjcFiWpVhLM0sQZAI3YlGJXA6BLSCRfa87a3Cr0NCpRfs4CDQKKneXyJ24iF+i0sJmLuH6hGEk1bGUMF58IIWibCaB3Px6GGYT4QvdP72UN3Lv1WzNsmBeiC0emZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637267; c=relaxed/simple;
	bh=BLF5CT5kwcWC1miXyvm9/Lok3k9VPVK/u1JpmTejCmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVzJqske5Iq9FMHdcJc+bCjCwmI4M9hLkn7WNfCCOurC3rMRMGjUK8MGWQGxyXU0yMCrP8hUivfdw8//WqC+yB0OR3M3QsEPooD0eCJnqT8ce9YcHh/SPpzDhzSw2XHUPhXTUR/PFt0ve7uvI0kwvOnosOlOFLWhsga3Q0wMclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IioLIqY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999EDC4CEED;
	Mon, 14 Apr 2025 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637267;
	bh=BLF5CT5kwcWC1miXyvm9/Lok3k9VPVK/u1JpmTejCmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IioLIqY9IoMV+ORUzAYADOxUAAj7aIZ1fZ39vpl6DqScR2coigcEvR38Z20t1w2wW
	 2nm1iZTxMFV/5PiWc7woamt4JmV6k0+K/gSkKH/hKLEre+rxAu8f/f8khrZIrXt+dn
	 /rBZWuZ1nsQyYDrUeAMyPaimL4qKWUYC7Gx/yFm4KAyVcRGDtPWjq7qA5f0xGR2wXU
	 7UbjnRhaRHClnNoDMcByPhz6k7uyOf1F06GNrZ4s2Sul487LeJ84K3Kr28e2ziCGe7
	 1I91+dfxr15eu17bTQ1Tbayq0q9bsRfBZJRazBUfWDOVp2Q8NmvtjIFB8fVPqzgHgB
	 5dGYfaf+xe2fA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 08/34] pwm: Let pwm_set_waveform() succeed even if lowlevel driver rounded up
Date: Mon, 14 Apr 2025 09:27:02 -0400
Message-Id: <20250414132729.679254-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 00e53d0f4baedd72196b65f00698b2a5a537dc2b ]

Waveform parameters are supposed to be rounded down to the next value
possible for the hardware. However when a requested value is too small,
.round_waveform_tohw() is supposed to pick the next bigger value and
return 1. Let pwm_set_waveform() behave in the same way.

This creates consistency between pwm_set_waveform_might_sleep() with
exact=false and pwm_round_waveform_might_sleep() +
pwm_set_waveform_might_sleep() with exact=true.

The PWM_DEBUG rounding check has to be adapted to only trigger if no
uprounding happend.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Link: https://lore.kernel.org/r/353dc6ae31be815e41fd3df89c257127ca0d1a09.1743844730.git.u.kleine-koenig@baylibre.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 99d0bc6933152..bd79953272405 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -322,7 +322,7 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 	const struct pwm_ops *ops = chip->ops;
 	char wfhw[WFHWSIZE];
 	struct pwm_waveform wf_rounded;
-	int err;
+	int err, ret_tohw;
 
 	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
@@ -332,16 +332,16 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 	if (!pwm_wf_valid(wf))
 		return -EINVAL;
 
-	err = __pwm_round_waveform_tohw(chip, pwm, wf, &wfhw);
-	if (err)
-		return err;
+	ret_tohw = __pwm_round_waveform_tohw(chip, pwm, wf, &wfhw);
+	if (ret_tohw < 0)
+		return ret_tohw;
 
 	if ((IS_ENABLED(CONFIG_PWM_DEBUG) || exact) && wf->period_length_ns) {
 		err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
 		if (err)
 			return err;
 
-		if (IS_ENABLED(CONFIG_PWM_DEBUG) && !pwm_check_rounding(wf, &wf_rounded))
+		if (IS_ENABLED(CONFIG_PWM_DEBUG) && ret_tohw == 0 && !pwm_check_rounding(wf, &wf_rounded))
 			dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
 				wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
 				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns);
@@ -382,7 +382,8 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
 				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns,
 				wf_set.duty_length_ns, wf_set.period_length_ns, wf_set.duty_offset_ns);
 	}
-	return 0;
+
+	return ret_tohw;
 }
 
 /**
-- 
2.39.5


