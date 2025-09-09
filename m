Return-Path: <linux-pwm+bounces-7267-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BF4B4A726
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 11:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596E91889DD7
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 09:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F562285CB8;
	Tue,  9 Sep 2025 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXOd/Vm5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB22848AE;
	Tue,  9 Sep 2025 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409154; cv=none; b=kwa6u93jLyipDw0uswEhfH6d8QuqmPsio/KUwvP+SzCyBB/qTTZtxTXLxV0RZT6V1ouQ+jN3xFCMwNXmUXBwpXolHs5xTJW35Hfs/Cwe0iCZ4mzHFrdDgCKFuumN2Eg1R+JqjpTU3ZfOn6mewb2X1J0B/wPp0eVvkyG5PIEcOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409154; c=relaxed/simple;
	bh=y9JZrm8tIcRZ9JVtlSAMrlETTLvViBZDGzvrcKR1DeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hn5KqTbc/QtbR4nuf1683A3916BhLZneIb39jNFAuhK2KvOFI/qXvWF2OVq62rbfe02GFTvwIPRGlKsO90THHanJHXgUeKn1EGRe/owMWIBxizs78LOgNwRaUCvqB6TIxS3ZZYPwF90cOdI07EzqV1jGBMGTTL2xqF8l9yfQFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXOd/Vm5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dde353b47so12880075e9.3;
        Tue, 09 Sep 2025 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409151; x=1758013951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVOEX74tnreBnaykRzqi2drA67bwX+67ZDQEDOH6i6I=;
        b=IXOd/Vm5Tmvgo04wzTLapZf2NupAlMXekOujbj8PrO7zcLwy5tmeFnHn9F/Fr9QppS
         h3Ef8fDJtioHiD6x4FY6ByTUgpy/dZ7Skn081WQpMTX1prqI7Gw/3PdiX5ySi2LVHh6E
         vBlsdG5vi5a7shX7+binWAR8nwwUjf1kurt5LsWtwSdaUjQ6tOANbXMqKtubHEVTdbbS
         FcS+wZSi9525Hq/2amD3zd5MdORtRO6toLuPnqEuvUZ5mWtZukTCwbkXRXJ6W3hpIrZW
         W5M8h3gUcciRnkImJ87IT6ShE7N1l8in1oL2uUAaF5GvWpJ2BCJ3x8aCQQxtSTNX7xjH
         VLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409151; x=1758013951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVOEX74tnreBnaykRzqi2drA67bwX+67ZDQEDOH6i6I=;
        b=AuuO9ntotssIoejtVTvA+rvLkVsi6nPgLW4D3Z2xtDrJBdRas31OQF1OHQj4ZRIW+3
         NVAXGJjFODsgrKnhbxj4ye6VBGF4xyadBVPsf0fuTxm8SmslPcvpBqeUocN6/huVaC/0
         F9tLkuMSRQ2L0bFbSHaVpNR0HkmQsybrCRxgG9Ra3SRVv2m/q7eZR4dP7CcMqIkDfxLt
         WYbxfcX2K4w0aGt8DBTFvrZcoQ5u1NZ0l/P65e53HdA3HBXKdazsDo4kYFp0Q0aNM3ls
         mD/zce+8k53BxERoH24JPGsHp4G8dM5EVZj2OwsRh/Gq5zP6n+0iyA8DX5EwqICcltr3
         U9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqoowstf5mhsyyHVuoIPvtSj0BYybHZ74xfPhVDXaK8MncOYwr9w4R9e1mjzJRdAA21yTYItQ3SGq8@vger.kernel.org, AJvYcCVbPMr+4eAebW1gsz+LjIGOXdbGp6cYYqLpMRr6L5sdCwqEPwm42h2Uq2c3jw4t7410SXjjJiDCLsBIEGVURpSt/TM=@vger.kernel.org, AJvYcCXbspjM/WMiU7+ain0/vPeLKTEy2UR7usXBHrpkdrtmj9PHkH+PzMjTFvB2JFq3/Bh3r3alpyAx/Z+WvdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkkRPF8GTLG3ctY4fk4sUT0GXdtSwlQXt/ycb+nLmLyX3Vaop
	ZVcWLHxtrbqXhCvZ2n+4L4gGt0HBMqDV+0/R3JCA+iD5BzQwGIx7n5Oo
X-Gm-Gg: ASbGncsi3BqtrMQcqUwa3ImWMRu/Yy0SImpdYafXoOwfWa/So3D3mwlys7Z1gcge3hY
	0rwG0/v1YkVvmWGMccf8Fse8XdB5Gb4gOMHi27MT47JCPrGkCCmoaxuKl32QKtkXuqGMTEY8hje
	g9qiJ81Dj1EHGEOTjJ+gHcWm48KqbpBfgBjB4C+pTG2NkWvPErYnUb8P/4+xoXgUL18A/NYUlYr
	MDm9eqxmv/1xGmPWYl8oqh2RXv1gpeGVj+V0NOEpxWbNdKWlTwnSHEQsYnL3GhAtJHh3w6V8wHi
	r16UFAkEm1cI4UTLQv/khck3nGXfLrDbethh21bzK8Yn5nlQgMKbDo2pM0UcFEYsW5qWNDWc/lh
	xD3gL/pz14Jy/GCLoTt1OC9dKfPrzMTUUXl6Wgpv7nesl+RLHBxLXMkszkf7UHnIvNGhXaEDLfd
	8BhA==
X-Google-Smtp-Source: AGHT+IEfKiWxTePbisd5TlWR9/PYfWteDlSE32j168hYuDq0/dkpve1nMZMyvsJRrtlIYSrhK4OFLQ==
X-Received: by 2002:a05:600c:4fcd:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-45dddee3ae6mr106356895e9.33.1757409150547;
        Tue, 09 Sep 2025 02:12:30 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45deff68b43sm6975685e9.2.2025.09.09.02.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:12:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v2 5/8] pwm: rzg2l-gpt: Add calculate_prescale() callback to struct rzg2l_gpt_info
Date: Tue,  9 Sep 2025 10:12:15 +0100
Message-ID: <20250909091225.128658-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091225.128658-1-biju.das.jz@bp.renesas.com>
References: <20250909091225.128658-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

RZ/G2L GPT the prescale factors are continuous power of 4 whereas on RZ/G3E
it is power of 2 but discontinuous. Add calculate_prescale() callback to
struct rzg2l_gpt_info for handling this difference.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 74bb0cca4ab4..b247a6c181d5 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -90,6 +90,7 @@
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
 struct rzg2l_gpt_info {
+	u8 (*calculate_prescale)(u64 period);
 	u32 gtcr_tpcs_mask;
 	u8 prescale_pow_of_two_mult_factor;
 };
@@ -138,8 +139,7 @@ static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 clr,
 			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
 }
 
-static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
-				       u64 period_ticks)
+static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 {
 	u32 prescaled_period_ticks;
 	u8 prescale;
@@ -292,7 +292,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 			period_ticks = rzg2l_gpt->period_ticks[ch];
 	}
 
-	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
+	wfhw->prescale = info->calculate_prescale(period_ticks);
 	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtpr = pv;
 	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
@@ -482,6 +482,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 }
 
 static const struct rzg2l_gpt_info rzg2l_data = {
+	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs_mask = GENMASK(26, 24),
 	.prescale_pow_of_two_mult_factor = 2,
 };
-- 
2.43.0


