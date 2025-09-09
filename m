Return-Path: <linux-pwm+bounces-7263-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3C2B4A732
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 11:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9634E7775
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4299327FB21;
	Tue,  9 Sep 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2ze2rWj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7548D274FF1;
	Tue,  9 Sep 2025 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409151; cv=none; b=NqdwTbZSc3WHEsMzDbvpZVjUQpVuviTpaIYXUxCCi8spy9hzI8puGWMb4AXPhTZlhTws+Eybd94BTM43qwvthNi6npTZdNmvjg/y1H95rAVkLycUCafjgybvxTy3V5H0YCf8TSUxPdbQXGL+GAa0+3xNigjWyMAQMC4DegNqsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409151; c=relaxed/simple;
	bh=xqlHWIAPKSm7U1EbE1u13zfm8mRfc1V6oo/Gqs/+PLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqlcDoSDgsNFUARY8Sd2Jk5WK5vXJy2tmIRL+BOnNYM8FK2isqekXqIfzElkiB2UbMDkv4sJ5Q5B4WjVmjdzJLxKDfVxSOIPAg4UHNohS7OTiaED9zjRp8LrI16F7n+0hUqp/314YnloqitfZBcO9g4QNTvbYUhWaWeL4mcXOsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2ze2rWj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb659e858so36715065e9.2;
        Tue, 09 Sep 2025 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409148; x=1758013948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RveWPuVGcmszyLGs9d4KMSJA4r4CNTRcE+5AjPK4lc=;
        b=a2ze2rWjLkTzSK5+iLYZAbzzMnoj/jFo1unlIAc3l2S02RgYg7OJhDSEZaTQfYr9Fc
         ZkzUOPmgjyuvs6Y8sL/9LtG7p55np16dOS59nNjPTEGCdhBNdd3pjZr9fZuQTf1YZMX4
         sLd2zcbpvLiPkrCrAClaXcwGVx/2Z59m3tXEEKensVNsI48lqc8bU8X/sBGa+Ws+xj68
         sUXuYfhKoLDrBaCFXozQ4AdtoXskZuNdUwgK1hww/TOVw3HgQHt7Bx1sgJ7TNEMMxtH7
         FNzG/1r9STCBrGO9vkBouRTOZafLnr8J5pLREQNX5jATs9nIoV9sMemXtz7dMHCXmlPC
         UPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409148; x=1758013948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RveWPuVGcmszyLGs9d4KMSJA4r4CNTRcE+5AjPK4lc=;
        b=DVI5IJxlnhP6avEWJWbayLyVNxsvbqGia3Ke29OqY0Va5WoZv2TOpltN3vail/UjqH
         wQNnegbqg695j++UzPsW2fYdtJiXgr5jb5dM96iZKtYmRzEOxC4QxQTlGln8zRcla8um
         wmssxfFrfLIA/1H7efYR/+Mv0ouCmVosQ3TMhjIaaz2KZL3RBZdel3tgOwrJz883P5Ea
         hL0Ef3M2Z3VZxC+wRumf7w+5g74EidXoZbFIHVcVGOZA5thQMMjtfBBRbXZSt/9Jbf2c
         1jlCfkYNUu5goB7OTu5IhyYMdONj/VMj9RdXMLS1HXtdQRrZBZ7sG4gym9pxGcGsbzzU
         MNew==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ws+Z4m8G9uqH/+FOeejAIohpulGwrgGNJmbRx2C79Zv1Kv9dAgsWFDlM9oDJJp27lNpNmSCZ987fc5hQ@vger.kernel.org, AJvYcCUDW9AlQmWhw/o3Dy85kuo3Ly16+9G3JkYYvB09r5NramudzYJj2uxZ14YO1uxW0KNxKBD/tXcTSGvA@vger.kernel.org, AJvYcCX4rWcxv5tgGVbufiUUNQUKJ/veHBx2HFfjzvXmKE4gnB9wtXyCFNdoRwedvqocxOCuK8ZcpiGcqyceVBE02HM96XM=@vger.kernel.org, AJvYcCXPNWAfOSZ+7HK4fQHHQ/Sj2dCdhYroUk5UrkzYp70dhPmh8JnackVZTPFZLOr79Q3PADe86w8wQwvs@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCLwZgdotZ/fNg4+QvwFV0IeV2CfP8QDde8XdNviHvkRuy1pZ
	aVi1FVfvnSTDh+Uej0RQJw8pfXuGPMApSXLfiSEOinkY2IOtj05T+Y1d1aci82HQ
