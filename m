Return-Path: <linux-pwm+bounces-2439-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8D906C48
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 13:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE6FB23DDD
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2024 11:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF8145B2E;
	Thu, 13 Jun 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obikWvyD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E980145B27;
	Thu, 13 Jun 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279234; cv=none; b=K0rkQHlXw+PH95NcSfhlsSgi242gsU1/owMsTd6fOvs0Ge3lLFeJUyJ9yWP2Ie1rPeexbpkermw1wCtkEdvpVWL/kyoHetTVj5T4r1uqw/7e1qwQPqLIIwfF0LS5KIwecnFIqTksGQAVhA9GuhrRdxOhLINNTrypLehO+Vy+bJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279234; c=relaxed/simple;
	bh=T7TWzD+8vHETS7BWE/0HH/nm2zj59fwupPU7gNji60w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oDRL2KDDHTE5jlxrSuAynfh12Y6NovyoTizjR7yLMzneXBsDvH9KRUUnG7Ygf6nX+wzOZ7U4421a4wJ43qDPhqsbGuAWTj/YfoKkMUG8ABlDswxS9sGWnxIoy46MjyDWmv/7piMbwFJwjR3JUdi8WCtpcOpfSPC4r9vuqt+vfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obikWvyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C44EBC32786;
	Thu, 13 Jun 2024 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718279233;
	bh=T7TWzD+8vHETS7BWE/0HH/nm2zj59fwupPU7gNji60w=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=obikWvyDmDzPeg19DdKwLgtvwzb/Co3u6f5GnVyyMsccUsobCezJVNmXIfZK1MVYm
	 +qiHPiS1gm0Yf7BGvg/S+lHYfkQHAADiJ76KWGlMvCJoJj37Bz1wQ2c9DSOx4bBzUj
	 2yb3O7ybOTnoWr/hZcXk2bFihYXQ9TszQWGUvfP9AbKQSzfIO7ydfCdEsFbEQV/+L7
	 pn9lqSoz0k741WSkkCj/Cm5kof05x+i9OqahYELxVCX8UM4oPi83qySnxuyBV7NKSH
	 3LAM1PR1wH1yqcnlRgTZDyqXHQOcV2bGxoyzPlglUnD+aRn3EYLXDqTJgydSjIF/yt
	 +iPBCt8FVB9IA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD88C27C75;
	Thu, 13 Jun 2024 11:47:13 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH v8 0/2] Add support for Amlogic S4 PWM
Date: Thu, 13 Jun 2024 19:46:34 +0800
Message-Id: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABrcamYC/23OTQ6CMBAF4KuYrq0Zxv5QV97DuIB2Kk0EDDWoI
 dzdwgKMunyT+d7MwCJ1gSI7bAbWUR9iaJsU8u2G2apoLsSDS5khoACBgkfBb4+ao9NgTK5sQcT
 S8q0jH55z0emcchXive1ec28vpulPRS84cCJE8t4JcHAs6mt7CXZn25pNJb1cocRsgTJBsCbz0
 hd7tO4Xqk9oFqgSRA1e7UEYj38u6hUqkAvU06s5Yok6c7r8guM4vgEt6maCSQEAAA==
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Junyi Zhao <junyi.zhao@amlogic.com>, 
 George Stark <gnstark@salutedevices.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718279231; l=1661;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=T7TWzD+8vHETS7BWE/0HH/nm2zj59fwupPU7gNji60w=;
 b=6BkebCfy1cxhNBjMU7JUMIjFTx2FvQuZKQkcIZQSSMDT80mg963Ob1A//ow23qj58oSLHsmf4
 4axa/XhAwEwAR6gyhqR5rrIc3duQr8O38mflObgm8Gn/ViG+Gsj4h1M
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add support for Amlogic S4 PWM, including the driver and DTS.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
Changes in v8:
- Return dev_err_probe() in meson_pwm_init_channels_s4().
- Check the result of devm_add_action_or_reset().
- Link to v7: https://lore.kernel.org/r/20240605-s4-pwm-v7-0-e822b271d7b0@amlogic.com

Changes in v7:
- Put devm_add_action_or_reset() into the for loop.
- Remove the error handling of meson_pwm_init_channels_s4().
- Remove the repeated device node 'pwm-a-pins'.
- Some minor fixes and improvements.
- Link to v6: https://lore.kernel.org/r/20240529-s4-pwm-v6-0-270f63049f20@amlogic.com

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

 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 199 ++++++++++++++++++++++++++++++
 drivers/pwm/pwm-meson.c                   |  39 ++++++
 2 files changed, 238 insertions(+)
---
base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
change-id: 20240424-s4-pwm-2d709986caee

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



