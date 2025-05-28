Return-Path: <linux-pwm+bounces-6160-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C04AC66C3
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EC83B5B14
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1202797A1;
	Wed, 28 May 2025 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTg85LV5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4927932B;
	Wed, 28 May 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427113; cv=none; b=vC6nsf3smVWshTzMnxp1FBJLpt3+wZbYpDn4jd9I3BruOD8MXwURzlv1auvpk6o0QhiZNESf6+4NbYe2fDTzBzTsK28HOA4VaoNyfS7GohhFosT8XS6qqWaaWoNwQUBU72WLZ/sFdvM51E/eXuBN5FzL5+lTgbWn1+ob5mAQU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427113; c=relaxed/simple;
	bh=jQm/Idqdz/CKRY7nuelIqDNot1qzY4oj6ANAyNVprKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1tyYbbEoktQIuPoisPUzkSd7vAmkPQ1gCVozOlznotlG15X1EPlQOpLBrC5G06822iHlm9oRP7oJyH3u5Vk3bKfluC2ngVoIrucYdBM/KqfR3fbXGFY1gl0HRLQEbf+rQanvRZ2Hecheiu0euVGM7WwfT5MUHa7HfxIfmV+wIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTg85LV5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22e16234307so6666465ad.0;
        Wed, 28 May 2025 03:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748427111; x=1749031911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1/Vt2mp73cleoni8AtXiYI0r+BUVH7GhRhyE5d0M3E=;
        b=aTg85LV5XonIN79ZDYiW6eNmJotr+PeHx4/uNCcc3mdfghtSmfTG5kQwvvcgpwMFDd
         XPyff3ZQCnVmbAwA5vS7AnZww8m1gfFVaK0tsdfMNB9/jWeY7wDBuo/e6qeVWXJ9i7Yq
         K9Z2wUK9JcM1OJfP8TUEQ20NluMJYslfNmXzIukpfMvzKlDiWLvBh1WyMZtMQs7Av5Z6
         lVbt8e4+zEE93ZnHt59ZR+buq4rXA1B0lUNMHAC/uMSnHYkTt6WKjKqjsJ7rhaNmDaw1
         x8hT9Lu8c1iuJviIWXaHwnkXMFQXB6eR8PzEFcuHMdw4CK7RxZ4HEdQc/IGj303gMHGs
         mFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748427111; x=1749031911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1/Vt2mp73cleoni8AtXiYI0r+BUVH7GhRhyE5d0M3E=;
        b=MPxSwZpNQFNCTPLKkOPclhF4uOCTaww2VpwiEpytq6Bi6PJ0yOeXuIcSqGyiQRD2P9
         FAZ2lctxtSwHxxirF/QMo1Yx3Ty4gk/+p7JfD7fEGuxy8AaC2HzuE63+FQTJBaY4hT5J
         TlU11QvVrynSPzCefAwV+Rz14x3SPhSJi+RvseRBBKkRznN6HRZxMYtR6CT3mI7pjdOm
         Oorwmc4nTFV6sGkP6pEppPdZkGVaSGrPoo44SoMlVdGhz0rn/kUl/N5vXUd2OABZoz+R
         JsTZxnKwOWmAfR03b1gOjOYWaeyxCZUXFzj+h/gJHu02+DlTeD4Du05vZtTz71MXgJfe
         3IrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrcKmCLEtB/WpW4RvAKmRgbvX/s7IS6RY1GPU9XUYNFaSMuFytBUVUXMz7oXyh5Hg/gg8iGsfRFesxMrCd@vger.kernel.org, AJvYcCXp4R+95Fey2A54t7u0KS2e9ZTBhaIfUeDMQduZoD65kBvByNiP8G5UEiAZ4KjtIqFWJtcLS6IJ3Mpa@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGmU5vT6eZusH8Z5AAddabUdGgOkJfpRKGEvlkb10w/notxI+
	XXFRvQs4PjQ+dQFejlwtp9wXuAL7ULEGzZP4SHVOiwPihV0TDxKmdF+ZKsE89g==
X-Gm-Gg: ASbGncvCrz5JHaozvP/3azWIZi2C7ZflyRbdW0nSbPlXH2liSGJGpHGJkdNk7JP4JM+
	+Wn4aF6mjydGSzNVNPlxrXg6zh36U3S3kbPm32I3/5EowLnvs575oG8MkLxwnzg4vE8j7B7K0b4
	RAFhJBgoPZFNMaXnlmqCcnLiaAtLw/p6rVyXEXXMybK7QbW2WS068KtNmprjEf4I/RPo21BUcfI
	/vdA6HiTporgOrMZbHwcPhCfS7CkMTehfG2dcAyrZjwbK6Bdi5AplK/3//LJeCL5wHmfwBLZK5V
	0hWnpkyi4YcP3sPm7ngW7AVj4UGdXCqLd4UKgzFA6ttPJHu6/9QMNwOI
X-Google-Smtp-Source: AGHT+IFZgXlqFr/nZJIbvYhr8VBnFB2u+fgWRkPoYOa2czSx/AkDylcuc63qHSavCUSvhb5c85NwtQ==
X-Received: by 2002:a17:902:f693:b0:234:325:500b with SMTP id d9443c01a7336-234b74f4119mr68932215ad.22.1748427111266;
        Wed, 28 May 2025 03:11:51 -0700 (PDT)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d358f118sm8453595ad.138.2025.05.28.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 03:11:50 -0700 (PDT)
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
	Alexandre Ghiti <alex@ghiti.fr>,
	Longbin Li <looong.bin@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 0/3] riscv: pwm: sophgo: add pwm support for SG2044
Date: Wed, 28 May 2025 18:11:35 +0800
Message-ID: <20250528101139.28702-1-looong.bin@gmail.com>
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

Changes in v5:

  - Rename function and variables for clarity.
  - Modify code style.

Changes in v4:
  You can simply review or test the patches at the link [4].

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
Link: https://lore.kernel.org/linux-riscv/20250428013501.6354-1-looong.bin@gmail.com/ [4]
---

Longbin Li (3):
  pwm: sophgo: reorganize the code structure
  pwm: sophgo: add driver for SG2044
  dt-bindings: pwm: sophgo: add pwm controller for SG2044

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |   4 +-
 drivers/pwm/pwm-sophgo-sg2042.c               | 141 +++++++++++++++---
 2 files changed, 127 insertions(+), 18 deletions(-)

--
2.49.0

