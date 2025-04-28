Return-Path: <linux-pwm+bounces-5730-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3099A9E5CA
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 03:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8053B0E99
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 01:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C12313D521;
	Mon, 28 Apr 2025 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCauczAy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBB1A945;
	Mon, 28 Apr 2025 01:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804153; cv=none; b=S6+TTeWxw2vnOc1M7/O6Ik0+K8PLjHUldm+IcfSQoAiY2K8DvLPBPONgCW7h57UPI/P3CnnwgZWPckMfCbgJ6kRiTtPiw5QousEgBfM3OrSEuQcBXOv5VoC2VZ+AnIK6ngeaWilTRqTEdON024IrlnAc65JVFHDrgdTaEkkgj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804153; c=relaxed/simple;
	bh=nl8UCthEODs1Hf2gbpKV5BOp54SO8pdO1m2vXfpbFIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnGxn3jLY4FnrlugmdgBfoANcWaiwKflkr9/ql1Jncn5xge7kH6j26umSFUqF0L41LpL/FRMO+xQDa5m6T8hcxqlj6QKd2kAfxpLmjk6x+1PNn83PP1Rme+0I63sIc4MVlG38ERocvKALpQc4Ghe8LgKdIUbhOq7aYy93YaU668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCauczAy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso4804656a91.3;
        Sun, 27 Apr 2025 18:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745804151; x=1746408951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CelbDdjD31eK+tW6nqnssONRY/dMWhFNI8vW3XTn2HE=;
        b=LCauczAyoMceVN+O4/4Oc89VkHeRCOVtBoBl1ZHEX0ghwuOVD9WQNyykyrB/Cjsr2j
         hxqnNDl5OZjMnlieLzKOVlB3rhRdu2RIV3r7sMnzyHdPggVguIIYJ1ojldXFC/fNK0H2
         Qa8vGW1Ih8IP58gkFmsBAcwwILNTyc3GKWaSnr3+5LfRpjhnxa1MIESVBZCv8Uib2Izi
         KmnHzhoVvYBuNw7eJYWYpvAoBtALu7EvldDjNQh9pR1BtrFb0A8oG4VIQMLLlvunASHE
         kqZcOmr1aWy6AVCIK4/7E8i+Kbbqyd1QbfZ8/Qte68ggL1JnYGyC4RljLDJEcxay0DvQ
         I3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745804151; x=1746408951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CelbDdjD31eK+tW6nqnssONRY/dMWhFNI8vW3XTn2HE=;
        b=REdE6ykL0+xKsYES4e+d4ZqcZsv/IM1wJElu9wO+kWWAHEs8jxO3CN4JwBPmw4whQh
         BKUkx4H7UqhbkL4OTEvcUO1mIkOaKgdtE9WEDL3AYIq5DIcRc6KsmsR1Hs3BfmsDMIWz
         x+XgJ2NF92N7p0luW1pGK3jzWnUYbznIug9I6m3rwcwPQOoNwZAaDV84KJdzW3YMn/XF
         3kiAbYT7wqa94REAPZHm0ACydM3DtV1SJHIShXbwaDWKbbHQJCVbqGhgFBy5rrtgrtt1
         9+iGZ5klaK6FNBTiMl7LjhGGvaHa3A5kNyK0BgzzOnJkKfMOvm8vvMAmLc6MI5Ox55Hx
         pmYg==
X-Forwarded-Encrypted: i=1; AJvYcCW+46+9zHUSKU48A12yaqmYys/tXNM3NyIhNNRun3NFi+gnW/7QrZQK8Fh4t/w/yAf1gTiDG2W9c8jh@vger.kernel.org, AJvYcCWFZovd1J5aqmkWNESDKIVGC6yMoDJ25irXKDH4zYqml/YVqCJiPyhlUG6PLLEni5RUlM3usLge+5aUYUuv@vger.kernel.org, AJvYcCXYE9a9/jL07OSxTx8oQpRy3XIKRmjtHY1MvJiuFWelQMGCamnL+rowFe0jGBZAs5Wg11mVxf9FYl+E@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdq4QlimuTCWWYuNWKqHA+GpC5e0fmZZcSz0WRsWvcWexPukYp
	gXLkNq616ToN36cwmcVxdRzmoR2JBY/4fHScIYHzqHiKYId/zhvW
X-Gm-Gg: ASbGncvp+I8MNSZV7XfSNXtYTpg9R+EPEEbTsPLQsW3qTTN6nq9C4aG1EQGzAPnwEbC
	f6Em55sPnxE2AoPMd/jww21D9r4Veg2jOjntXv5UPyS54c3PeBA5zAK/YEl8QjRwRbUNBiuiseK
	3ka1y2j6+vCN0R0EoP+SJhY76hL+rm6zyatgHtB009qA/IvyUtAio6f1rG3cTHXJV5eK2YdJPy4
	PjWlkE4CKEs83LdyUhE59yD7BxVmRan0N/f93XxkjL8ow/YwUlgk8xs4kU84bq5GnIjTwFbOSrc
	1QjOrPGQUvNG
X-Google-Smtp-Source: AGHT+IGKGbMil6EEDHU+0biwSVoCuulWB7ClFkZPInygmRDwy/3+427P9i1C7j/ysX93h0Q5LbcJwA==
X-Received: by 2002:a17:90b:52c7:b0:2ff:693a:7590 with SMTP id 98e67ed59e1d1-309f7ec20famr16886974a91.33.1745804151055;
        Sun, 27 Apr 2025 18:35:51 -0700 (PDT)
Received: from cu.. ([2001:da8:7001:11::460])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb26sm8508671a91.6.2025.04.27.18.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 18:35:50 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Longbin Li <looong.bin@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 0/3] riscv: pwm: sophgo: add pwm support for SG2044
Date: Mon, 28 Apr 2025 09:34:47 +0800
Message-ID: <20250428013501.6354-1-looong.bin@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds PWM controller support for four independent
PWM channel outputs.

---

Changes in v4:

  - add tags for mail.

Changes in v3:
  You can simply review or test the patches at the link [3].

  - Rename macro definitions to unify naming.
  - Modify code style.

Changes in v2:
  You can simply review or test the patches at the link [2].

  - Modify variable naming and code logic.
  - update "MODULE_AUTHOR".

Changes in v1:
  You can simply review or test the patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/20250407072056.8629-1-looong.bin@gmail.com/ [1]
Link: https://lore.kernel.org/linux-riscv/20250418022948.22853-1-looong.bin@gmail.com/ [2]
Link: https://lore.kernel.org/linux-riscv/20250424012335.6246-1-looong.bin@gmail.com/ [3]
---

Longbin Li (3):
  pwm: sophgo: reorganize the code structure
  pwm: sophgo: add driver for SG2044
  dt-bindings: pwm: sophgo: add pwm controller for SG2044

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |   4 +-
 drivers/pwm/pwm-sophgo-sg2042.c               | 151 ++++++++++++++----
 2 files changed, 125 insertions(+), 30 deletions(-)

--
2.49.0

