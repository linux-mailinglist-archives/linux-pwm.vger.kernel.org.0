Return-Path: <linux-pwm+bounces-7649-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9742C79A38
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 14:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32D1B35D238
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29734FF56;
	Fri, 21 Nov 2025 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdYQw6ix"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5234FF6B
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732221; cv=none; b=hwiYY1QwU+Nn/CqeKDrTOXLAGChyQpmytb6dMR3GakObxN7sPdFiJrt6B7sGN5EbSBmqtqeolJRHK4Dt1cXTw7OLlu1tw4yl43pV+fQsC9piqRmVf8YsXF73l0sJ3siG0Y0A9I8+L57UaAiABshAyLeMPpjcaYD61MMbl3wTVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732221; c=relaxed/simple;
	bh=bEMBVT3G2HmnOIOq46oKgyqZAayCql6fIOgh/YGLetE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+NR4dFZCbRcw2EG3Gk37vGNsC0iRdGfk/049epmrmGlybNwm/1yRZxTgOEclg2jqAvog2GmACL+lxEWgVHeFDZBBTZ4KNfUgCcFYunidohNFANBzBMhD94WOsbaF4EdpTRskk85RrVh+6xhhCNX7cGbhVSNQLPqNa/tfq3SBjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdYQw6ix; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3720e58eso1624729f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763732218; x=1764337018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hMgD6ft5+aLPLTkR2tqcolD9UWsW68bmbguWMvIeR1U=;
        b=gdYQw6ixcgFL1EH1SgvFQKmOzaje8CSM3M8wz8yo1pRPweyh/YHUuor7XvPjblJznb
         c0vGkPAs1vEqFoRjBRca9h6/Ir/xBlhW6QyhP4OhZtfWzSyw+6oAcRLIvEn4WcinvFa4
         k8o29k1vGKmlb0Zsz44sg4wMqJLxs01eI0YEJvbMKmcWTyWTJ+aZ3EUCV7YBp3D0VrJ9
         gFaOEx6ofsIOzLGnFd0535yfLpLz0uBySzuoJ7fvBbooskwMKju+hZ5NUlxGzPxM300w
         Y6vDpInokwu27nRk1soFqhKzjkyML2hHNEKcswSIOPRF4ayfJuWcjg6X+Aec2KjrZIYR
         Pm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763732218; x=1764337018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMgD6ft5+aLPLTkR2tqcolD9UWsW68bmbguWMvIeR1U=;
        b=NcBCko/az6DMgw7+met1VhdFN9yVBzL3VVUfjrYfOdTGH/uMu+bGrW24SYF8whrwkq
         OKjc26Zwa+0NLJtVpwEohuwf56tiXIicW4rb1wNiOQuKr6wJW5v0PzKy6nOvaCHqumlr
         vlDW5FS+wV7ig9pJ7LanjWC1KUfvnHz+d9p9AaRZbMs3/PorQdwk7n8mbYhL2BZ9oQd0
         4d+w92XSU14nPj5SMw/m6fmcAlYa0K2gWB7TbkHUwLWqKj5fEGwUmlOUKYShphNxgV+j
         SDm5dvMTEqsJbdjRPN7RoIcE2BeZQe90kiyXLZxTEuJKxDVi1Vo617vULEOk0GAU4RZz
         HZWw==
X-Forwarded-Encrypted: i=1; AJvYcCXP5ZQA0ikTJBw9mkCrZsAjMEgsWRo2evJmew87J8MuO59V5PniC83pFF0wGFXsgsg65lyG/E+FpdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvDXFZc3Sg19GqAcHYCl32vHhDFzehra0rDQXS+XXABJZvp8q
	8riClCLpgcQsRGCHRftZqnl/9qWW3DPVBlmjBgJqJh7iYPyeWgp2XrbA
