Return-Path: <linux-pwm+bounces-2283-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 547038D33E5
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD581C2264E
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4059B17B438;
	Wed, 29 May 2024 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+lMm492"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306517B400;
	Wed, 29 May 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976878; cv=none; b=MrtpCT8InvNzw3/xkTTW5kCfcMm55QfYqOhMeUiEs6BTVLrIUZSLsmWVsfLI3YPB5thG8JSm1eoAObJ6nCF+QoM1XYxEvmmjxFhL58lL/hgoxcG6rTOhfh1QsjTI5CpeaFx0/g3UhGzsipf9nbyArnFKy9qmr/4edUwUCretSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976878; c=relaxed/simple;
	bh=a91FxspxlRCfgSu57AGk4ebkLMPvGl9K4zWKW9UVBnU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iSL2ceikzjMKnnRVaO+vWpEtrcmzYjOn+iVQGW8HIthO3RDRzhNwr91E71Ndg5LCL0oIFJXSlWyWX7d6nDYYHmNhAZmtXEHlKo0yXqlQMUHRkwcXtOYpLwZpNCJi9iV5uEfkPh132aKl/SNmOKhLghKmomJwf3V2TLnONz5/GAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+lMm492; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2272C2BD10;
	Wed, 29 May 2024 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976877;
	bh=a91FxspxlRCfgSu57AGk4ebkLMPvGl9K4zWKW9UVBnU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=d+lMm492mXxD569WnYSsqnv7M7bM1QaWTk+8xuzoHl40aQi29EKTiI27LKYczrqQ4
	 89dp7KxTmEgpmPaV6m5FqL3mQm2j6RbUYcwne3EMQFghoCFAnP+wvhzRVpENeofd9x
	 wNs5Cu8fs8BxzF+T8fpn3kYUyEYHigyL0eMleborjI0K3h6TPavimgxDyJuzpdZRB+
	 gnoorDSQyL5ABYGTTduKSO2qQlNiS6Tgh3j4nrnFZ4AbPD65MNEd0JmAs2a+ox2W4l
	 brFX2gvc+4sZH/n2cBIIsHVBLwpW0vQXat0USkHz90jxRs4rJ/v7hJzbXwuflZ+BcQ
	 HfX5HgrUdPKzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FCEC27C43;
	Wed, 29 May 2024 10:01:17 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH v6 0/2] Add support for Amlogic S4 PWM
Date: Wed, 29 May 2024 18:00:55 +0800
Message-Id: <20240529-s4-pwm-v6-0-270f63049f20@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANf8VmYC/2WMQQrCMBBFr1JmbSQdk2pdeQ9xEZJJO2BNSSQqp
 Xc37UIRl+/z35sgUWRKcKwmiJQ5cbgVaDYV2N7cOhLsCgNKVFKhEkmJ8TEIdHvZtofGGiIo5zG
 S5+caOl8K95zuIb7WblbL+pfISkhBhEjeOyWdPJnhGjq2WxsGWCJZf0WN9UfURZS2rb32ZofW/
 YrzPL8BBSOvPdcAAAA=
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716976876; l=1140;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=a91FxspxlRCfgSu57AGk4ebkLMPvGl9K4zWKW9UVBnU=;
 b=/SM+S10/vNZX/3yq/Vv/gVtGFkhrqyd951SBAMUefxD4hriwDQ+A5PQW7I5uW3k6gprCPivv7
 CWOHQUlXHkZC6nYGzPJpAW4cp/lPI3y3ZfKAHt+qBWl+g5u6TG/gmuG
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add support for Amlogic S4 PWM, including the driver and DTS.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
Changes in v6:
- Rename 'pwm_meson_s4_data' to 'pwm_s4_data'.
- Rename 'meson_pwm_init_channels_meson_s4' to 'meson_pwm_init_channels_s4'.
- Adjust the order of the device nodes according to their unit addresses.
- Some minor improvements.
- Link to v5: https://lore.kernel.org/r/20240521-s4-pwm-v5-0-0c91f5fa32cd@amlogic.com

Changes in v5:
- Add devm_add_action_or_reset for free clk when unloading.
- Replace the underscores of node name with dashes.
- Link to v4: https://lore.kernel.org/r/20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com

---
Junyi Zhao (2):
      pwm: meson: Add support for Amlogic S4 PWM
      arm64: dts: amlogic: Add Amlogic S4 PWM

 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 207 ++++++++++++++++++++++++++++++
 drivers/pwm/pwm-meson.c                   |  49 +++++++
 2 files changed, 256 insertions(+)
---
base-commit: 124cfbcd6d185d4f50be02d5f5afe61578916773
change-id: 20240424-s4-pwm-2d709986caee

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



