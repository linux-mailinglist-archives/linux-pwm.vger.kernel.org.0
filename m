Return-Path: <linux-pwm+bounces-4487-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E354C9FBB1C
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 10:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235AA7A2323
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 09:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A5B1A8F9A;
	Tue, 24 Dec 2024 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lqgs05bU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9C194A45
	for <linux-pwm@vger.kernel.org>; Tue, 24 Dec 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032481; cv=none; b=VHc5gsKhjRRK1TDcQCeH1r8Ppr9H0Icha/HPl2JXH7Dhp9rQJmmsj6ATEkRQbV2SOjaSmSlDyMtBXuTCa8u+3xhpAFT3oUeS+EVD12O22TsNQfLZdFMexPbq8vsIL5c2A8cA6FzwTuMWPsVeCqsGU1ALo/7RVcnwkqI6v9MMXFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032481; c=relaxed/simple;
	bh=2t+mmYf+qQuZoqCXlanVjaUyuAIlUsomlX9EsaQMzNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hdXVWqlEAV6QLO83AS5VYB0HnjOcuQYtMV5YUcBq2WJoEqUmiHNpwJW3cQMqPlSZ5auklqdWeNpjns1gxYqBnrlT24Be1q4tOh4OhYTAGbeVk2kmXrQHH9AoF+kEkmu21KwZy6w0W9cc1aP/TUxXumNqqc0iQXtiAYvmD4C1PNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lqgs05bU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21683192bf9so55060635ad.3
        for <linux-pwm@vger.kernel.org>; Tue, 24 Dec 2024 01:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1735032479; x=1735637279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLPJJm7xVkKFHYMyvGiaT5Jiz+ZLFC1VkzAq6OtMdxs=;
        b=lqgs05bUVzZHIl2+cdmt8YreyyOW6IU5sRAX9fJ0489UKE5rXZxDlKwEhIPk33eXXr
         bWxdjLYpu6n6G2x3IAQZej0Qb8N2EdhOstamDSMFTe/NZtsxALI6Hy3sO1BArIBt7aIH
         wtxSN7wk6mw9w/8R3v++YVpPhdY1fFwH+oPi0GBYrFRAO8hLbm99jiuWix9vlEdEYEfJ
         NaQIg2B3kl+9L19YYQS5+V0Q5gJigb4R+0lt8KCDVQldxh1ghnN5pd74I+sWv0yC5xxs
         Ns6nC9FK19x7KSl2VGv5wxaMpZIkbdw37d1L8i4X3hWePjLK0/vZ/V+PIxlpmHPcdc2a
         p2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735032479; x=1735637279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLPJJm7xVkKFHYMyvGiaT5Jiz+ZLFC1VkzAq6OtMdxs=;
        b=rDrI01hzbbmPPKoIEIGzVm7F4x/MiGevd0OFP0/d0dBWU+qgoeB2Nn0hUAUtQAI+CH
         3ZyToQXhk+sQRO9x+M38C7cF6Q+EOe1G8LMwe9VUgQUr8J/uVnNQb21XaM9BIp1emVXl
         QWxW3k9svfdCl2PseP8OVGpS0aEfAUZYfREx49XVnHhsUGdEN5o/e+eAZQu5xXRgn2Ih
         PZa/Mpwn9oLZ0i/FBRK7RbcRRstOWdkPeHxjfffofzMOIH6TiDMfEw5CtJSqBlJBrfyM
         qs1OQPG9QEaiaKOvI7sFoLnQUtoBgR+AKXbIshRotfQY7Bd9Sk8qJvtrBtMWC8alPn9/
         1V5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkIj3vv4daBZTvfntqOTlokuv1KgEKINAub0STfDmvI2jlPu412VnnlZ793jW18mWYfgeIoP9ji3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlmKVpjqwT2oVPX+vGt7yFrML9AVLyyFZm4e/78PdQBYN3lzdv
	uevDxa4+aDN8wXsH97XuTm9BaANOseEjHVtGYMLUQyI1276gZoWWNMPIXzpY8yoh8LQ8vdMixw9
	e
X-Gm-Gg: ASbGnctSB9DJ8IFSH2dfUJHfId2ILF/I9NPL1M3qMp8+LSSCeCPljWYujizw936USI8
	fcu34qNUsJMAK1AMjtx+8QbC24NB/Oeg3Vjt8a7oDMKg+NM5pH/Os9ao2xLHDSvF+LqvD6tD+TB
	jGrhWHTBLO3pVvUlYlGGpin4LOf6kRNK+cph/HnlTtQy5uYDxTUQFU/V1JU4vMcfP80M6Vljp30
	K0IkSxLA5ssSYecoZYEEgp0jXmICSX6qdindPVZfXLdhkveaQt5fdeVM7uVQfHBiiK33xEwZaBq
	88ptZF5P6Xk8LcAHEg==
X-Google-Smtp-Source: AGHT+IH+ikoM6foMB1cnNkvpUi/3NR/XA4SwC00DSiVzFNckaK82lZIWct9AHrEMi4yCGHwTjvIZrA==
X-Received: by 2002:a05:6a21:670b:b0:1e3:e77d:1431 with SMTP id adf61e73a8af0-1e5e04a3035mr26453787637.23.1735032479006;
        Tue, 24 Dec 2024 01:27:59 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72af8dcff60sm516341b3a.152.2024.12.24.01.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 01:27:58 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Nylon Chen <nylon.chen@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and algorithm
Date: Tue, 24 Dec 2024 17:38:58 +0800
Message-Id: <20241224093902.1632627-1-nylon.chen@sifive.com>
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

Updated patches: 1
New patches: 0
Unchanged patches: 2

Links:
- [0]: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
- [1]: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68ce76f4192_hifive-unmatched-schematics-v3.pdf
- [2]: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf

Changed in v10:
 - Add 'inactive' variable in apply() to match pwm_sifive_get_state() style
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

Nylon Chen (2):
  pwm: sifive: change the PWM algorithm
  pwm: sifive: Fix the error in the idempotent test within the
    pwm_apply_state_debug function

NylonChen (1):
  riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's
    active-low properties

 .../boot/dts/sifive/hifive-unleashed-a00.dts   | 12 ++++--------
 .../boot/dts/sifive/hifive-unmatched-a00.dts   | 12 ++++--------
 drivers/pwm/pwm-sifive.c                       | 18 ++++++++++--------
 3 files changed, 18 insertions(+), 24 deletions(-)

-- 
2.34.1


