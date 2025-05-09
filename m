Return-Path: <linux-pwm+bounces-5866-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B90AB0F57
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F76B1B68258
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DEB28C868;
	Fri,  9 May 2025 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fzsRbbWB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638F289E3F
	for <linux-pwm@vger.kernel.org>; Fri,  9 May 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746783691; cv=none; b=n6ktZffEGK9nMAC2ygTjsEn+ZDAhfGbYKES1C3RNgOGCFiO8f+ryIVlnTvegZKYAAKownCuz00MczvoxoUnOa+FAp+6zS1oE6yTNXuYrUm2CDDlD5S1EF0XT4prpYdDuT+s44kAeE6Bp+UHF/cAUVgfsgdHgDSuiEQZUS3PgxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746783691; c=relaxed/simple;
	bh=/vWV4VzOd8ZFhgbykkxak6+ylyvoqGZrkRbjE+xOVUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=asSOh2rVIVbNlXIZ/clyUyRhlyUfLJcXoq+MAB9VGHn1OxKtnX711bUTP7NEOPUoK1Enj3FdAYHWgQrbTqFZfxsqUEn6F19udgq6yr+4Z0NIggJbEzAkw09ZR87LHHlyowJrzaptdBdIZCBkON4akLoCnEeu+mQmA+od/4HAwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fzsRbbWB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso1981770b3a.2
        for <linux-pwm@vger.kernel.org>; Fri, 09 May 2025 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1746783689; x=1747388489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0rfbYYFv5okSJ9FP6KBkPZgXmzWmufmKqi5XTuFZ00I=;
        b=fzsRbbWBTTMAqz+R5jSTFVrwbvqQJ6B1naHCG0XK4G4UGEd7GKOX9z5WDRqctt79ZB
         wl7TE8WTFA+9NGTHc9ezRk5E2ggEmTlksXb5xYqyFQ2Dna9tviqtPX6itbSZJeiA7efN
         qTaKi1JZyn6mGhGNC0dDG7xZaDlB72p9jGg+pAKlNIdjG6XzwFHZ/3dM7lKj4FfjertQ
         EVVFvGXiM3SOJLkzFBxv6As8vIRYS/y+0mUeNcbmE4tHGeZR6CEOMxL8JbRYsI3YnxBJ
         moL2gv1NKP+4y+7ROPg7Pm7uqvNM2JCfviL+WjUdu6PquZtrmxO25CDX/JWICtJ5x1hL
         5DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783689; x=1747388489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rfbYYFv5okSJ9FP6KBkPZgXmzWmufmKqi5XTuFZ00I=;
        b=OelR07fO9n9+lRzt9eQkSJpctjc2WljB66UytEYihdl8pH52xsz/HRA3ZT+8jHq+o4
         6xXz3f9dCt0vySmAuME3n/hOtOyIde5sfpemRsMx3n6zWopZT3sZDO6dP85omNR32G7C
         6LF4VwrKoE1eAWiml1/jFO4uXAZZ/39LThTWgFoDBr8shotYQet/LCjnX6LzZUI0TB22
         CvPUGBv69qPfxCSzSfOS8OF39jEuGsocEgIRerIj3u2QmgnUzgt6nfDP1PO8qQ56xnn4
         trg/nKK9Uxa18UGIfwCp3/7O8l6qWB9L7EfWWrMGpKQuyT1c4wePAhyJPzaJHxFONDUc
         MfzA==
X-Forwarded-Encrypted: i=1; AJvYcCVpAcOukKANR3qS2i4W0An6iTwfbVWYwNMDI2Uo34ZSRb+0mHnvyq7DIpOpUKP03RXe+vQEFIn+fa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMWS0dBxx1Otu5CE6BFsj0drj0nPcPYns5GDGGs58k4vtvHRH
	yK8c1IeheMGCvS0WjVqyugjuhr2EPkVuVqBb/Tw6UnVHrQ1gp/nqsrQpzMdTWF8=
X-Gm-Gg: ASbGnctp4PF7H3pIlo+KO5DzaiBIqGKkYWHJ6Hfnd+adgLfn4b1doFqdHNQmYz/Ny1H
	J4stuHMkqbQjTEP9BYf8XSSLHhjMWO+NZ/J0MEe5iwzKjHpq2gkOCk2KHmQ/Vef0D5ZpUC/BbFH
	OQhzoLIdprvV4xgFl2/VI8hinHKcBR86E9ykJt6AQVhBq8q7d62HjCZWySPDwtM/+y4hG+rNfsJ
	X8Y6k+cMvuE+54KeLWwgr2ZP2a9/7M1/ITsGM8GS2arCtRA4tgudYbloshEYSfRCWDBdFKd/xHP
	QcHPPPiuO3FOK/VuKEFQdHL0HgNtIrigGqv1+VXBu8MFfnqOrQoMlXTDEwiZxgrdmKvmLNhhMVs
	+Ww==
X-Google-Smtp-Source: AGHT+IGkkhlM5M+6Ld7nKmAFjVYH2kcGrb2uQx7YXLfMGH1JYPzi/20s2F/+C1+ZB+VEtlEdwAiPyA==
X-Received: by 2002:a17:902:e84d:b0:223:653e:eb09 with SMTP id d9443c01a7336-22fc8b10842mr38716365ad.7.1746783689060;
        Fri, 09 May 2025 02:41:29 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271c38sm13271035ad.119.2025.05.09.02.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:41:28 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [PATCH v14 0/5] Change PWM-controlled LED pin active mode and algorithm
Date: Fri,  9 May 2025 17:52:29 +0800
Message-Id: <20250509095234.643890-1-nylon.chen@sifive.com>
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

Updated patches: 1
New patches: 0
Unchanged patches: 4

Changed in v14:
 - Change `frac` from `u32` to `u64` and cast the constant in `min()` to
   `u64`  so that `do_div(frac, state->period)` no longer triggers type-mismatch

Changed in v13:
 - Fix syntax error: Added missing closing parenthesis in do_div()
   function call.

Changed in v12:
 - Replace division with do_div() to fix __udivdi3 modpost error.

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
 drivers/pwm/pwm-sifive.c                      | 52 ++++++++++++++-----
 3 files changed, 47 insertions(+), 29 deletions(-)

-- 
2.34.1


