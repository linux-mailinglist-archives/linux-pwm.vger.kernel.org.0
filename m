Return-Path: <linux-pwm+bounces-8979-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCZaIChLC2o7FQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8979-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 19:23:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9AE57197F
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 19:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4733830237EE
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D091B3F39FC;
	Mon, 18 May 2026 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="MIGjySnT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC1372ED3
	for <linux-pwm@vger.kernel.org>; Mon, 18 May 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125028; cv=none; b=Tj/a2v67TzeqpL5oopKvxHV5zRIlVTPvz2tzNgwPyRW05PsActqBCtuby29CQWyRguQA/uGAtR5fnBNDx4WtkOYUlRzlZSj3aPCrZpyPYekd+mfzF0zAc2DuXqOFPjHgCQBzMNfW90UVD+ETFsuzUopwRs8DIXb5GQ0ebrw3MT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125028; c=relaxed/simple;
	bh=43hGWy6CXT2R1bwTxcRgu8XuA0X83BFP5fjXxCH5MSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=myDKRSzgcH6qEtUjXvd0nii8KSIPEeR3HvNaQmesLeny/HwzNDK57lSZjnjiepkpzKJwky7th1elmv4Ws/5kX1tFe0filUE1ZoMSCzvgEimEczsx4SvXZWpuVScT64RiIpltPZkpk2RNZUPDsvgfz1XelrV9jb7tk/OKfN8CvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=MIGjySnT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so999903f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2026 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779125024; x=1779729824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MuK6ptr3aWkYIKLFnR1DBnyHrMXuuFxeZ3aCiGm6k6M=;
        b=MIGjySnTfJOmi2Gm/Tz8cyWhX8otSHaNnR5owIi2sUB6PpQxlsTCIy2a5kJvCm8xS6
         9z72P8lefcpmHmG7VoWO+EuT8zt2zHlJUwepwTZxoOHSd1x5WGF9dPKrpulnClPyPgtI
         Z0hAEpGFSDMhBrMfwqZxekMnXzkrirC4PYrhEpQ/3lbx+EYmjYBKLgkqQjxSzNg8dVfi
         IOaGlDTJ6ka4BcBmbflBjZy1jgy6Jz0zfPqIOcrP2GWTQaq+3maWhgZWO3ugUAjsQF9o
         ET3Q88/wnwSgmj5yeqDsfqxGEl1IPud//tCHlFE/v/QlurU8E5k7VJxspDETF/c5rZfk
         kJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125024; x=1779729824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuK6ptr3aWkYIKLFnR1DBnyHrMXuuFxeZ3aCiGm6k6M=;
        b=J01dPW3JBh83rZc+hfbsWW8LaxI1tSMpbp2NkFAvj87HIn3X2BIhm6R9S3gaTx5qdD
         gKA3c/3HHHXKjvlP43bUbU1amLZ9y3/BJ39JzWgfw9dlV8sWv8oX05uIBSesSqKXJQTP
         oiob55GdZqkWwARf6ln2OyqXz4tj0dicUnS9FXBHxuOcucamIy3nyaT/3akhuz/b1Z7e
         53FTkJpiU3qxeG10h3J/6waNrFSePq1Lp2nWDtOk8RkSkW5qlr5D8nFwMFMGXarLvJZU
         J6P54I+HOs3kjby0xFD3w647RJM+XGqgnDnHeT/4jWU452+J9L0mQRIzK5EPytqQ3rDL
         rQoA==
X-Gm-Message-State: AOJu0YxnHrGcyKLc3EExgLl2wCOKknf/bafNRYf4O3MQHH14u9T1JEC/
	Mjg/mpsmnQc9MVxd0L5iX0O9WDLXlQNmH/nCrCfyQ/O31Q7GTpX97KdOTOud7Kds2ohUP0LamzU
	0armof94=
