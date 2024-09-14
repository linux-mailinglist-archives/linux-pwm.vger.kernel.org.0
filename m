Return-Path: <linux-pwm+bounces-3266-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081DB978E14
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 07:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F551C2235C
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 05:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DC29402;
	Sat, 14 Sep 2024 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqwl45c/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AC38B;
	Sat, 14 Sep 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293025; cv=none; b=YMpNnRuNVyQvFBmVM4n/Yv9raSe1Gf2slDM9OAXEs0PyVss/lnw1XGFTu1IywUO1pwxADLmnP8YeYOwZz7qek9D9q1kGVpTVNuSPF91L5VGBi+nViUaGC5vXrmrzkm90p89hyhHD4jegqIKOcPSocQAhm6cvFuutAA+fx/Q6V/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293025; c=relaxed/simple;
	bh=BKPsh9AbBCeenJYCPX7oX8WfRJvUle8s6ls3hVpCebU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GGXjH1rvrLd7fD2dXaO18+jtHlje7BvUk6ovFRToIt9+wLguyjXsvtlYjLYwz7+QY/JRYhm8NkzV1R1CUN+iroa2mKIJhE68eTUEha8tlvOAl94eOHzyWw9XMnIz+UeuuN6/UuaHG927xFbYKnTjFXkvQpAQnieUKMOJNIZADss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqwl45c/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C839C4CEC0;
	Sat, 14 Sep 2024 05:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726293025;
	bh=BKPsh9AbBCeenJYCPX7oX8WfRJvUle8s6ls3hVpCebU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Aqwl45c/QrKHaEL8gKhX5A139atg/1UMUnjb+SupwuMCQ/mh+U27rXkZtc4IQs2Tr
	 frI0MPDOttcAMemi7X3Afi2DDujUcswFxlZt4p1f2TocPMicHWiSg9c3F8TBGOwkGb
	 oArwIML7kAh1chrho+CgwHGXnENJ8LkQ1jT1eCap2f/vgAkOSHO+tVs2bqUrwd67s0
	 8TComHpgcUuXw1wHH2bXP7dlH8A1ZBYCdvYMqDz889yfA7ZInOUnCm/K96jv/WK4vn
	 9YIxwbi/3MXHQ18hcSFJzKOwN0Qu33HMZYYiuD94yqs8YBUAUTPLrifZlYRu8k2J4E
	 HW8FuhrkOSPHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4495FFC6198;
	Sat, 14 Sep 2024 05:50:25 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH v2 0/2] Add support for Amlogic C3 PWM
Date: Sat, 14 Sep 2024 13:48:57 +0800
Message-Id: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMkj5WYC/2XMyw6CMBCF4Vchs3ZMOyJVVr6HYdH0ApMIJa2pG
 tJ3t7J1+Z+cfBskF9kl6JsNosucOCw16NCAmfQyOmRbG0hQK66iQ3PC9TWjlUooOkt1oQ7qeY3
 O83uH7kPtidMzxM/uZvlb/4gsUaA22kvltaVW3fT8CCObowkzDKWUL1JwccueAAAA
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726293023; l=766;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=BKPsh9AbBCeenJYCPX7oX8WfRJvUle8s6ls3hVpCebU=;
 b=M7zDFQVH4PyRCBGJGwTRhqlW4fQuecrW1wLK8H6y9BcOuYuUtVd5HGbe86zO79gE02SLJlND8
 yNIw6/EESi2DZR9eTrgIF3YzxPLUsPArExC6VknPhKT7ly8i/8w49z9
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add support for Amlogic C3 PWM, including the DT binding document and DTS.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
Changes in v2:
- Rebase this patchset due to recent upstream changes.
- Link to v1: https://lore.kernel.org/r/20240906-c3-pwm-v1-0-acaf17fad247@amlogic.com

---
Kelvin Zhang (2):
      dt-bindings: pwm: amlogic: Document C3 PWM
      arm64: dts: amlogic: Add Amlogic C3 PWM

 .../devicetree/bindings/pwm/pwm-amlogic.yaml       |   1 +
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi        | 364 +++++++++++++++++++++
 2 files changed, 365 insertions(+)
---
base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
change-id: 20240906-c3-pwm-d17072517826

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



