Return-Path: <linux-pwm+bounces-7323-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4BAB58237
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8607AC5DF
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Sep 2025 16:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D172836A3;
	Mon, 15 Sep 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu/0jxRE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377A6278E67
	for <linux-pwm@vger.kernel.org>; Mon, 15 Sep 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954204; cv=none; b=g7NVVZ9nwHOHtf25iDL3JDAvgCtMA5W/2YhWDPw32y4uDkC475rv8SgZamQrk2YUvVsXjR5XcnVeBih8Nx73CIHtoiBkJx4RrwRKnTYpj3Psx9Q7yOXMbsBPzYzNPT1Jvyk4LFMRDxg3VLvpfVvCmrHBrTqzSRqMc59pMsBjFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954204; c=relaxed/simple;
	bh=rDWLxp6tmGy89TUxrq+v7glS2m9ke2bHRuQBeHmGTns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLTM/IrJYM6UK2b4ISvdxxLC4SNgxwvlZ5+ZYG5hNAxXC0NqSwm7o+KOWBPslTkUE6AldAi/ESdRYNoIV+93/IYb2FCYVErfdPgts8H60yjQCZFsc2DJoJ2GPzBDkY46prOtqbYuPGUaxi9IaLQxZy9qY4CKINiSNp0PSrCLYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu/0jxRE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e957ca53d1so1523847f8f.0
        for <linux-pwm@vger.kernel.org>; Mon, 15 Sep 2025 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757954200; x=1758559000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OJ3rWm1NdBVBDGSPXlmB4CHoSkVBFKI7NjDh4TZsv8=;
        b=mu/0jxRE7SNdVRabpCMVCRH0wq8ZfsJ3qJDGacQ6Iawy4lzClqq/W0BJOFTRkdyfr4
         WHAEaCxkZ/Gc13TkNktOX0pFap9a43kiMuzg9BwAKe4ApWaTNKy0P51pwi6us3njl3DT
         QF5oLdrgiw6JLjakK4XNJhnnCTGninwxOaE4Vz7D+mTzrZtWoYnLYtcXfU7zDJK8w0Mx
         xZGbHn/obFn9YPdYLzRIgchZULj09n/lXD0KUu1i1NklfAx4P9Jv2IGCwSPUAOSpVyfQ
         f0QP3/0DGmPaPs8J8YfF8m4WvBJ9zsdjYAaDTQWOZvEJIk08x6Hx4iLSutvq0ngjSVcd
         VzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954200; x=1758559000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OJ3rWm1NdBVBDGSPXlmB4CHoSkVBFKI7NjDh4TZsv8=;
        b=J9qi4lWxf7Kj+pvPbfQbPR0a2ks9NbzqevxRGqc7l6pz6mfrIUPdIzsUZE9pVpwWqW
         o2YSPsI3TyjTIAzZBTNRe81PVDxqXMIQAzW2mFhEuCKiYxqwrdfz3sIQg7VcZ59OnhbC
         XIrCr/D6UDlV6jBvlrY/3AejoIT3Iy0/LxgLQwZggTx6aLMhrVg/8fawZDx9R/RRKTYl
         mwW7YjsXRaLHBsS8wH0DJsinrRzaTTByCocGb0szC/qU/f4v8pxqA9o3GbxHDGXbpNAq
         1Pxw31CS6IP33BN94IwZmav0xmtc7TDXUT49k/3Xs6wrih4oqc+rPrcjR5l+nkeXsU0U
         6G4g==
X-Forwarded-Encrypted: i=1; AJvYcCWDpQvBGMlSxa8PLb4meF942XoxLsr9+49C3CqiAU6OI/wgjHPwDluzEh243wZQWLl5Ks7BmSYUOPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBkmpzjjZj2OsYJbQ2H82WeXtI5zPmDVIlQ2ENvXX6+DobZEZ3
	kFT3oCTBQBXiT8GqoWgc8sftelQcEL/opqESgaHxUgBnKIAzAinxfsgz
X-Gm-Gg: ASbGncvFAeBih+L9YfPM1LlEa8xUeRAQ9NiJbQnzTR/6E6/mFkan/iJlTEkBQ3qLvQl
	dZPgtwhdA69gCyCbOPuop2Uf1iW+qkzZxu/mGwnLtJ8t3u7AcyfccyKfqR/QJRErLqWxkVWntsv
	p4KFmX4wlzjS4JzT+xdimy08iLaWtA2ad2SOCnirY1jJjvQqZLwAE717Ecw5D1kV3yT8exdp4w5
	V/771h24DMpdUHRnkKVKRVvK20wuW78+VZPpB5FtrU5ASwzxBB6cs7zWQWDVPkKvCK69bPvX0Ms
	gVMtXjSuIHD3AODprCpWehDCy/ziiJHS7Q7f5etwBbcD/UxM+1blqMipMW5EKor5eIdyRDclyMD
	T5tVW8EJDuShNfdEHO3dyVbYhVLfz/aJgUAb0mKXiI69/nHGJknLak8h3FmqzNjp/nqm789V2rb
	U7UQ==
X-Google-Smtp-Source: AGHT+IED6gF8qcEvOi7QA8TOlT4uJTio9AlnSyt9wukyF4ICcxPu7tcLpX/0qcZhpWhffKIb1KG2SA==
X-Received: by 2002:a05:6000:230b:b0:3d4:2f8c:1d37 with SMTP id ffacd0b85a97d-3e76579656amr13722725f8f.26.1757954200319;
        Mon, 15 Sep 2025 09:36:40 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8f4d644adsm9521728f8f.52.2025.09.15.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:36:40 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 1/2] pwm: rzg2l-gpt: Reinitialize cache value
Date: Mon, 15 Sep 2025 17:36:30 +0100
Message-ID: <20250915163637.3572-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915163637.3572-1-biju.das.jz@bp.renesas.com>
References: <20250915163637.3572-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Reinitialize the cache value to 0 during disable().

Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 360c8bf3b190..b2452e50d618 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -190,8 +190,10 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 	/* Stop count, Output low on GTIOCx pin when counting stops */
 	rzg2l_gpt->channel_enable_count[ch]--;
 
-	if (!rzg2l_gpt->channel_enable_count[ch])
+	if (!rzg2l_gpt->channel_enable_count[ch]) {
 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
+		rzg2l_gpt->period_ticks[ch] = 0;
+	}
 
 	/* Disable pin output */
 	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0);
-- 
2.43.0


