Return-Path: <linux-pwm+bounces-5348-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E82A7D5DD
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F3C1894314
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEED2356AA;
	Mon,  7 Apr 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKpfrJH3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEAC22DF9A;
	Mon,  7 Apr 2025 07:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010518; cv=none; b=rmzPdUIs6a4l77gEsnbBiSeq7cPoBIvFb3OamPZwzNZD+kFaR+jWjT3EiSxnifkGX5Nickih5K2YUBBv0TV64k/KyRpHhJJEJNwoG6jHTj2UIzSvd9VMpUKsc67Pw1YW79/pMib5/vZ2Ktph/bwQZX3OhfzYIhGi4E9EyzbUXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010518; c=relaxed/simple;
	bh=lq/B1uM+ZdZwRZ6B00/5OflkTp2/rdXR/2K2PuehMkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jReAFc7gsYZ/bqiAQ5ZAHLcfRxqFe10BY+tVy8PjaKhd2tY7DzenImXZagWMjnX84ex/v9FaPT1px3GvjdiGnb5FjuTGbVamhqJlwG+4G+hlbAZ1NVJSF+Wwzxrhbmc+ioG+6Ic0+AT6n5w1R7gMkiJMKFdNF8Kp++JlnGboKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKpfrJH3; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-739525d4e12so3355111b3a.3;
        Mon, 07 Apr 2025 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744010516; x=1744615316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dP9TEDefRiCfKDK6dCXsCuGcFPJWg2jzI0nw7IpyNo=;
        b=TKpfrJH3WymlWQcBN3anrZLU7ant6M3E7dxMQWgV4O1VfwiswDMjWVKJHEqUU52rOf
         Hue82SLsLuFnHSxK2VtoHo6JY6PqTQ9XE885aEMM23g/iysetR9pgcyk3lvBvVa25Y42
         R1PQ1jXC/Qxjn0ll3Dn58cgXCJPf2adIcWbUNSMeibdMuYlqT+8SiFIBayV6uvm5uiSo
         VIXHNoMDbZeWJZ2vHXkeVTAw1ZZgougifwFnqqnHslJ8qFInZah+UmT3BrdmKllWqIwg
         b6DsWcBE3LXCYwyskblIGJd+jStj+38wqpHGYKAJzHS9anWFxjT9oa072Sd4DL1Sjswl
         mp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744010516; x=1744615316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dP9TEDefRiCfKDK6dCXsCuGcFPJWg2jzI0nw7IpyNo=;
        b=oSmCpkdNWlMeKbzidfn+38A5lJ1cqjz2zsyCQaYovD7hWLHc8ShLvbLd9YWR7wIQR/
         PfIRnsaS8nW/UgLq5HwwHg+oDPKdSYkwdcyCLgkgwn8/jkRHhPrwkSwHE72Uf5rb2R2Y
         BwmvI/pEboUTWJuWg8D2okjXJ2uToZvLeJTQdd4iGmE4YSIGTup+XUB/nmSY3QDrVeQp
         oT8KHHtBQWadkd+m3/CknIBzsA7HpZB/JUj2O1vZ3EHRU1GyNoG2JMJy6L6IluVN+THU
         pSJCpACehEgN1/ADarumirxugZy+hqzEp0Qs6im4JUTjm4YsiGGrCqWOL7XohAd+cLIk
         PGUg==
X-Forwarded-Encrypted: i=1; AJvYcCWW+KF3Cw8/oolnSOwbHYGFjS+AVPM+vJge6zk1f1sgv9ya3u16Eu3NROslwYx71Z8rAsEOSRC7S30kPGfu@vger.kernel.org, AJvYcCXYYt2ZQvdTSh8xjwy5DFvRr4iuAh5Y10o/wYHmOwk67NGXg4eE+Tf62yNvj2PENn7ptxEIBJ4aIJ7g@vger.kernel.org, AJvYcCXdrPkc+pPdiTIJfCrpRABGKDv0bySbZxbB9VahvkWxo60lFoN6DwPIfI/nU9Y1zs4cHCM1IxTCJKbv@vger.kernel.org
X-Gm-Message-State: AOJu0YzDDQQLd/8tj8FX7brMCCdh3KnfuoUOfZmW7C0w4jWo4Na8+hHy
	geJx4D3eYqEiFi/7a3+FbetGnN9dOJrppcSafDRrN/vflWKu1pWw
X-Gm-Gg: ASbGnctOBXeRq+nO/mPKTzM153e9uJnc8OwhJ+T8z+uFVFExKNXhih0/cpxXOhazouC
	L7CJpsVNbF54NjqAZqJ3U19rmgF9nbH+yrxzfqwMg3lukebWvTESVTjMxAFVskH4wREWIiYVcxq
	ACs0/f42le2hQjmwrKVTEWHkQiqdH6b2m0AGeEiK1YFtV63EigZHiXBCzDOw4gEfrfc64gc4im8
	fW58aTyKvc3Wkqu0FgW9YgPCmKjSV+nHn0QxaGfV4cBMVAsdEJEAhGMdhwF5/V4GZEhVgoStn11
	xMHunEJzrnUZZ1mMrUNtNc2AH5Q1FQ==
X-Google-Smtp-Source: AGHT+IFQxRWIvC5wkqCh6heDsDs6qCBCvJgy83QuVa7jiqs/EDCg6zs/0W+VCWvbxeuO/25zv5oksg==
X-Received: by 2002:a05:6a00:2381:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-739e48cf381mr17596430b3a.3.1744010516171;
        Mon, 07 Apr 2025 00:21:56 -0700 (PDT)
Received: from cu.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee60dsm7787598b3a.40.2025.04.07.00.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 00:21:55 -0700 (PDT)
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
Subject: [PATCH 0/2] riscv: pwm: sophgo: add pwm support for SG2044
Date: Mon,  7 Apr 2025 15:20:37 +0800
Message-ID: <20250407072056.8629-1-looong.bin@gmail.com>
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

ghost (2):
  dt-bindings: pwm: sophgo: add pwm controller for SG2044
  pwm: sophgo: add driver for SG2044

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |   4 +-
 drivers/pwm/pwm-sophgo-sg2042.c               | 162 +++++++++++++++---
 2 files changed, 141 insertions(+), 25 deletions(-)

--
2.48.1

