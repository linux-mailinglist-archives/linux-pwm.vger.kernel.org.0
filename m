Return-Path: <linux-pwm+bounces-7678-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F679C7E96D
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 00:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D583A3C62
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 23:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEF71CEADB;
	Sun, 23 Nov 2025 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKprNwRz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F42433A6
	for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940048; cv=none; b=T6CgQsiyfhSpPWCXYoUmsxldmHR6ieEk8Y6O4c6jqMOWbXLqG7ZFsCt6+kQHS9l3QBrWg5tHs7ddacxRUvvyaIurPEXhkoZYWu73yJ6tMcYE6l3tw6ylV+Uhjwzz56bht9BtCiGAuxmJdD0vnV+SYZomj23++KwQzez6L8dlCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940048; c=relaxed/simple;
	bh=xaJdGOxZwQbmd/3sFv7tXun3GyBTMALpFw0DP1oE9Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cQ61iTbAOkBIQNkuDhkS3Fw3nFciJcio9PDiLh42cQyN4XJAaj5hQusmhCkKNHW81gZfrERlG3Gr7JnMvSIQ/E27aFWDGmvlpAtRuMvcc0J0XlGFt5zo5pmUeXRL7fVDImiLfA2SJ9uZVNAg+okU5flb35QEXRBqStBXFTuGThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKprNwRz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bd610f4425fso2211404a12.3
        for <linux-pwm@vger.kernel.org>; Sun, 23 Nov 2025 15:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940046; x=1764544846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=preeNQRiaiYRILj3awlQujcrqPrONXF4RSuZ6TJLDVg=;
        b=XKprNwRzsYzQQVjj9DUdTq77/gOWpFPnD3CnLQKUynKgg6C/vY8u/0qkbC1rsQq6GN
         Sz/vB03P2TvW7NvHCNe97mfzLvRCLQTmi6/nful0fqdHU7+Hb+4XqDhfdn7SWY0ugD4V
         Sb1pAiDTTzGHVzNRG83j3O4ddZOw67VQaCQB1oFj7lChJsQ9eukn6eIaSnSbcxI9cMzs
         w/bDC8993xpvDGzcwzXJPz5MUbwaF6in6FCfwi8z0xi80hJMujoXy/tH5j9cjTk6kjEG
         FTKpH/guV8TLzz85T+aAW4w6GGJOL/Ilnm9HD4UbbpOL0Szt4Ee61afKw5I/NIpWIBSD
         tLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940046; x=1764544846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=preeNQRiaiYRILj3awlQujcrqPrONXF4RSuZ6TJLDVg=;
        b=Kpm3t4y9KQTaZINWAJblPufK5snfQHVNeoRyGCl/w5PwkgMXEbtytK3BCt+jQ4zMjh
         j9PmlDPkn1u6BBnU7tco0PtjShXNvnVTst+HhyqiC6qBztRiStgSin+7jixG6mNqWGzS
         Hii3gdd1f2zTAaE5apDpHF4EN32XxArkk1w9+hwBqYo+OHUsnH4CtBrgbP7QZTwKAH0C
         vEqvfy7AsRxHZ5VN0Nm3/cJGl3/FtZXvG2/Y6c2nE34d/lCEox2Cx3IWmr7lwuYfCHNL
         M23XgueGGzGtTOdtVPIBuCqHAiutMhK0zznLhOTtu7wahQfwUVZPfvm5ds81AJBBbZQK
         CnWw==
X-Forwarded-Encrypted: i=1; AJvYcCV4c4zaaHxHpVt+L/43++riF7dPlVBY4TxLxfT83ek+6haqdpHSgnqiRzo7o+uIiOam+LobcuB0WrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlxtvhTKabtx8Phw059y301BGqm3nczIasni1gyLZckPZ4EPx
	4ZaKKpO7ApFrXBobW7Czh/WCxMBTESz40RrU6KHVyZ91AVvaFZTmMROQ2OaX7Q==
X-Gm-Gg: ASbGncvcQfV9z7nqAt2gxSX+eEb76vVrnKbrALUih0pU8O6nQiEpCtFcpuOKjvGqf85
	QON7Bf/KnlBz1nJNJPIkbsYTXzGqQCDwE4v1YxsLocp9txO/HaN+WXAM17mL/qpI++yfRWDf4RA
	kx4gdMnLVZvYMKr55M9yhul35Bzf7QgqJWFj/KlJMPSAx2xFLEgSVQK4te4xILxV7lguOEv5BIm
	zq3pSWTvcHQW8euSgYOe5yzWOH3EoIT4E4OElPTEOmPldWjzhVP6InjYr1rMRk3ZijiXZJcsliZ
	/hNHLW1PpVIuJuza8aDQdYS38GvlH21uM0ITtSWygkri6AmxYcEZa+htAVAhcxwoKdUXWVWwtkP
	NdDgd0SHloKc37HIN3dLbibp9rWfbxHipddIvtQPcRpuPFKafqk+aNAhh5fDFAjgUIIm1Yrmrwg
	Z6CQ1CocJFK1nMA+B0QOu7Ig1SUz11H53PP8m4u43My8A=
X-Google-Smtp-Source: AGHT+IFw/h0l45wGhCgMsYktelV7eLB7xYE2yczK0u2hcXxOTQdRVWxhULIDUSIJtC48uiXrot8qtw==
X-Received: by 2002:a05:7300:cf84:b0:2a4:3592:c600 with SMTP id 5a478bee46e88-2a719133d15mr4280201eec.17.1763940045740;
        Sun, 23 Nov 2025 15:20:45 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm65585124eec.2.2025.11.23.15.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:20:45 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v6 0/6] pwm: tiehrpwm: add .get_state and tidy register handling
Date: Sun, 23 Nov 2025 20:20:27 -0300
Message-ID: <20251123232029.1956-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 11:57:44 +0200, Uwe Kleine-König wrote:
> FTR: I applied my series now and it should appear in next on Monday. So
> going forward should have become a tad easier for you.

Hi Uwe,

This v6 is rebased on top of your recent tiehrpwm series in pwm/for-next,
so all of your fixes (including the prescaler corner case and AQCTL cleanups)
are kept as-is and this series only builds on that behaviour.

The only places where there is some unavoidable "policy" are .get_state()
and the probe-time handling of channels that firmware might have left
running. Both follow the same semantics that the driver already used:
a channel is considered enabled if AQCTL is non-zero and not software-
forced in AQCSFRC, and disabled otherwise. At probe we take a best-effort
snapshot of AQCTL(A/B) and AQCSFRC before touching clocks or runtime PM;
if the block is power-gated or the clock is off these registers read as
0 and we deliberately interpret that as "not configured / disabled" to
avoid inventing state that the hardware doesnt expose.

For channels that look active at probe, we only bring tbclk and runtime PM
usage into line with what is already programmed in hardware; we dont
introduce any additional permanent bias beyond reflecting that observed
state.

Best regards,
Rafael V. Volkmer

Rafael .V Volkmer (6):
  pwm: tiehrpwm: use GENMASK() and FIELD_PREP() for register fields
  pwm: tiehrpwm: use GENMASK() and FIELD_PREP() for prescalers
  pwm: tiehrpwm: refactor AQCTL polarity macros
  pwm: tiehrpwm: implement .get_state callback
  pwm: tiehrpwm: handle already-running channels at probe
  pwm: tiehrpwm: tidy period conflict check

 drivers/pwm/pwm-tiehrpwm.c | 332 ++++++++++++++++++++++++++++---------
 1 file changed, 258 insertions(+), 74 deletions(-)

-- 
2.43.0


