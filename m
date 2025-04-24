Return-Path: <linux-pwm+bounces-5678-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FCAA99E13
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 03:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174221946B80
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 01:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758C21BEF87;
	Thu, 24 Apr 2025 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2H0SVZj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111F41C7F;
	Thu, 24 Apr 2025 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745457892; cv=none; b=ZckJO6R/Mku80R0VYmIU8PKszfIA5/vVDYu53OtOWhquFFR2Ys1F+MZPK5oOGIQFRLljl7G2VcEPSNWEpnxpSb1CVUUMtjUI0tFEGxcntHPNe2H463kC6ITnpJp5R/shrihJy5vhIVFa298W6cbN03h2zmCUQotWX9dRJz7TYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745457892; c=relaxed/simple;
	bh=NNcZO28M+TCNaUNeh2CyJoOkvA5xCbtTntq07ND+tlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvKI4dcSddPO1uYX8pKkHjOGqEPpiQQrCPSe78OkUsvktoosqNgMP8VNLHjjrlHIcOdnotvhqFt+HVeUx76Sjb0941/TRhJEvhMrENEQAiRyZm1G0NLJJTmjHYaWZAR4e+PpSoGA5TbkF1IkNhAxHzfZ28YNw6Pz6tZ2rXheXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2H0SVZj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736c3e7b390so387823b3a.2;
        Wed, 23 Apr 2025 18:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745457890; x=1746062690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjSk/riKS3EidNdWxegqsSotH7MqM0ARsO0VOGtlQ00=;
        b=f2H0SVZjYKCZToa7GLJ9xiMObWaaU1ygEf+sQ65vNJ8am+wxquOR4+7o1BOVuxfobD
         LVdINbRLlnoS4dv6WonxBKRDmnElmXQw3aixxNqAyoGrfbYZNoICuakj2IxS7DATW2yP
         ckzTQ92a7qz+y/a70t25jeTFtARHP7RjHGdIEVOlzG+9Wg1tw8/H6apcUflUAmsEJvRY
         WHvM177zoiuitQrWHlub70vkn8CwJgIoSxzcE52quNbql+DjSVGFM7fg2CpiZ2mDeI6c
         rQFqwhguFWyZEW1bXnp/jYCef1yLXQLBPD9fyk7NOt5hFAgrgpd5odyw0MDCr498Qs6P
         XD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745457890; x=1746062690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjSk/riKS3EidNdWxegqsSotH7MqM0ARsO0VOGtlQ00=;
        b=surDac/rZytkWe+SP9lfWX6mJNkXAlj2IOEfli+fbxd/4Xd0B117DdQwiCV3pQoiPU
         SrOZ7V1g60kuNlMWqcjsDY4mFNwZAncxTLVkwtDL0JIe7Fm31XlXmdc7j5HT/C27P5xi
         t+dOYZl9ZmSRQ/dBwQWsCltvixzItOyX6LO9CTOw01zB3gxf7opx03NHD6mEIWu+EKjf
         rWq4IaNBfPmXQF5m7UXtV6f03/WrIivtt/Hr3+zi4/6cXG0pqf6FMiQPhxGNED8mfELz
         GLNNcmPMavDPaI77RqCgDOmGCCTpKCObSoLvzwUWhlhMoXg8WOSQQrxxf7uATqeNzOlO
         1s2A==
X-Forwarded-Encrypted: i=1; AJvYcCUfeQj+NyVoTq5h9Oxyd1XyCaIa+EteRGupC+py9ZS0APvF6hT+e/UgdcMS0Bc9jFbarfAROGOhFDXI@vger.kernel.org, AJvYcCUnE/b8T3wj7KwqPIiLk2/alc38RV7AuAoONP1iXwrs5zuld8ZHz7Jesgb4fie6O0m32AcyP0O8oNrN@vger.kernel.org, AJvYcCXlxdens3ECNlk8SDNmaR+BQFoo2fugsDRH77H+zlg/oKpWRNsZcuHTgkBi5OM9oMD0/msXFrMS77OL+Ado@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxo+OOvYcPwOb15RtSPYI+otTXghGgRhMFnzeYprfafQf+rq6
	MzX8k89To0AXyjinX2RzFg5w8EAo/XXwPYyTMKlhfC8QWCRVTvwW
X-Gm-Gg: ASbGncsnNpHar2KQR9cvT8oVsD9GNZSJ9g/4s3l38d5XIAIutzIzu1heeS4pdooCqaQ
	wqlFPeirCXeLXCDoTG8Og4j8k4iF0gF/YbfBoQ8eGeyvUEyEp0sDcRmao9PNTERulDNQCsTtSeM
	QDnt7dkLrvFgwUO34Tnu8z8X/1cX894tpS/6rCP+MwN7Xryt6qX49ToHYICUs9LlOuivJY2Gavq
	0rp47G6EtyEJMTppbm9LWg3hRw76DZclUPn0+5pKVhGWJKaxMGCudEJzin8B4sI6EPEnDKHihIh
	gykAYRubqdnupNTFSMpSpBd9Nv2Xa70=
X-Google-Smtp-Source: AGHT+IH+pq8RZMe2Oj6MQ/A9accMBVAbgt/Fo4AIrfNJvsNkLTtCSnyDrQrKFJLlIeZGRpNmZKTc4g==
X-Received: by 2002:a05:6a21:39b:b0:1f5:7d57:8322 with SMTP id adf61e73a8af0-20444fb9aa9mr966608637.26.1745457890068;
        Wed, 23 Apr 2025 18:24:50 -0700 (PDT)
Received: from cu.. ([111.34.70.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a8cdsm231049b3a.115.2025.04.23.18.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 18:24:49 -0700 (PDT)
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
Subject: [PATCH v3 0/3] riscv: pwm: sophgo: add pwm support for SG2044
Date: Thu, 24 Apr 2025 09:23:25 +0800
Message-ID: <20250424012335.6246-1-looong.bin@gmail.com>
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

Changes in v3:

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

