Return-Path: <linux-pwm+bounces-4271-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0A49E695E
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 09:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69102832BA
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7551DF72D;
	Fri,  6 Dec 2024 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akkmv6z+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE01DF24B;
	Fri,  6 Dec 2024 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475310; cv=none; b=ltf6eB9pEGmin+z2r0tK1KLrnsH/EDr9VLAGQ7K7Sz1s98QzhjL6piS9KwN05g1CuAiO2TyZTS5f4K0x590WdqGtMK4Xxje7ASJkSU/jN+LZBXnR6gylEO5bTB/Zy1HwpNXvmv9temGcDJuJ+sSrM0g7Aiqe1z0r/GpN4cC7iAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475310; c=relaxed/simple;
	bh=cGQwLBa50BqSiZXMF4ZcHqyyMkfFXBX5tddRrn+oclw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+ZtHvyMWeWwrAUAe5uw7cKJ7o656VfiE6LtzZCLoFZ6QZpmIZSUREnHscku6qY5h3rhkued9mOU8cAraWtUvqGKxs6DoDz8mNyxZv03djVUcmYSrU7sSg2v0hp2eB3sti3FQymHrJPC9GKAd7Ugyw14YjoepdLquwcbyZLJykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akkmv6z+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso1543813a91.0;
        Fri, 06 Dec 2024 00:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733475308; x=1734080108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt7Z7l4IzJbSbBd7IGeNLP8mVs+vDf3JZNjAJLXbLd8=;
        b=akkmv6z+cvO76TE85DmA5vn5H3SOoLNKAnFdY1V75RcwJxbulf1o8zaBmZnb/rOJwZ
         MyYOw60ZWUGXeEbJ0a9bkXigd8S3/S5IxK3maK1xrNuhTZnuDa0eU12o42szOi0YwB9J
         qCbhowFh3lmmnLEH9POsbHcMCOkks2uUEdXuRfcKTBNfTEZsEKA0IVNhU8SJB+2l0ANv
         RTy1yakvbHEYmbN2vML88IFAIa9wSzbGIzyIZ2IpaVypFqKJBGZL2RNjIqMmOmEmx91C
         QO/HiNyeoM+50jocSTzxFiYug5/7cmFY4fEbgZFUE+HXx02rPd7EmgkQEckPuJKLiqpF
         3/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475308; x=1734080108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt7Z7l4IzJbSbBd7IGeNLP8mVs+vDf3JZNjAJLXbLd8=;
        b=tRRC2rkix69OQAjv5npbECqD4642fmJhCNSWtTP3N2c6EI7WbyiR8KgYXulQC+WGLC
         Qiog2kbi/5xnufkj3c8MAyGWY8gXlaiScpv5ypifZLj7U5HO8LinrD86Tnsvbd2Uk+am
         EcujGz3oS6/WWJBRFfVSHiTDcX1mLZ4WsoMgVt3kX/i8lcWLVqu+jCnhcjAjISM15qWm
         149+McspND5WVr9YPc5aUOOh9qU9sAkVz7ils9HDSr1xsI7XWh/+QnPsaCCm0feIMq9M
         DZHMNUj0qRg4X5mgQp8YIsY5aZJvXYRjZAEfUUAbq73mrfeSne0vEfC3FzJPeeK/hb/W
         POJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLi8hGUN+2UXID5Tz3pzvPbGppVjndW150u1RkTxNToOgetbBpNXsxW/rO3F6x3lj3BIyMHqZZ2apo@vger.kernel.org, AJvYcCVmrVJbDcMdn/QMmqwMrn80wKhuBCV68qoqZVuX/dK39InH07YZyNToNzJBh7X3/eD9AaHOF2Yye9CV@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4D4s4d16vDSMzLulT0+9po2RdfqOOeh+qwWi6p2+jRCxE3/l
	p1fl55lFK9h6UoV52bQBjtBlLovBADuqbHmTzFhBBast9zUZqqs7
X-Gm-Gg: ASbGncsDfXC5/aU0SPG+SqXIAmN/znD/MZUMSx4c4m5dQQBAhxSadblzMXoqt3/A0wE
	RFzwSJ/WTes9Y1SiDBsQlckiLHHECX1VNSv0KvxL8RX0WWKM6S3rj0T1ZANu0MTdKG3KuLsmmBY
	gXKcdAp9lH1Y+VG0JmFE01vj7y5aFRpwVub6L0V/UouZdbbmGWWQKvY59Lq4KR5EQoFb5UYpR/+
	QEB5WCRXv95NoASeBfz9reXnnD66EJjbxJMBe6yQiSK34BCnB402xeDwdzL0es/xTuw7wzmLw1h
	YjV0Yv7HsZeYRbRL5OQvfDC+WvSdaSOKrTxadQ==
X-Google-Smtp-Source: AGHT+IGKo685mMivDdAq9M3LGWmjjpmIkL1RsgmqJ3QTFCAEaj1zx7+8CJggDOCSx47c/z5zEUZ+FQ==
X-Received: by 2002:a17:90b:2d05:b0:2ee:cd83:8fe6 with SMTP id 98e67ed59e1d1-2ef6ab27390mr3012606a91.35.1733475308511;
        Fri, 06 Dec 2024 00:55:08 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef270795d6sm4548157a91.42.2024.12.06.00.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:55:08 -0800 (PST)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	cwweng@nuvoton.com,
	Chi-Wen Weng <cwweng.linux@gmail.com>
Subject: [PATCH v3 0/2] Add support for nuvoton ma35d1 pwm controller
Date: Fri,  6 Dec 2024 16:54:59 +0800
Message-Id: <20241206085501.2623772-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds pwm driver for the nuvoton ma35d1 ARMv8 SoC.
It includes DT binding documentation and the ma35d1 pwm driver.

v3:
  - Update nuvoton,ma35d1-pwm.yaml
    - Add maintainers entry
    - Increse "#pwm-cells" to 3
  - Update ma35d1 pwm driver
    - Make include header and macros definitions organized alphabetically
    - Rename macros REG_PWM_XXXX to MA35D1_REG_PWM_XXXX
    - Add macros for register address

v2 resend:
  - Remove wrong 'Reviewed-by' tags.

v2:
  - Update nuvoton,ma35d1-pwm.yaml
    - Fix 'maxItems' of 'reg' to 1.
    - Remove unused label
  - Update ma35d1 pwm driver
    - Remove MODULE_ALIAS()
    - Add chip->atomic = true


Chi-Wen Weng (2):
  Add dt-bindings for Nuvoton MA35D1 SoC PWM controller.
  pwm: Add Nuvoton MA35D1 PWM controller support

 .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      |  45 +++++
 drivers/pwm/Kconfig                           |   9 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ma35d1.c                      | 179 ++++++++++++++++++
 4 files changed, 234 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ma35d1.c

-- 
2.25.1


