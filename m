Return-Path: <linux-pwm+bounces-5663-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF2EA98434
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 10:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BFD3A695D
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539C11E376E;
	Wed, 23 Apr 2025 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IigiiLae"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F72701B3
	for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398401; cv=none; b=ltSIoRC+2DFgg7AyakW570h40uX5pAo4SrRcfjbWU3nEx86OO2u97vxdsgwekY2gkBdalFsPBJ5i0qBzbcb19AagaW9W63UMcU4j3Byqkbrg0prVn+DOAoMd3lCLfWBcm9yAsIUunEUwck2tvImKJqfSA6bREkGUAPJikfnskDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398401; c=relaxed/simple;
	bh=UOI8lXRZPdfZSPbWA2ksZJRwnym2wxvE561CmHCyVWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tbQPAPm6BGwPta+IzG5byLwi13Wbms5PxlmitnFWuAqge0GThC9CrHyZaWn6sPtP36402zDUJV/oGri2JfFlmfwr/F+kULzZJNLn3Bl6fAlVEPGUk75+wQWdAM4nG5XxpxXpXVmX/MYIdtXaBIhihlM0+MDHcoVszPtukzquykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IigiiLae; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-afc857702d1so5339821a12.3
        for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745398397; x=1746003197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjebrSqhRy+XNyTElbHFiq0P7Ym7xRzEEhcpacCtDZc=;
        b=IigiiLaeAZvI83uC5U0K5yngenzXu2CxZSUGHrFSWlrm+sZOIOf0rKkUdD4O6OwEuZ
         hbJOlbVg49fm+JCITRbx2q9SpFTZ61kGzxrn1wFokvSGJcWBNCSaLqAYb/Erd/qZnkEm
         uIXo1OgC8+/x/MQWIXWNcEpy4h/t4NnO+V6GlznJwe6pYpy47/09NJX8BBkkThfqTDB/
         YgINLPOGDNjNdzRhvoQn2kXSu+KsOHvhlvgH/K+LQfSISb7j1IO4CF6hVK4awlOJWnhA
         nUr5lSKQ7VjzWtODzm27phQa4WY8lSx+QJPoj4WSzGxt/QOGp35JwDuk893rtZkWDsnX
         baXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745398397; x=1746003197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjebrSqhRy+XNyTElbHFiq0P7Ym7xRzEEhcpacCtDZc=;
        b=nowhrKq8i9E8EarQ6ChI5PhP7jIXStGayQ5YaS/iT6/PSb/tw1jBC7PbQ5+atBrDQZ
         7Xrj6lgZRkgOanq/Qlwhmm2v7wldnl9HFGKGeol4gTis5jf9oSU/ASB7q/XfIwzRdnOa
         2mj9fb4z9z2ngy473zr4M3R+Jy9sSwC0KgpKMS1LjdPfZv3ZkA1nxyWtpcTBXlUqTCur
         kh5KNOJyqXMubZE1ePmJ+k32KfegkoQG6MnSirYUio2xSpPllk29+NkGYMMfpbq5tzwh
         yLfOV0hUEF4/at0e6ny8V1Grb6abk4o/NeR+Ua8f4C7m1bTJcPt+7qwnf6PMKLPeOQnu
         VxVg==
X-Forwarded-Encrypted: i=1; AJvYcCWKiGX2yIzCCQW+vdeWB2AY7xR6Vb8lVwi+b/JKHyhNt+p469Vpej4HWcWkNez6i9pez0qPUQaY9X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+R2OHisEZtIg8xQ3NasJHHfqlToEmsgysHNKEwytEBJHD6r7
	QUl5ddUCpFBFe34/keqEgcAWUCNWZaHfA3Tj90rtrsu7NyLsctOzh3mWpbCfah0=
X-Gm-Gg: ASbGncsEHjkM/MlEYiQa5b6weyBvTgp7lTu8TNp5o3gClBMBo/Va6x6d+1LibvSwKjb
	kchp7Htsl2QqaY7J7ZN57AxxPmiWuinaldAl70DvFU4xoZgytiTaS17rk98G82KbkXpOlE+9tSJ
	FG4f8TD7IzfgNm08R8BaiE1GIEP2ci+LtdmlWGiUs2d6Ol4kr1+oVIvJqmq9mp+jXlxWEnD2UUE
	8vBAqFIMW7uC+u2rZoSU5q3WWJUxRECpGd6c2maTKQpywId3VtIu2gCdmPghQBpfHiMHiLNhyUz
	VOL3CjkblWJ5TL/5S1k03EckZh8D/qOiOqjwCG20SkdQBhSAr+jncUZkNo2yxmofh4bg2H1itfj
	KXw==
X-Google-Smtp-Source: AGHT+IE/xgNsfxLOOIy9HFiTH79KuPX/M8jQhMYXEVtLbecTAoeikygJMa2gCllgel3Hj8t3lvLqwQ==
X-Received: by 2002:a17:90b:2751:b0:301:98fc:9b5a with SMTP id 98e67ed59e1d1-3087bb4150cmr24558428a91.6.1745398396823;
        Wed, 23 Apr 2025 01:53:16 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309dfa5f880sm1047611a91.38.2025.04.23.01.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:53:16 -0700 (PDT)
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
Subject: [PATCH v13 0/5] Change PWM-controlled LED pin active mode and algorithm
Date: Wed, 23 Apr 2025 17:04:41 +0800
Message-Id: <20250423090446.294846-1-nylon.chen@sifive.com>
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
 drivers/pwm/pwm-sifive.c                      | 49 ++++++++++++++-----
 3 files changed, 45 insertions(+), 28 deletions(-)

-- 
2.34.1


