Return-Path: <linux-pwm+bounces-5608-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C7CA94EE0
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D67A4E32
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C30D258CC4;
	Mon, 21 Apr 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vq5yVSZJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A52135AD
	for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228638; cv=none; b=dHj0XxJjgczSpFA+1RJo9ScqDs/OmruzEtt5QrvBsG11UVQ0VG85H7wHNtV3gPQ5fRCroK5AD9Ur8OpvSXGCeB+xflZqenwKrWs10DG7r92BarFGhKomPt3ZWerRoIsWBre5d2oGCp/KIBVteIisHaMspwSatGMChjmKaTFHHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228638; c=relaxed/simple;
	bh=2SSnYwvp2/HqoQaObtoLHJiNHWC40LdDSI85C5X007o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ecNbXKdHKx/sM1V47MPh0+l7+ec48u0O/yDuHo1H+1WSqzq8cFO879svFbyq4Va0PgnMCZ2YHSfclAe/SUPnj9wmQIrZWbAtvTkGRhe6+VORX8oau+qDp9eT8qpUmIDUDq9nGlk3Zo5xxPi73HeBMlLG5tKpUqAmKf3+N+2yK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Vq5yVSZJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-739525d4e12so3036785b3a.3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Apr 2025 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745228635; x=1745833435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8r8PRZBSMwqOsQQkiAo5Ug34CtBtLjSR9VzLdpS8hc=;
        b=Vq5yVSZJzYtm5Smzm/SCMvkJgx69rskdPGLmo/lWbsM9Gtb6TH6kT+MUS8x5f5dY8O
         3hYCmh/v7SFsFf0QMATH+ZuYB1yHlBxql63MK2XbgSpm0LOdkSqBxs/9J2grRD1haNvE
         RU4LzN0x6j4nW+rTn7KLC546VtR5EXy02FWS5DOYfe2PMSMkbxt9uWQBtymSmvhbXfeX
         7Nya/GilaO2QM/+1d6ck9O8CzLxQpvjTQZgB//EuuDX2m4DAEf0Q6X+urwEfGNDkbCdA
         cTauE7UUXesUam4uX4HKASQLABA20gkE8heo28Hd5Z4lBnXRgVotMLZAAbTmFEuxaKZD
         eg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745228635; x=1745833435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8r8PRZBSMwqOsQQkiAo5Ug34CtBtLjSR9VzLdpS8hc=;
        b=FNy5E93A7aKlXwsSWWaoxoAxLx9+Nj3Yw9QLTwfPkyVyZGpsjKaPGMEvjB8PzhOQK0
         IPnfDZH/VTxsTiMNXOFlQQcy4TZCTLGASTBScqabtW+c99u2vc/wQnWjAldsTjEaAEzo
         ybd1ZolaSylwPzKt+kPiaJmBSueaF2mpn1qcGBMcE91jhu/ma9Y0NFI+J1HlvJMamQxN
         Y2JDVWPqyC0n6mAgkjEeWblLm3zbejGdcNQeFRGyyPizv9M6k2EPJNa3XHu8V+HnB7iQ
         P84bKFT3vGeHevn//UeUtw4cZWpfPlgHovMJg7W/IYXRJGcg8pk1bAU5jGo5KtK3kwoL
         URfw==
X-Forwarded-Encrypted: i=1; AJvYcCVKETt2BulZ2IeZZlxwOneB0crOzmwBvhIDPaNFluo6XSiPc3asqsA/h0h7slUa1g9C/4PuN6aMDuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOsAcQmvpJTwCnHxyNflKEF/062IDU0jAxUX6puyQScy/cvDWN
	bYzoZK51WiuBWqD6C2JJ121L4FyJopEasOX+eHbz9im47SiamJ71ZB0OUS+RJBA=
