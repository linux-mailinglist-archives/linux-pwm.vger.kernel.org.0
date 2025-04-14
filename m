Return-Path: <linux-pwm+bounces-5477-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2CA8821A
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 15:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5927017A3D4
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4EF23D2B4;
	Mon, 14 Apr 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0xqPpQQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50F2E62B4;
	Mon, 14 Apr 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637189; cv=none; b=R4zho/gUn5oiEhGcMPJ0+/aa3eEp4d0V8n9Uwqd5WeG3Mtbs1JReWYXpqI8rh+CXHUa3LtleaK6UEujI7rZq30SLo0Wm+D9jfjDWYgiJrKzIcMbw9O5l45HBvqSRExqMLO/sAXYcHKWRF7Rm1UkKTTPpZWzJ+LM1+wMOI6k+Wvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637189; c=relaxed/simple;
	bh=H6Q+LSs1SR7q1WkPmS/g9TQtnkak/T6UvVo4+FnU6/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3fIALkK+31Lc11KnzTjMt5Ylot9W5iPbANl7DOLMNXdIETAm0aJiVml0s3IEFH+3B9CtzpeQ9x/qit735pM6hQh7Oce9rnZpMVVPKoq7avqLwrjnVhs9F4fzsFprj+pxPQi8lz0IMfO7fAGQ1k3NARIfj574caom8syrDqf7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0xqPpQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314A9C4CEE2;
	Mon, 14 Apr 2025 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637189;
	bh=H6Q+LSs1SR7q1WkPmS/g9TQtnkak/T6UvVo4+FnU6/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0xqPpQQneeOO8daIM87lHgq0U/MH6eRTtSL8QyFFd2jxjq9s/HSj/yflK4lWNTiZ
	 H8DiUbXejKRpR+LEIrHQuyZde4VpyDBnfG65PGL8qXrIp2DVcBMdR+n2Ip/4+e7EbG
	 jOCR4eKjJ7PBZc5Taeqfcsg5/KT/arXB8c0ac4CmtMhYUbcoqs6VOEPbe7zjV7Nma5
	 3kSKayDYM4kFCBpqHSEzj0YXNjXRRaSMSaKQ9unSRqddN4lxLJWAErvBPQC97om6L+
	 QkRDdV8GwD8Z0O2K2vot0Ygq7VbRlGO7b95qV06fw5nM2iBG6+fGvzzUnWsCzO1YI+
	 mQbubSgYq1LvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pwm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 08/34] pwm: Let pwm_set_waveform() succeed even if lowlevel driver rounded up
Date: Mon, 14 Apr 2025 09:25:44 -0400
Message-Id: <20250414132610.677644-8-sashal@kernel.org>
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
index ccd54c089bab8..0e4df71c2cef1 100644
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


