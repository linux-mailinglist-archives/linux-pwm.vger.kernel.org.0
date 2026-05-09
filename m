Return-Path: <linux-pwm+bounces-8850-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CQdM7Gd/mkVuAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8850-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 09 May 2026 04:36:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4631B4FDAB3
	for <lists+linux-pwm@lfdr.de>; Sat, 09 May 2026 04:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F1A3019B9C
	for <lists+linux-pwm@lfdr.de>; Sat,  9 May 2026 02:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E0332601;
	Sat,  9 May 2026 02:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkLXbGI5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF42BDC0E
	for <linux-pwm@vger.kernel.org>; Sat,  9 May 2026 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294189; cv=none; b=MLFu48qeCS4WXdsIKMiVzuiarkQxadnVpfSqrmcl3i2OmJNy0WhhIE/M4NYwdAo1fexhxeTE7mcsbCJw+ucb5NXGSPS3BLJ+uLd+WXo7SK9JoCJpwAqIBu8QdKvnknKx6ZNiT0ilalllHw/a6nRvXQ/M4U1oh+JqfjaFbL9oOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294189; c=relaxed/simple;
	bh=yPGeGQeF7ZmjszHHDZNO4E+2ecVzgEKpMNNFMPwSynI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hi7+FGaAGwHnc+fdWvrXM6n+f0ydSD6p5/ccb4619OORP9GF9ZInNferEc4ztzcpAJjHshD4Na1RJEcmIXG0C+5Na1zJZ9Y+ZQa2ZlNBW4S9u2gNEOszVUSS5FDi3YSu2aJBCS+vm4ZEj+zkh9R7a1MpVGOwI/mCGub952iGC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkLXbGI5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367c26471f5so381900a91.1
        for <linux-pwm@vger.kernel.org>; Fri, 08 May 2026 19:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778294187; x=1778898987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APtyaoaonTV5g0DxIkb+zbpcnh5qX8Mj7YUz9WutwhE=;
        b=YkLXbGI5AK0ZQ8rxNgWV1G4RBZag0EeW/9bT4UXZ6CMmkqCwdUZ4wTmYMTAOppZrGE
         UaPFI+ZvvaS/hEW05MfElBo654sYnD9PvUkMRTqn1XiCfqFfs6ld9hxJG0idbiFV9CoZ
         uNDRr8eNv77Z4qni/6pAtfjtCF02IcOIhXTF5kPgmZ+5yv+eE2MfNbi/d8sCojYkJb8N
         VFVqQwgng4Am0KKPwkKLSJ3lSBHRFpnWKrLwSpJr8Oc7LBJmbTheF2HNvy4sfyZX4B1b
         gMlcb2hVhYm5oVeFm58b67qLv2nPbruje3KjU5O3iI3O7hXTwm+vva6jGT2tias1YxUI
         m6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778294187; x=1778898987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APtyaoaonTV5g0DxIkb+zbpcnh5qX8Mj7YUz9WutwhE=;
        b=Iu3kFawGH1ZAy/zGe1CyQKAKiQsVf5jOdau93T3xUmlJOftNRjUqgx1lyWFXhuBt7n
         rgdTIwG9hYRlcdAtX00CsVIrG7TNwbfX2e/FEy1EZeRlal5EWYpgJBGFzbDe01BIwSdc
         Frnsdc9I41QZl3CWoX2lnRZRXSNzGcEg6GCjgfkeg3Z7XhfpOfu6qh9jYc4XUnvnTEen
         pCwVkSEUM5A0n/tdxWOygNuZETgJw2rH5+4F19nniVSdLMsS+Ck5wmq0sSrcgLbj34bZ
         Pzz80FK5zfZeI9gfBeXAOhMYD5XXImQaBSAiyBKPmSF85iN/PJmS4U5lG7xld4VCB9b0
         sH+Q==
X-Gm-Message-State: AOJu0YwGNGsELH+R5zwTxUiwk2rpxQ0STj49IYh8cpYXH4qYetpo/eoR
	aXSF9D0An8IMefkl+f3xodmBYIgs3ZifxHmIwCS4hrjJNyejbtB0gu+64E0pbD6m
X-Gm-Gg: Acq92OFNKcljTSUp+1LEmNim95pxVKVJ3kgPm8KHvLUPmNx1DC2471/EdbDlFty5NQZ
	X9L+KRaz4SzehVFdmvpDd4MhbtVcSD6n/3/eAHl/s+2LZqWC3DqEKhjNaAVLdEY+C/0EP/KKEKe
	o+QM+XHLs+GjZyf6tbCnMGedmLYDub2D/K6NHCNCgwGHQcAoL+Kqz6gO0itaAeWSnvmeLHWtVYD
	GI0E5rWOlglQZhELmeqgZPJlOkDjvy4OuBjBp6KzqRi3NLICcEaJ3OPSW2+rLov/GHRBlFzj2YQ
	OVOPvJVX7d6LhUy5iDyVpLvMshMzQ0QIhfyeD3NsMRJZslaEcPlCfLNemfgA/9z/GpNR0BN9fyE
	7/ymwAzs6OTZGmUfxjFtU7J/W1AwxDhrrLJxav8Bx9n8lp91miEJQm/WLkckU9K/KcmeCxGRq38
	g0JIExvgsjiItp8r1barDonwhRndrf3UMdqpGhxoe5yjtv/xZscXDYAi/y5loNVIM1Jt7RxRZWW
	6cuw+3llGtTzD3ugZR9HJeAVXIuz00sNXw=
X-Received: by 2002:a17:902:e74b:b0:2b9:cd2d:6f11 with SMTP id d9443c01a7336-2ba7929e170mr152796995ad.18.1778294186821;
        Fri, 08 May 2026 19:36:26 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4050dsm34348395ad.31.2026.05.08.19.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:36:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pwm@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pwm: ipq: Add missing module description
Date: Fri,  8 May 2026 19:36:09 -0700
Message-ID: <20260509023609.1007698-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4631B4FDAB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8850-lists,linux-pwm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add a MODULE_DESCRIPTION() entry to fix the modpost warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pwm/pwm-ipq.o

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pwm/pwm-ipq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-ipq.c b/drivers/pwm/pwm-ipq.c
index 592c26fcc9e6..c53373948136 100644
--- a/drivers/pwm/pwm-ipq.c
+++ b/drivers/pwm/pwm-ipq.c
@@ -260,4 +260,5 @@ static struct platform_driver ipq_pwm_driver = {
 
 module_platform_driver(ipq_pwm_driver);
 
+MODULE_DESCRIPTION("Qualcomm IPQ PWM driver");
 MODULE_LICENSE("GPL");
-- 
2.54.0