X-Gm-Gg: ASbGnctMP1o27eatu92a5CDVxzmlC8UdzBRAenreIztqxxtvupcMl2T9ga086UNVyzt
	bFrs0rbkldLC4xQa0CanghmDyYjWpKqe53RkaS9/uMc+Yy/lHGtqQvCi3n20xS9t2Lndc6tWX8s
	aUC+B/J1tJqjE99QotUnLMvFdqU69SF9rv8evRWjZGozy6XBxPjaTHAneqWdmHsC9rbxAFT9YqO
	3BsRuJJaEbJpCR7jVpvJ2OdjrTYsfuk2un435oqV5LZlbAbcc6R7scfFa7pYfYb7epMzPpwanzh
	IZ8Unc492/2SG9u5q7rkWov1oV5XDghj2sHHp2tmyvcUuaXAH2MafkvvGThhwbgfku9oYoeFFql
	tRg==
X-Google-Smtp-Source: AGHT+IGhhm/9RykTH/OsZ/BlA/Y/U3CBjIrgF60WUexTWjWufmCT5/ANaQZOPSEaVkm2xDGoxKPQAQ==
X-Received: by 2002:a05:6a00:3988:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-73dc15cfce7mr14584741b3a.23.1745228634697;
        Mon, 21 Apr 2025 02:43:54 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaacf32sm6371965b3a.142.2025.04.21.02.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 02:43:54 -0700 (PDT)
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
	Nylon Chen <nylon.chen@sifive.com>
Subject: [PATCH v11 0/5] Change PWM-controlled LED pin active mode and algorithm
Date: Mon, 21 Apr 2025 17:55:16 +0800
Message-Id: <20250421095521.1500427-1-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the circuit diagram of User LEDs - RGB described in the
manual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].

The behavior of PWM is acitve-high.

According to the descriptionof PWM for pwmcmp in SiFive FU740-C000 Manual[2].

The pwm algorithm is (PW) pulse active time  = (D) duty * (T) period.
The `frac` variable is pulse "inactive" time so we need to invert it.

So this patchset removes active-low in DTS and adds reverse logic to the driver.

Links:
- [0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
- [1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
- [2]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Updated patches: 0
New patches: 2
Unchanged patches: 3

Changed in v11:
 - Fix rounding consistency in apply() and get_state()
 - Add code comments to help clarify Reference Manual errors.

Changed in v10:
 - Add 'inactive' variable in apply() to match pwm_sifive_get_state()
   style
 - Update comment about hardware limitation - it cannot generate 0% duty
   cycle rather than 100% duty cycle

Changed in v9:
 - Fix commit message to adhere to 75 columns rule.
 - Update commit message's subject.
 - Add a variable for inactive logic.

Changed in v8:
 - Fix Signed-off-by and Co-developed-by typo.

Changed in v7:
 - Remove active-low strings from hifive-unleashed-a00.dts file.

Changed in v6:
 - Separate the idempotent test bug fixes into a new patch.
 - Move the reversing the duty before the line checking
   state->enabled.
 - Fix the algorithm and change it to take the minimum value first and
   then reverse it.

Changed in v5:
 - Add the updates to the PWM algorithm based on version 2 back in.
 - Replace div64_ul with DIV_ROUND_UP_ULL to correct the error in the
   period value of the idempotent test in pwm_apply_state_debug.

Changed in v4:
 - Remove previous updates to the PWM algorithm.

Changed in v3:
 - Convert the reference link to standard link.
 - Move the inverted function before taking the minimum value.
 - Change polarity check condition(high and low).
 - Pick the biggest period length possible that is not bigger than the
   requested period.

Changed in v2:
 - Convert the reference link to standard link.
 - Fix typo: s/sifive unmatched:/sifive: unmatched:/.
 - Remove active-low from hifive-unleashed-a00.dts.
 - Include this reference link in the dts and pwm commit messages.

Nylon Chen (5):
  riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
    active-low properties
  pwm: sifive: change the PWM algorithm
  pwm: sifive: Fix the error in the idempotent test within the
    pwm_apply_state_debug function
  pwm: sifive: Fix rounding issues in apply and get_state functions
  pwm: sifive: clarify inverted compare logic in comments

 .../boot/dts/sifive/hifive-unleashed-a00.dts  | 12 ++---
 .../boot/dts/sifive/hifive-unmatched-a00.dts  | 12 ++---
 drivers/pwm/pwm-sifive.c                      | 46 ++++++++++++++-----
 3 files changed, 42 insertions(+), 28 deletions(-)

-- 
2.34.1


