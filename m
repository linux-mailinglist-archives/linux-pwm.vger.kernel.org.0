Return-Path: <linux-pwm+bounces-5612-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD822A94EEC
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F99A16FE6D
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D6258CD9;
	Mon, 21 Apr 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EJ4zcCi/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1D25A35D
	for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228654; cv=none; b=d8Tx0Fgzs+SwtYCEckfM0S5rADBcsj15Ee/keY9yMa+OEMvgP+gDedWhlIMoSBo21uzkDdafnOf9qrOmnj1B0Wl4EHYyrWLMLKyXhx6NoBglu9v4j07HUNN9JIN8sMBkZUlfWnEFY4G1WkixjpfKeCynY6WnD3UqeX7fou/8k0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228654; c=relaxed/simple;
	bh=HTZHrX+QD3w1gIgaVzbbMlu+aTdm2k5g1RRT3+WvqSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9u4Dk2GkauXC5d3c4/5yR6QQLNqLvHaxjYn0Qg/AgBgAxBFDP2ZDZ3ZEbnlsMNPm59MZ2mSOX15fZiUWy/I4MzGcL82aDO28K/SDu89EG7LT4Xf8V1Rj8RH2VzX7uClaHTJwFoqXqzUB8PlW98dtebVh606FqFo7IagmYq3prs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EJ4zcCi/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736c062b1f5so2903958b3a.0
        for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745228651; x=1745833451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um8ly0YURJhIZsPOAVFkm7bN0ZzL1kP1o400anZrFdg=;
        b=EJ4zcCi//X7Ayhw1v3BBrs2xC2RExi9KrekolRcnhJQSQhZySbiZCayZX4EbiVqegC
         iFPYJvU93JsLVQBc7AcQ+ipB3Tzhf12p9HshL9SPwiZPIP051f4yDmP3tk11Fprjjcfv
         9v+/v4koqNoH0BrnbI8ovkJEjuTLwIG8YFOQh2sYiQTVunZ/Po1JNxJQiuX/VkqYw/ZP
         gYmWhJO3OAzzjM3O1xiGvstc2ZG1dgSyxiPPwWEY5ouomDRBJSEQ3ABQQeEMBTGxwstZ
         SBYibUf58MKAL2RchK8ZptNV8N9KYsmRYAfXBZoLpP/ZdTfTHh9sFMy4qvtGTlc5sJ9f
         8ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745228651; x=1745833451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Um8ly0YURJhIZsPOAVFkm7bN0ZzL1kP1o400anZrFdg=;
        b=toHl5eemerIphPEAyReGN3o9153Vzz8n5KJfVWxOpJhQFaqquw34cnnaltB3uu3yKh
         GqcZSg5P3VOuCyeWrvDFRPX8E3Jv2DeNaQ3peNowVZtB1Ol/A412ycREF+GRk5JOoVuC
         LehfByFTauGY6mfjYlGUNIan77fe7sylt3nuMjWzeZ2pR9Ge4v5G2px/sIKIGb7T5rt5
         RbewFB+IU0Bm3/LVprC0/nKc2mTb6o2PHfKnuf61EAHhwomjkA2T7HbzDKqxCDzBCFQO
         GvCz3/d+gAto3i6gcNw7xhLQHm2ezsKcE3L3dnLiUuggGDlxmX112IFI4PzyHUierZyV
         adig==
X-Forwarded-Encrypted: i=1; AJvYcCWFDioFniwc+SbXulg/wzbTppbYfU6eUYWoxGhSEYppJQdGG7Zy0+2fqK6MNrepv8v8u6HtJK30J+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidnuupaRyOl7XBcjTdKfbvrc1RJBgSauoLOOPs71Ej9VhevHs
	xeQUjyVuD0eu1HKN0aJWXq2vJdJ6QawvC/4RY00qf+XgMoU9QB+HUI+dEOpjaB8=
X-Gm-Gg: ASbGncuMkqbKfKq+YmQGJnQp/XZiDbf0xOjtORUDLTgMolI6NfgEWZVhyvkhDwsVpY3
	yjme4bvHk1r8+23V27P2ZzWCqY6Hf2jYiZuEZNiQhaB5ISXcjCrnuwbI2ze8wPVbtdr1036QA3U
	kbzUux5LOkS0bqz0WGtw9oVD6UJgZv430BAHgmFDdEqbV+32mCSGldR+m7GRjelS6XryDdS1OcM
	oiHXagbwbMvx44UYUDaDgtWnN5xqUVJt3tJVwp0VzZjNqiouEupHzvWSs/ZULV/8xElyci59JIq
	HSjOyoqvjaqKdaXHx6H43WowU1tY388VPZdlpaRtqP5jTmFmrgjRVZEoQV9lsctddEJBkUPeVbi
	Xbw==
X-Google-Smtp-Source: AGHT+IGhB4JLMo8xKvJ4+oFdsJWwteHF/WDSaTr6oGU66k5hwiWHHJcvohJuF1VquOrooltC9l1OFg==
X-Received: by 2002:a05:6a21:9203:b0:1f5:86c6:5747 with SMTP id adf61e73a8af0-203cbd153c5mr21074579637.32.1745228651586;
        Mon, 21 Apr 2025 02:44:11 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaacf32sm6371965b3a.142.2025.04.21.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 02:44:11 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v11 4/5] pwm: sifive: Fix rounding issues in apply and get_state functions
Date: Mon, 21 Apr 2025 17:55:20 +0800
Message-Id: <20250421095521.1500427-5-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250421095521.1500427-1-nylon.chen@sifive.com>
References: <20250421095521.1500427-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix PWM apply and get_state rounding to ensure consistency between
setting and reading values

This fixes the reported errors:
pwm-sifive 10021000.pwm: .apply is supposed to round down
duty_cycle (requested: 360/504000, applied: 361/504124)
pwm-sifive 10021000.pwm: .apply is supposed to round down
period (requested: 504000, applied: 504124)

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 6259f8500f71..1404c383461d 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -122,8 +122,8 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		state->enabled = false;
 
 	state->period = ddata->real_period;
-	state->duty_cycle =
-		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)duty * ddata->real_period,
+					     (1U << PWM_SIFIVE_CMPWIDTH));
 	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
@@ -157,7 +157,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * consecutively
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
-	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
+	frac = num / state->period;
 	/* The hardware cannot generate a 0% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
 	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
-- 
2.34.1