X-Gm-Gg: ASbGncvDHs+N2/44c3T8tAxCWXQtGBs+gAXZxPMXN0ZEkbQbGsIT85rnz6cHUZwvTj+
	2JwZwADfrVvLafONDqZ76jBm+HnmOoa9kk3ZDIhCHa7gSkNR7+czb8ZG63Jr18tmnFWtUEgX3KV
	ZLLoYkwBlEurS1l/OZa+uV4mnSj8VOyy/lQjlx2zuvj4bBFIKoVXAPj4wSUnZM6ferRGq2oMzHN
	F9YsAzQUUH8AavXcfgC9/UwsBkDoNCTwBdXccHu+ctqChdG0sW5DkNUnuYvcQIGK4V54MyOJ437
	iGmCBeZF2uIcXnLlrDFxnljOrbZfCPLTlutf39Zk2V11os5mq9wDq2RNXcgl5wimVRGCq+b4R6j
	L2N1vqUU7NdWnn0zQmq4u1X9d+LZzpPEMIpcrSMA1Ar4AbD1dEpxqLYK1asMluYt2SbCNs9bxSc
	JlGG2pKqJBhT86
X-Google-Smtp-Source: AGHT+IGz0bR09iqvcLjoDXfzsnjYEyKCWeESS6VuLUaRKZe3fhoBG4/GwZKaC6N92m1KEOcG4ZDlMA==
X-Received: by 2002:a05:600c:3103:b0:45b:8504:3002 with SMTP id 5b1f17b1804b1-45dddeb90f1mr100574255e9.10.1757409147506;
        Tue, 09 Sep 2025 02:12:27 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45deff68b43sm6975685e9.2.2025.09.09.02.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:12:27 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/8] Add RZ/G3E GPT support
Date: Tue,  9 Sep 2025 10:12:10 +0100
Message-ID: <20250909091225.128658-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

v1->v2:
 * Created separate document for RZ/G3E GPT.
 * Updated commit header and description for binding patch.
 * Added waveform callback conversion to this series.
 * Collected tag.
 * Added link to hardware manual
 * Updated limitation section in driver patch.

Biju Das (8):
  dt-bindings: pwm: Document RZ/G3E GPT support
  pwm: rzg2l-gpt: Implementation of the waveform callbacks
  pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip
  pwm: rzg2l-gpt: Add prescale_pow_of_two_mult_factor variable to struct
    rzg2l_gpt_info
  pwm: rzg2l-gpt: Add calculate_prescale() callback to struct
    rzg2l_gpt_info
  pwm: rzg2l-gpt: Add RZ/G3E support
  arm64: dts: renesas: r9a09g047: Add GPT nodes
  arm64: dts: renesas: r9a09g047e57-smarc: Enable GPT on carrier board

 .../bindings/pwm/renesas,rzg3e-gpt.yaml       | 323 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 184 ++++++++++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  13 +
 drivers/pwm/pwm-rzg2l-gpt.c                   | 268 ++++++++++-----
 4 files changed, 705 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml


base-commit: 65dd046ef55861190ecde44c6d9fcde54b9fb77d
prerequisite-patch-id: 994e29857383f8aa61bdc53df997f6e28f5cb723
prerequisite-patch-id: 81a4395c1935f9cc757743c5de646bf17a1bcfa0
prerequisite-patch-id: 34306f03faabbe6a0c238225e748b1d76726fd2c
prerequisite-patch-id: fd30b02c03eb26ef5c899a999964b4011e8c2e8e
prerequisite-patch-id: 93a5224b3caedf84145f925131c583f31332bdde
prerequisite-patch-id: 12f1505eeca8d5d136d8eac74573f6d2bdffa153
-- 
2.43.0


