Return-Path: <linux-pwm+bounces-3125-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A167096F486
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 14:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB5F1F26B19
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7474A1CDA11;
	Fri,  6 Sep 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EduTf8Xs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492CA25760;
	Fri,  6 Sep 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626788; cv=none; b=cKZGshgCS3pUeKOc6PeNX/qrmv3BNJkJO3apZDTqSNpz6BbTT79thD0axf3qLM+unrma0Bvr+emWHiCA0WAjknlHoH5eV8JN1XbJmhkH9C53zJR5Mm3mtBP1dT4FkWIZahyXBPiWylzOR1L6DIMcT96LHA2jcfAmyR7519HKLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626788; c=relaxed/simple;
	bh=Af4hVO2lEqJLghX243SGdJHNChv8mD1EBsYO0E+v2XY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oAIsiYdyI7A5qrJBRl7wCQYykzuak0O2Qnoe0v4Buu+cdGDjO72y3RpQkytCisJnk6iplVDaQb8VmkcSjjJZF5OUoYI2bEhGLuWC3Yuk5TvgoSwfIvZnAuLfZ07A8zZwHz04oH4AAX8Z9nqq6TntcRnmUAqNko0cyVJkJU2OOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EduTf8Xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B36D4C4CEC5;
	Fri,  6 Sep 2024 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725626787;
	bh=Af4hVO2lEqJLghX243SGdJHNChv8mD1EBsYO0E+v2XY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EduTf8XsLV8NI4SzzhCH56sp1alDH9umiR+j/e52eBLfrH0A8CyTcEpXmWO3Xzet+
	 kmXIiOe+7e6cOXkxt6FdSTfRDt6oZwO8JFfynk+ydUFpuXA3S09DCMDeOMntqXnxVc
	 grLBdk8Sp8xtNorSb0lU0LD7mqerI6g3MR9/nJkwYkSZBV9GMeb4YEkKpN6Oh9DF1T
	 9L0q8rvdPTLMJUnZTBdJun63RiR4vxRQ7tiNsC9tIBwYnn564eQA88TS9i1/rXDK1B
	 6SfZTrmmjSYdQmlbjK57xE2Tj0sQOkxpeXlxax7JoXZ3WxMC2HrtML8AQLDHRq6/gu
	 hfOryp4WVuXjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D3DCE7B03;
	Fri,  6 Sep 2024 12:46:27 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH 0/2] Add support for Amlogic C3 PWM
Date: Fri, 06 Sep 2024 20:46:11 +0800
Message-Id: <20240906-c3-pwm-v1-0-acaf17fad247@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJP52mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwMz3WRj3YLyXN0UQ3MDcyNTQ3MLIzMloOKCotS0zAqwQdGxtbUAHXP
 JPFgAAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Kelvin Zhang <kelvin.zhang@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725626786; l=600;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=Af4hVO2lEqJLghX243SGdJHNChv8mD1EBsYO0E+v2XY=;
 b=8dq3owc63Flh3oSrwiJ6ZbPd7n2PLeqykBE4++TGv2VCDPWshqQnmin/SpZG7z2QVX5yEfHtP
 IzzrWBjOQ0uARrFv2gIh3PY+imduyZF5JwpKVMDj22KLSq1Sx4uls6O
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add support for Amlogic C3 PWM, including the DT binding document and DTS.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
Kelvin Zhang (2):
      dt-bindings: pwm: amlogic: Document C3 PWM
      arm64: dts: amlogic: Add Amlogic C3 PWM

 .../devicetree/bindings/pwm/pwm-amlogic.yaml       |   4 +
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 364 +++++++++++++++++++++
 2 files changed, 368 insertions(+)
---
base-commit: ad40aff1edffeccc412cde93894196dca7bc739e
change-id: 20240906-c3-pwm-d17072517826

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



