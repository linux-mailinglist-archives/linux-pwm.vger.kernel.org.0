Return-Path: <linux-pwm+bounces-5586-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA6A9455E
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805BE3B6A8C
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 20:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD1191F7F;
	Sat, 19 Apr 2025 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZPpUGVK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5A172BD5;
	Sat, 19 Apr 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745092888; cv=none; b=ByU1qeN1G12ktju8W9gOzoOi3LeV2mNKUVkhe6rBKY5+yFeo3zbzNkYEgmbJ7P1JjGRNELa9a88d1q9if9RauOuTNJyDYIsz6hR5smNpiBu35dV0d62EC0MQzGdJEVo5RlZkr2+P+FibX4SC8N0nSvwMAolqQojg3YmTMr60JyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745092888; c=relaxed/simple;
	bh=P7tKjMmYvpQSt19eVgoXK1B4GJT2SFBF4f5fjdv6Abs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS0+3xzmpEsteaJK07SaM6YjfLpT7C+MoB2qw09TYmtcewLV0ZJ+9Rvdt0skTpXCnXnD6GIgHI8PD54ZuUNSKSwCzt/w1rgFcRd/qSzxezDdn7zT5GOd+D0QBE17KPBaflICcE4gxVw3bsO54nmhlqZtFAmr+7e3gXtWHovSQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZPpUGVK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7369ce5d323so2283165b3a.1;
        Sat, 19 Apr 2025 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745092886; x=1745697686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78bfCOlyaAzjSSC4kz49Ccuuh1pGQY6kRFiTtIDnJb8=;
        b=HZPpUGVKT/Sfel7fmJ0dLZjTYUEA3UbR5Fc9t4XHGr2A/dHcBLIlXBx3jFkpA9eAZI
         C9JIdsNRfBR6msv9KuBOFuFDlqnp3Ac+kh6KtrcchGt8/XtJO/39WeSRCbha4dqg46jD
         GPyWLmRKAenZ/4htdB2C9d1eOJmygd4GIVYXDNa4vjwZoVL5DW4d2IRWmMmNz1F6VLNN
         uON44zNp/uETZsrxrXZQw+L6SP0ZhL4R3lILRtwyh2hO3Djcb2atRtWA+ZuK21TH0AcX
         ojYzGFX/Zan1BMlyazlA29/y7SLZY+Esi1orG/k3CMEbPTkPlzZG+qCoEVwIp/Z0DP5x
         dEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745092886; x=1745697686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78bfCOlyaAzjSSC4kz49Ccuuh1pGQY6kRFiTtIDnJb8=;
        b=pbIBmJPkjT16v/rhCgLW1e3bvcTwYPHwvFJ9fFa6fxdkTM0VlzSUwatoTsOzZuKEj2
         XHquL3sAYijiNe0rnkrMyp1utwF+Hv9sb+oX79gLXGu5H9D7jGO9oFO8haKxRriUvI+u
         nlkQklZ7LD7f6pCYC0EKhmRi7p56A2IppHUAGYFqHvuV2T1XnbAKqqYb0sA7IM06B4SM
         7Sis2+46dWKikau3uwO+QVWGmeRfISas1+tuZaXkcKoyCl8CzIUprTsVaBoeeIGRSu7k
         KIrY5qGeM2608uXTI+c551FqHxTqrAaNGjmApgL0ejU1Ut8fv8QraZDa0nMKNpJLePtU
         0jSg==
X-Forwarded-Encrypted: i=1; AJvYcCXcBd8NbtQn0ZxQI1ANaH1wSKuUXnjV5uN2lO2M9A6mo1tzoer5ADO9b39CBICGC+MflZVhgyu1khY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vm7Ui/6TyP90GHMM1u8Exd/o38ifR9TBAm9nrbdl9str/cdY
	VsYKu1usFQr1Emfxr/Uze0xmAqGfUPBq0h0A8Q5JAnKFB6DIY0x7
X-Gm-Gg: ASbGncuP3Ara+WjsI9WoVo+wMwKTqtWhM81zNzGmBmT++c/cuIhyuIOS8bRVk1hmvzB
	ecegVefrRuPZRojm0rQHP0sctJ1z2yfXW1m/37st5uX+IhyoQS3Zo1dEYWRj8hLELw5xMXfceBk
	VmsE01uS6KdRqPh9afk+YNZeYOUG9ckizzJyBPPw4U+d5GL//GzKrysZT/KlAmnPRvCU8EsCDTL
	1JxMKUTwahIp/73DKc0hY2sgKQNnLBxSW0cUce0AtrFGHME5grXUhxAMgYaRlOJHCYxEOrbN4h0
	NktK5MuDi5Wq87L1TUUmH4OQk7EVTHJtvcZ4d6atbug0SPU3ONdHU3pdMz6klPX+RWRvCv4=
X-Google-Smtp-Source: AGHT+IHHU3SG+U7iWICQGUwnRv6OZNIxtm1vAVch1HaAzoMdI8hi6JU7nF5iLgmeQesqOUWhTh/7fA==
X-Received: by 2002:a05:6a00:3d02:b0:736:4e0a:7e82 with SMTP id d2e1a72fcca58-73dc1480119mr8028833b3a.10.1745092886146;
        Sat, 19 Apr 2025 13:01:26 -0700 (PDT)
Received: from localhost.localdomain ([177.10.12.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaaba76sm3778426b3a.143.2025.04.19.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 13:01:25 -0700 (PDT)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: rafael.v.volkmer@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	ukleinek@kernel.org
Subject: [PATCH v4 4/4] pwm: tiehrpwm: drop unnecessary parentheses and fix spacing
Date: Sat, 19 Apr 2025 17:01:00 -0300
Message-Id: <20250419200100.79140-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250419195830.79053-1-rafael.v.volkmer@gmail.com>
References: <20250419195830.79053-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The comparison in pwm-tiehrpwm.c triggered “UNNECESSARY_PARENTHESES” and
“PARENTHESIS_ALIGNMENT” when wrapping the second clause in extra parens.
This removes superfluous parentheses, aligns continued lines under the ‘if’,
and ensures operators are properly spaced.

Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 23530d53e177..73c3dd57a50b 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -285,8 +285,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * same period register for multiple channels.
 	 */
 	for (i = 0; i < NUM_PWM_CHANNEL; i++) {
-		if (pc->period_cycles[i] &&
-				(pc->period_cycles[i] != period_cycles)) {
+		if (pc->period_cycles[i] && pc->period_cycles[i] != period_cycles) {
 			/*
 			 * Allow channel to reconfigure period if no other
 			 * channels being configured.
@@ -304,7 +303,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pc->period_cycles[pwm->hwpwm] = period_cycles;
 
 	/* Configure clock prescaler to support Low frequency PWM wave */
-	if (set_prescale_div(period_cycles/PERIOD_MAX, &ps_divval,
+	if (set_prescale_div(period_cycles / PERIOD_MAX, &ps_divval,
 			     &tb_divval)) {
 		dev_err(pwmchip_parent(chip), "Unsupported values\n");
 		return -EINVAL;
-- 
2.25.1


