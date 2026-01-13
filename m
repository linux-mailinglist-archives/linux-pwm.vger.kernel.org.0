Return-Path: <linux-pwm+bounces-7900-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1455D1A54D
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 17:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B645030057F2
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jan 2026 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1462FDC3C;
	Tue, 13 Jan 2026 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EWEw/cU3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D123C17;
	Tue, 13 Jan 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322365; cv=none; b=hxh9d5l09MiXOfC1I0NTxLFABIRzV7pVtv3N7NaUyKTsbGBc0ER4BayefrZnyRaVNuHMlBKA4H72gTIISVBzJEnHNRnR9PcZnyTqm+zVz2HhLcVl/LM14wC03uimVpautursqjm1jhzwYBkZXR63PPYoCD/N2bB9EjMT+v2eX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322365; c=relaxed/simple;
	bh=cTDaOcYsR23e0TMCw3wMeBVLm8PmOyoD26HsN1zuacA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUlwfHyWaNUl8LxfWUZctoF5jwoEh7BYpEWApBamnv9Eiwqe5oPWB1Iz+j6N7KnzpscVw6mU1y8XC8YCMnIbh+Ds+W2F7t4owj3e+QKXbF4cyN4eubTzxXrrjyw4ZBgE385jv4cTi7GtBCanENT5ipQ1MRXFWsdO1aew8gpRa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EWEw/cU3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5FC104E4208B;
	Tue, 13 Jan 2026 16:39:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2AA8560701;
	Tue, 13 Jan 2026 16:39:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2CE9103C85AC;
	Tue, 13 Jan 2026 17:39:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768322359; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=3sodVq0G5QcdTkgkdEymmQRfiyFtPBZqKfxHa0BjOzc=;
	b=EWEw/cU3jLcfMo5hZohS++j0nzFS+bXcgu9ptWa96a5Rlvdk7oNkWQXAJaIOmtzSOCd7sk
	Kw1K5+zkOCec4gjca9Zkv/ze2P47C4A8cWDmjQo248gbkDtFmuF4HHcCHSr7fUkrnOoAsI
	WrnEO8ZkJbUhXZk3+yrJC6ET819jikfrpHnq5nsRQbfbeQ69Czvl0y01ldqYN+ssjd9cw3
	hh/WhbpEzCwokOmU0kC7FiyFJTp/0zAaa5rwL1DHDs5i0a+hNUlLv+k2UNfwWPP3NahFzk
	WDXMaRaHNSmrEq6RQiEc6dILfaSJ1WkezaADgd2TMjD5/lev9Hwa/Q/bRAZ+nQ==
From: Richard Genoud <richard.genoud@bootlin.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH] pwm: max7360: populate missing .sizeof_wfhw in max7360_pwm_ops
Date: Tue, 13 Jan 2026 17:39:07 +0100
Message-ID: <20260113163907.368919-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The sizeof_wfhw field wasn't populated in max7360_pwm_ops so it was set
to 0 by default.
While this is ok for now because:
sizeof(struct max7360_pwm_waveform) < PWM_WFHWSIZE
in the future, if struct max7360_pwm_waveform grows, it could lead to
stack corruption.

Fixes: d93a75d94b79 ("pwm: max7360: Add MAX7360 PWM support")
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/pwm/pwm-max7360.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
index 16261958ce7f..732969303dd7 100644
--- a/drivers/pwm/pwm-max7360.c
+++ b/drivers/pwm/pwm-max7360.c
@@ -153,6 +153,7 @@ static int max7360_pwm_read_waveform(struct pwm_chip *chip,
 }
 
 static const struct pwm_ops max7360_pwm_ops = {
+	.sizeof_wfhw = sizeof(struct max7360_pwm_waveform),
 	.request = max7360_pwm_request,
 	.round_waveform_tohw = max7360_pwm_round_waveform_tohw,
 	.round_waveform_fromhw = max7360_pwm_round_waveform_fromhw,

base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.47.3