X-Gm-Gg: ASbGncsXf5HGT6m2U2DzpWgkBLeTyCNurnsnsnU23aV5rQNdJJOxugWtq2q7WYB9ony
	EG6YpjM+3GspRD+YpOsx10qSg/dEx1NZHjTAfoCk8bkTiwbD3XLM5m/yDceKlAGmAhmEjMX56A5
	3StxaO59hxxZ58yLCbI6Rgm6hsh/cTZgNhAh35t9sHcOVVNmpZTvOKzkZPBDN8eXqvoQTzVjNxf
	j3XV/ZwJGAtLunwIQOYAmmrvkjoSa/Qe7iJquhiw1M0PA1dNpSgKWoMB2Q9vtCybP037nzSXpeu
	eR5V8GPmnaTCoT6U+mOAy1EzvOIm/TQHx1AFpkscejP34/Xog5ujy71FWrWvpJO9qiLLvWUUt6g
	xSEwAjg3ykIQ4P5IZtda62o+QR72oJuXoOm+n+ftepheu35BbFmdC9N5YAh5PDtrAr6gCQe5moT
	XLphku1VlT9MljrCgY9oPbb9A56FVOI9bAmrcX13ZDxubNj4oDXNoNlMaeHCSimiOm2MF+yhosM
	3P5ILOgtQ==
X-Google-Smtp-Source: AGHT+IGY3oSwcGaW6ZcJ/FNnEG6C+KXeNKIt7CFlJ+YogOFO/waUcioY3eH/f4YCrBuCfqMFQpbz6w==
X-Received: by 2002:a05:6000:601:b0:3eb:c276:a347 with SMTP id ffacd0b85a97d-42cc19f110amr2515574f8f.0.1763732217518;
        Fri, 21 Nov 2025 05:36:57 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fe8sm11158795f8f.15.2025.11.21.05.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:36:57 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH v5] pwm: rzg2l-gpt: Reinitialize the cache value in rzg2l_gpt_disable()
Date: Fri, 21 Nov 2025 13:36:51 +0000
Message-ID: <20251121133654.364688-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The rzg2l_gpt_config() test the rzg2l_gpt->period_tick variable. This
check is not valid, if enabling of a channel happens after disabling all
the channels as it test against the cached value. Therefore, reinitialize
the variable rzg2l_gpt->period_tick to 0 in rzg2l_gpt_disable(), when
all the logical channels of a hardware channel is disabled, and also don't
allow to set the cached value in rzg2l_gpt_config(), if the other channel
is not enabled.

Cc: stable@kernel.org
Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Updated commit description and code comment to give more details on why
   reinitialising the cached value to zero
 * Added a check in rzg2l_gpt_config(), to prevent setting the cached value, if
   the other channel is not enabled.
v3->v4:
 * Split the patch as separate from [1] for easy merging.
 * Updated commit description
 * Added comments about the fix in rzg2l_gpt_disable()
v3:
 * New patch

[1] https://lore.kernel.org/all/20250915163637.3572-1-biju.das.jz@bp.renesas.com/#t
---
 drivers/pwm/pwm-rzg2l-gpt.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 360c8bf3b190..38ad03ded9ce 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -190,8 +190,17 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 	/* Stop count, Output low on GTIOCx pin when counting stops */
 	rzg2l_gpt->channel_enable_count[ch]--;
 
-	if (!rzg2l_gpt->channel_enable_count[ch])
+	if (!rzg2l_gpt->channel_enable_count[ch]) {
 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
+		/*
+		 * The rzg2l_gpt_config() test the rzg2l_gpt->period_tick
+		 * variable. This check is not valid, if enabling of a channel
+		 * happens after disabling all the channels as it test against
+		 * the cached value. Therefore, reinitialize the variable
+		 * rzg2l_gpt->period_tick to 0.
+		 */
+		rzg2l_gpt->period_ticks[ch] = 0;
+	}
 
 	/* Disable pin output */
 	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0);
@@ -271,10 +280,14 @@ static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * in use with different settings.
 	 */
 	if (rzg2l_gpt->channel_request_count[ch] > 1) {
-		if (period_ticks < rzg2l_gpt->period_ticks[ch])
-			return -EBUSY;
-		else
-			period_ticks = rzg2l_gpt->period_ticks[ch];
+		u8 other_sub_ch = sub_ch ? (pwm->hwpwm - 1) : (pwm->hwpwm + 1);
+
+		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, other_sub_ch)) {
+			if (period_ticks < rzg2l_gpt->period_ticks[ch])
+				return -EBUSY;
+			else
+				period_ticks = rzg2l_gpt->period_ticks[ch];
+		}
 	}
 
 	prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
-- 
2.43.0


