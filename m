Return-Path: <linux-pwm+bounces-5643-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690FFA962FB
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CB419E250E
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 08:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131525A357;
	Tue, 22 Apr 2025 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WBEUvY0h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8306C2571D6
	for <linux-pwm@vger.kernel.org>; Tue, 22 Apr 2025 08:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311310; cv=none; b=qoDdttgCiYKVobTOExHJJodBgNbofVc/hVN+aLPJLtnK+EYLPW5Eic2QIXTqrPGhE3t8y4z2QR9rMLAVW9sKNui8i9LFVP38q8ORyZW2O1Uw7x7pfYADhkMPqkwRlUywSkXg21hvH8Gpvb7dlSCdOu2/TS1nqCnO8aBBrNyUMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311310; c=relaxed/simple;
	bh=rU2tl9SCzAOgbil25IGKZ40RSY+N21sqdQ5DgV7O1wc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lc/+m1bJ61pDXNi+/UuL8h0oAVm5DyQQhEknuw6+BISgzYhxr3yKx/jre7pNCVckTp/pi3/zp4xieoP6mMURSCuU/ZI37Lomr61/DCsjbIRqz9FwD1khDlUHgo8c+yIMnG+2CGvLfOQpP3ZXEcV+8JlYTy0Ai+Rr4sqrd+dUOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WBEUvY0h; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c3407a87aso72077785ad.3
        for <linux-pwm@vger.kernel.org>; Tue, 22 Apr 2025 01:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745311307; x=1745916107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nGVHUzQ7HsHW4QPhu/ISOoKLCvthpJGLbl2UU7uWwpM=;
        b=WBEUvY0h7+HjcQx8vQnyk4KkUQK0MU3MMrxqEvo3641nkhxh9p6+1KeDOa+p1eKB1K
         4CKsIYito5QxcLjVintEEkLWcytxFdHuWzAo4/5dGq6yWoyuBYcpWN0cQBswtMrXI1pS
         Hi30R1Dn6o3T2lhzM4bz7+beHDbrvbgQvzz04ctK5h034xfAq0TcQqxQLV87l+yD9VD0
         7opa9uIOr03COIprPIlxA8bDVHKM2/aldF5pZpK0u4+1IkQKy38qF1DtqLlLYRO0leDC
         kgPXhSQ07YbtW4WtXPVjpLTQN7D3DdqCNb+E1abHCV5uRCWXM70y5qDHNSjwo4hxYv+9
         zKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311307; x=1745916107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGVHUzQ7HsHW4QPhu/ISOoKLCvthpJGLbl2UU7uWwpM=;
        b=thzEDhfy6Et8ClgosI+lkxrZhhmYbS84dfOTKlbThjthLDPeonb80VEclUinyqmFON
         Y88KwRCYrSVAMCZeeJUUoMiv20meudzXi/0pBc7DwEGA1xst0MwFwqPBgjS3Ja1akGVC
         0XgwEqtM66RPWx5dZmVpT19IK8E08oGQB0ShiwaRenNvtQMVIm4RZlrF6r8yifi3XsyY
         mI3mSUApqsB4nm9d4E3T4u8xOekOZZJ6DSn5LkbHWtrXcP+La9YbJk3iBH73MAu1cUVA
         ONDUVqiN05HiFyOTxTu+sJTmjVjKILEJeYFDngAwr/P6UdzhLnUd3XXFEo5+gGv+cVEl
         cdnw==
X-Forwarded-Encrypted: i=1; AJvYcCX4lcSUfq1KyCnax3Lk4bPR0HiSWgepPVt7LiaR0gXAviGuuj5TF6W59g1PcJ0UmXGFCdGtb+GTdGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI18a4/seWdJuZzIS5fmsxKKYpdn/4fLvGcx5WzIZvVB/mF0fM
	YeXMXKueiOse0san9AjT2lZEsGduHe0kq/+5U0ELzRzOhZy00VMdu071m1vvXL8=
X-Gm-Gg: ASbGncszEgutVqSzLjazxT0l16mygv5sr8uhDT3Qnl/t8RdvfrLAD3RjSDTTUV/FUnk
	J+pNenoO1/OhpCJvtbAYTPjW8wON6Yx/5fjW+eZ2eDI1wuuaGbdmI+d609U0OjcWHBHDNezx4OV
	IYHYpCdPgIf2kwByHB/yuRowEfxT7SHoZMtOey4KD2XiqSyZts097RLH429B/DUXxP86gcQZNrQ
	WmixnnD3SBVzgVW+AYdJvUgX/55L3Oy/YGPh+De8mqF3mz0yWxDlll6t6I/ggm990y4w0htTcm/
	SyesmIHpBD7iZXwQLIgV/xNU8agNSlaZD4IXgjPWqwk5cAnApIrTCoPSo+RJgR3IT7sF+nEE8tt
	c6A==
X-Google-Smtp-Source: AGHT+IEPYWCuq8ruBT0tEw0x1V09UvVpIABZBC9119Nj8u+ntZXYEwKEy+rCGtoMMmbWNOj8GNY4og==
X-Received: by 2002:a17:902:e5c6:b0:224:f12:3734 with SMTP id d9443c01a7336-22c535adfb7mr204374005ad.30.1745311306710;
        Tue, 22 Apr 2025 01:41:46 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf90d7f7sm8038343b3a.82.2025.04.22.01.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 01:41:46 -0700 (PDT)
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
Subject: [PATCH v12 0/5] Change PWM-controlled LED pin active mode and algorithm
Date: Tue, 22 Apr 2025 16:53:07 +0800
Message-Id: <20250422085312.812877-1-nylon.chen@sifive.com>
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
 drivers/pwm/pwm-sifive.c                      | 47 ++++++++++++++-----
 3 files changed, 43 insertions(+), 28 deletions(-)

-- 
2.34.1


