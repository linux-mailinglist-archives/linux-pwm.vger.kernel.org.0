Return-Path: <linux-pwm+bounces-5563-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE2A92FF4
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 04:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FA5467A9C
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Apr 2025 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80EA770E2;
	Fri, 18 Apr 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvPcdTUn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B5AD23;
	Fri, 18 Apr 2025 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943414; cv=none; b=fLXnTsMAiW+FZ8wDo8S2EbYHyYRXe3xZa9fENbtzIj/3dEGUoH0e8snrdb1TksC8LJGbvKZR6l3pUVSwL9zZ5tN++wr0HuqBROrCzau4Mv8O7SaTRZ4AMkfi6pQHpfj6nsthq2MjZw8Rdx2Dz9LPiap4WO5++bdoydPDUuQ6YaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943414; c=relaxed/simple;
	bh=Uiv/WdyiM6ZLD1iD9O2Piqy+yeK2HAB4dBLGWKd3yfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LT9Uf46qqomL7lJWsVsv3pOxG2WmXn6S1O/4DIeyo2u1yAihwn3YZzIG9xflM41M3LLsQFNyqbuoDIxgIjSTQ4g+Stw7QxL45LsWVAedS3fCvgg2PXmCkKcB4qVVbwiu6IMm5GQ0y9AVQRtluPmrSyx5v//QTmAwrtm1m7rOsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvPcdTUn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3031354f134so1130319a91.3;
        Thu, 17 Apr 2025 19:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744943412; x=1745548212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5U2m/1zIwftem6ijc0txeow0NVnpRTFEaq+AmNYeLGE=;
        b=VvPcdTUntEpO6DlZrgEp71qKEDsW3OWoCrNjIKbeIPCWoppWrrewsKXlol+pI7Ax8W
         yZ45Ti5jZujAhf4rAgFy2Z2u2kIHmaDSWAOsHsW06YRCOHQal/tMxLuN2SmvpC7dB/hw
         VFKw/qxXVZI0/lC4cpCinWIrEijXHhZkcpqPBkYTxoP7AWjRUM8nDRWWgo1Cn91zPNaJ
         qThR/S+jkE/jodNNEBE0ZtIYxi53WJl0TXAZi/bMCZldrM/OPncjQBydHC0n9gRGKp5u
         x19w2HnrXlP2R5/0RGIgk7UDHDrw414YPnO/Ch8J9XhLCbE0LAgVAYSxbdoII/vCf0yb
         NR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744943412; x=1745548212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5U2m/1zIwftem6ijc0txeow0NVnpRTFEaq+AmNYeLGE=;
        b=IVRkvwAdaE90GMiUWFpR17zRUogUVsPzjfpEdaF0IpUWQYquQlg4Mnm20CQ1sXGjzz
         N4bU5uaK+wgmrDLKh+lGp4Oa3LThzzHZiclmGTQ3ufgVO/wkzeRK2UFp4/SeJfWapMy8
         LQZ/hjuG4T3l13v+8jH1eliW9ZcYLMGCnb67E8XSC0KYSTTx4Q+H3riYEDxgb+8MD3P9
         oK9+ZdDBdaL67lAPGZw7/y2A1WUGg8WKVBJF7Oen8GtbLGJtW11M9huwYpQvcTva1TQw
         7hnMbW7ESkZD1KvW0u5ZfB0V7vPuhJ7a69/83WPwz9eAtGoP8CnFQXkqB2qecbbiQmI0
         V8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUwVS2aZBvRYopiRgnaBc0zLrO1e3FRpRH9NxUVSn+qd3aJrOllJyctioihAt+FHsA3tREHnQZ1jdBcQDli@vger.kernel.org, AJvYcCWGXTaUR59Gp1DCHfnuPWwkHwq6SlqWTVus5xmHTMHIOsV4RkS+ydH5oZmWDTy9g3Cf9CVRPsBLCUAZ@vger.kernel.org, AJvYcCWgP2XT1L3aiExytEyx4Jd1jZn/rb/1jsV4jnjA1r3BKyeq91N4eziIaNMkXRt5LCAFPDFtQ4mZnF8R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/oGxlsU7f7HUqttLhNmD8K3XBgCHGY56jmNvECzt2aCLQP2e0
	IK3JmeTQj+EgolfDxG1fyuJ7goFiEbm6XP0VrDkM+R7ab8zFqbo0
X-Gm-Gg: ASbGncsHACoxkLiuw5NsmApEsm/heQoYvdAgUvsqJApQMJsj9Cah+zNuuXawr9+fA25
	3oPZKur5DEK9UYkMyi9sRp2ds4PN6ZiaI5NIxxQQpyyyg29YL7klKqVo4IPAfCxbcmQwaPhWBMx
	iJlhwmUhGXuuodEG7eyml1CWF0SKt/4FJi7kRhqM13y2OE7sb7O1lRA5diOTeGzwEEE0GcZ3VUL
	aazzD9oHiSs3OIoxryGYxhviZ+g4BknTpUv7XGgqLbqK7mYgeLZPSPn8phEH4K3mBA65RvR0NSw
	SQS50/ABfi1w26PMlu9uuHGismaeUNLUfZmNSN+PMXDaaw==
X-Google-Smtp-Source: AGHT+IEx1z4qiAeTBtr7S7/FGS2j/mqRRRu2uEicuvNdRBKYecwQYjYYbj1Nrv2sWaIQGpfTFyTyeA==
X-Received: by 2002:a17:90b:1f8c:b0:2ff:5ed8:83d0 with SMTP id 98e67ed59e1d1-3087bb631d7mr1870914a91.16.1744943412361;
        Thu, 17 Apr 2025 19:30:12 -0700 (PDT)
Received: from cu.. ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df0c14esm182185a91.19.2025.04.17.19.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:30:12 -0700 (PDT)
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
Subject: [PATCH v2 0/3] riscv: pwm: sophgo: add pwm support for SG2044
Date: Fri, 18 Apr 2025 10:29:43 +0800
Message-ID: <20250418022948.22853-1-looong.bin@gmail.com>
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

Changes in v2:

  - Modify variable naming and code logic.
  - update "MODULE_AUTHOR".

Changes in v1:
  You can simply review or test the patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/20250407072056.8629-1-looong.bin@gmail.com/ [1]
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

