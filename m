Return-Path: <linux-pwm+bounces-7140-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3FCB30DC0
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 06:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1151AAA456E
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Aug 2025 04:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2832580CF;
	Fri, 22 Aug 2025 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHcvRGL0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650A17F4F6;
	Fri, 22 Aug 2025 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838411; cv=none; b=NszrCEOpVF5MaLGiTzPZcs4Kdf9Eb6ZxlxygELoGS7YvQovDPqIyIZg9nFKY+kTVaR1IIOU0aLcMqkDPCuGLK96QWdw8BJg6uWwh4x4rT7tDqNpOkLaqQKqZ/0swFXM3avp36NYJyXN70BdlQnhTH9DXaXiMXZWWSLjVmA9Tvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838411; c=relaxed/simple;
	bh=WpEvVOdRTcvaF4LSv4kVn0QHVVnO+lhQ4DgcdibW3mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQlpVbnHQXB62gT+1ErGAqLinn8fzoobL8Df22chH76SVtwmJtypTMsk+avNO5nb0EGTyN56aBcnjo0aKMKo84LASxv85OVvXm4hz9pCICQk9NcvlN/SLMpYNDgWoMUYx7/2bEm8G06+7xVlmmcQtNJC/AWR+dppf85EIoqBij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHcvRGL0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2463d8a4235so1602675ad.0;
        Thu, 21 Aug 2025 21:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755838409; x=1756443209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkOfY2Vc2mQA4/qf0NhvJ/W8ykcnBxlMav1OYvf5kKc=;
        b=DHcvRGL0rL3/CXlooAyS0L65D2TJoEvYMKLjEYXTuX4a75DgSJIBLaXUMOmDOLDxyh
         qq2fPefrT8JLsEM3u6AReblIR+UWYu1rpvc0XncCoy+1db1BrbFWF2+FmGCeV76pSpdq
         TektAbkpW7x+xRZq7tODEaJeIlEeG9DbzdbQGBmyiTO8O7oH2BfsM2zke1oYdqJuL1Er
         6uoICz8q2X6rF/UYDugU50lJVTyJiD/tjJRz9ko98wL8J8AY4essPoNIZrMJAqOvFcX5
         wDanozpqL0PoqnWqZzJIwq23MEzfHGG+JoAoeZlQfaq8SJFxM1rD10+GJeuAdVWtvbPQ
         5XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755838409; x=1756443209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkOfY2Vc2mQA4/qf0NhvJ/W8ykcnBxlMav1OYvf5kKc=;
        b=wdAxjemTb+RmJS4b3TDBT8tDqtmZW7utwsjT11X9393weWu9uIHwgc6t4QA0tuodRt
         y8wTTrvYgmG/PR9DQQuG4dzJxeJkYCNEMGCKYbqfFVPZnLaFItMxknJo2lw5KdNc12Ri
         FGrfQsjuuOvOE9w0w7DAReUmRdf4TKXaaSoVK0eMS3sURKil1I6RAQ0d1d7PsW85jFGJ
         Xb5ay4uAEOiXxM+7vL6zgdJgIwK4WWSxwYlQU5mPPdFrXoel5cPwXBVPl4j41K1NG142
         ShqFcIHg1AIzjW0qANo8AiTWAySOXxqpEAze9VIAiXwiF3zaA8r2KSVDS62v2sVsF/Fe
         tDiw==
X-Forwarded-Encrypted: i=1; AJvYcCV3KMkctxjUdwSmZwOOiU6HfaGLJdYhscHVnyz7Onw3+xhec8rRpB93vSvbMPT5hwPLmUkbDNCbL8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+VkbZ/bCvU2EciV3YYikHAeMKexlWyHSp5wAyM2RQ5aGfamt
	oARYLrnAtKnDGYAQXcAh0j7Yu4wshbfDwCOIH9DgCZr0mm2yss3P+7lC
X-Gm-Gg: ASbGncvyAFFJUX0JKid/TOzHbgbh8G6stS/h2ucKM3g2EINoUKrmSn5NeNUXPWBZ9xr
	wUSqDkl8wbTkm0VEW+4t0i0lZJS3Qi94PkEfGlcUMBOHgdCKqYxGw6RW+er0/koiPusn145VDii
	6rTsOKVZAH1lrLe0fd7MLLibYzpBCYNAqxTQR5w+T0qbJHvZYrkRmstnRr/sxJbnenSSqn618ya
	CXmhkHHDvcjVCAKb61Nv6WuhzM9PYDXVHgvjDDJSVXCSdaoQ3M9cn2UU1sVPHee+l7tnmH6wlTf
	bRScRV45yuao4u2tPYnxtBLYkmHSwi/yHlPf4/gJ5Ks2r3ZNP3gl2EYys4YKb5syvmkDPevAkH9
	mltfXwj6+fVxiUU5H94fbtCDspb8kLzlNdbFlofRKyEVtyak=
X-Google-Smtp-Source: AGHT+IEaCyaG1Ji7jaAOLne9b6lBfbfYTNKKXnUdPEF8NB5oS/DCActGE8hW4Okwt/Qxd9RV4fQcrw==
X-Received: by 2002:a17:902:e54b:b0:234:ba37:879e with SMTP id d9443c01a7336-2462ef1f310mr23899795ad.38.1755838408997;
        Thu, 21 Aug 2025 21:53:28 -0700 (PDT)
Received: from paradiselost.local (lohr.com.br. [187.58.145.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640d0be0sm6140074a12.51.2025.08.21.21.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:53:28 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v5 6/6] pwm: tiehrpwm: tidy prescale calculation style
Date: Fri, 22 Aug 2025 01:52:23 -0300
Message-ID: <20250822045223.4150-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822045005.4127-1-rafael.v.volkmer@gmail.com>
References: <20250822045005.4127-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy ehrpwm_pwm_config(): drop redundant parentheses, keep the condition
on a single line, and add spacing around the division operator to follow
kernel style.

This change addresses a style warning reported by checkpatch.pl.
No functional change intended.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index a801912be..35c7ee801 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -277,8 +277,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * same period register for multiple channels.
 	 */
 	for (i = 0; i < NUM_PWM_CHANNEL; i++) {
-		if (pc->period_cycles[i] &&
-				(pc->period_cycles[i] != period_cycles)) {
+		if (pc->period_cycles[i] && pc->period_cycles[i] != period_cycles) {
 			/*
 			 * Allow channel to reconfigure period if no other
 			 * channels being configured.
@@ -296,7 +295,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pc->period_cycles[pwm->hwpwm] = period_cycles;
 
 	/* Configure clock prescaler to support Low frequency PWM wave */
-	if (set_prescale_div(period_cycles/PERIOD_MAX, &ps_divval,
+	if (set_prescale_div(period_cycles / PERIOD_MAX, &ps_divval,
 			     &tb_divval)) {
 		dev_err(pwmchip_parent(chip), "Unsupported values\n");
 		return -EINVAL;
-- 
2.43.0


