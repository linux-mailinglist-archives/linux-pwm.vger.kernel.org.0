Return-Path: <linux-pwm+bounces-7347-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA956B99085
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Sep 2025 11:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AEA2E393A
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Sep 2025 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1839826E6F4;
	Wed, 24 Sep 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rDDeVtSV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDD522F
	for <linux-pwm@vger.kernel.org>; Wed, 24 Sep 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704816; cv=none; b=UqWGuE5WRQhbHdeO245xQzHPZIFnpU9F+4f4XvUuZivzrnmUzWRZukZ5szI8kMsEKVOOJoSc8QY8ez3cUoAsjZbf39R4puywKjWO5epKU/rkfDUr0hpZH38ZSZKmpdXptr3uHrLcug6c01Q7h/YeH3ak4MLeQV7B2ngVBjbWua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704816; c=relaxed/simple;
	bh=a547ooMEsxEG/7bHmCeVbD/kqXHtT87FdYIiTphxlwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sxw4p5r9FnJDJniEVd+n/DtUZdf7ZL9SKmTY9P/7hNfCM7TbyOtaNj9HFiLb82O/fOPbV6YV1Q7QirXh9FxawEG+kh/TCtxfopQaLTYFDMEqAP+bcJT0Oy7mgKnB8QH57+XuzXnHxqTagDkxojarqBrSHM8CU7QxuPndXsGMug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rDDeVtSV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 42505C007AE
	for <linux-pwm@vger.kernel.org>; Wed, 24 Sep 2025 09:06:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6BE2D60634;
	Wed, 24 Sep 2025 09:06:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EF14102F18C5;
	Wed, 24 Sep 2025 11:06:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758704809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=V2DD00oh1THLAH4vzd8aYJmPGiuNTiVRW2t0eRhScD4=;
	b=rDDeVtSVEhxdQ31Kq66eCQMvoBSze17xUsmSfRJb1aAD4WDKKegY2Iu6YtIa7Q2tpJsxqU
	jKBY0+GC3QZT0id0e092IdL5Qm12b0kk/iC8wFagO2cjPSqha2kapU7Izyw6HwsNSq2rhN
	Ti9ryf0l+XdcvUNFnfUa3xLGQo+v9lXqQwYo02I//k+eIgu1Q1NvfjB9U71kLKq5s6CA0N
	XvwE4VZms79ulZnt/yZ1OlMqtERyA731JGUHOaTozW0VWPSi1Ux0invdqL4VrSYSR+GhSv
	kGpEA8ozw0Zlvu1taOLa9djwtVOLWDwLOHdy305k5pSythyWnXV7hN8Encw/pA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 24 Sep 2025 11:06:40 +0200
Subject: [PATCH] pwm: max7360: Clean MAX7360 code
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-mdb-max7360-pwm-optimize-v1-1-5959eeed20d8@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAJ+002gC/x3MTQ5AMBBA4avIrE1Spf6uIhalg1mUphWEuLvG8
 lu890AgzxSgTR7wdHDgbY3I0gTGRa8zIZtokEIq0cgCrRnQ6qvKS4HutLi5nS3fhMNoNClZT6p
 qIObO08TXv+769/0A+AyjEWoAAAA=
X-Change-ID: 20250924-mdb-max7360-pwm-optimize-bcdae528f579
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758704808; l=1246;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=a547ooMEsxEG/7bHmCeVbD/kqXHtT87FdYIiTphxlwg=;
 b=vWP85clr7MmOw5Vbuo3FLJYcnrREbMxrFB/6fwf2puzvpNW3haywUQB1M5wYVl3nCBQXHBOa3
 2Nob72i8/G4AQXIIExLqTzFXPJXNiPcjbOJNSkvqyjlqNosmYGgodoJ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

Duty steps computation can never end in values higher than
MAX7360_PWM_MAX: remove useless use of min().

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
This was discussed in the MAX7360 series[1], and I believe we can indeed
remove this check.

[1] https://lore.kernel.org/all/20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com/
---
 drivers/pwm/pwm-max7360.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
index ebf93a7aee5be4cfdac89601b78e6d20955f4877..16261958ce7ffb261b5a7cc7b1d47f63d6d398c2 100644
--- a/drivers/pwm/pwm-max7360.c
+++ b/drivers/pwm/pwm-max7360.c
@@ -75,7 +75,7 @@ static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
 			duty_steps = MAX7360_PWM_MAX - 1;
 	}
 
-	wfhw->duty_steps = min(MAX7360_PWM_MAX, duty_steps);
+	wfhw->duty_steps = duty_steps;
 	wfhw->enabled = !!wf->period_length_ns;
 
 	if (wf->period_length_ns && wf->period_length_ns < MAX7360_PWM_PERIOD_NS)

---
base-commit: ce7f1a983b074f6cf8609068088ca3182c569ee4
change-id: 20250924-mdb-max7360-pwm-optimize-bcdae528f579

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