X-Gm-Gg: Acq92OEC6z2h1cSCHjN3OHI6sP0WKkbXe5ADMDRAYzdZXM1bnyYtsu9hYmaYIOWOAkg
	FyHrxuBYS74L2jI+aMEQJSspGvV5bM8l1B0c6qjgnCox6luGSAJZDATN6Y7Y+lQgd1EEUQX6wrL
	szs552BzulwN6a6ucVCoJuZ/qQDz2on4XPoRwjhTVFG8gCH4KnD0PeTNX6Pdpg8n79LZO25qSsB
	DD1gr9i7O9Ka1gcwUi9iyGHwNWlmQQzU1kayVFWo1mUwhyXyLe/tgCbmLSpSfKKsVTArjrV4j5R
	yLYue+og1ljE6peKBCu1ASq8GoygCXCAY6c+kFFhWYWQm9HPgI2a4GWbdCqms/hwyAd/7gPZ6hm
	peG38YPIX1fRj9TI48qkd1TzC8beQ1kPaZC/RIZpwc+XyFc1uUtnQC0JmSid9DDKKyhpKvZMqHp
	pisxxRHKRHjeX81M9GOD1r7b1EbZgPErYQlZ/AxeZ7D3fDLw/ziIfO2fuAIS99uW6QYCYP8FWFh
	sTe1YWA6lYP1A==
X-Received: by 2002:a05:6000:4014:b0:441:1fa5:4577 with SMTP id ffacd0b85a97d-45e5c5f20f3mr24717081f8f.26.1779125024256;
        Mon, 18 May 2026 10:23:44 -0700 (PDT)
Received: from localhost (p200300f65f47db041bee4d0e08e9609b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1bee:4d0e:8e9:609b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0fe0f72sm41580678f8f.25.2026.05.18.10.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:23:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v1] pwm: pca9685: Use named initializers for struct i2c_device_id
Date: Mon, 18 May 2026 19:23:22 +0200
Message-ID: <20260518172323.932774-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=43hGWy6CXT2R1bwTxcRgu8XuA0X83BFP5fjXxCH5MSQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqC0sLnHgpNKtc2+h/7i6WXAYsCAutfNRxxxmor drbEyOtG1KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagtLCwAKCRCPgPtYfRL+ Tl9UCACkbdG/hXUGY4ZN2jzhlhSF/SqNxHOIkBj2+F3mSeU5Xb89Z0HraXLZErENNfTzoFOpv3q hQfX8f/je9DtXf2Lfu607NQ8irWUamaJnaFNaEDWrQN8fGvlSdZ1kufhI+Q1/zQbmlyKezwpbZY EJvwo3VN50V/FH4XTz8rPXlCURZ2EbdPzkQy4DzjPVNCYDSG0EZbMfx+RiyKYvTjqZZ+XueDhe9 F5dIDD8LJuiDPVGCnRUhjJHpXhCXJXnsa0zOkigp87xHSoogiGpa5Y3k3CCHcW61thw+LfI1DX2 jJEvX/nWBbNW14pbKxhBH7E0Ey7HYGZyi12Jcu7z87cZG+Ok
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8979-lists,linux-pwm=lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,baylibre.com:mid,baylibre.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0A9AE57197F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this patch is part of a bigger quest to use named initializers for
mainly struct i2c_device_id::driver_data to be able to modify
i2c_device_id. See e.g.
https://lore.kernel.org/all/20260518111203.639603-2-u.kleine-koenig@baylibre.com/
for the details.

This patch here isn't critical for this quest, as no driver makes use of
.driver_data, so apart from the better readability this is only about
consistency with other subsystems.

Best regards
Uwe

 drivers/pwm/pwm-pca9685.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 107bebec3546..a02255a64ea8 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -538,7 +538,7 @@ static int __maybe_unused pca9685_pwm_runtime_resume(struct device *dev)
 }
 
 static const struct i2c_device_id pca9685_id[] = {
-	{ "pca9685" },
+	{ .name = "pca9685" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, pca9685_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


