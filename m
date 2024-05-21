Return-Path: <linux-pwm+bounces-2199-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625B98CA9F9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 10:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF5D1C2017C
	for <lists+linux-pwm@lfdr.de>; Tue, 21 May 2024 08:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C4755C33;
	Tue, 21 May 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVMAu9sp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6254BDB;
	Tue, 21 May 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280318; cv=none; b=YnfWY6kIVtJ66Ft/I5wEW+FN91WxalnoKCmfyE87RAqhOA5tbU3bNdxLQffv8z5Y6Up4lFxqZuAEp3DK70bPoqZgXmhTnBhN9+1TXcmXpkUALY7NiI6UdvvhdziCMNRp01i/QeMirIqAgIJmrLiPp5gcf3+Z/xa/WAWWmmlTDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280318; c=relaxed/simple;
	bh=8sDFlj1Gwr4M6++unKHbhg9lGquHLfbGNCat/SHDtO8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EkLcE01lAjnkETKHDFV4FJwWfAVySMWtU/V5FYvNerwbX5mL5e4aDkMl+778Nz5Bkyy3AaEbJbf/YeKL2b+SvFapddMEmYhFvkIOhboPF1EjuXKQPvoLUyL7HO6jfDUKu3cf77+7W2CRmf9KUgVY3He6Z+f91rizZNZmLZ5DoP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVMAu9sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 645DCC2BD11;
	Tue, 21 May 2024 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716280318;
	bh=8sDFlj1Gwr4M6++unKHbhg9lGquHLfbGNCat/SHDtO8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EVMAu9spISPmj5wcZir1ZwC8EOT2723ZPfJRyPHsI7UPgZBbnJBeqVihe8T8SW/e9
	 0VWMpGRIEiWQnxynFJLeJ0sLD67YmuLHcBzsS7IhIqXlJZiVA8W7k/5odJU7v8w82Y
	 YYl4RSLBxegny9KQT4CjK1ckHu+BfDPKqcO4kC9MGwEm/OIwgeLhVQIiEvU9Rvk/u4
	 Js+UgkngSCZRA/ZVuYsndMM1yJIvBc3CApIW+GROkW4C7XMy//bO8lcESoqruTDPUF
	 Ct+Y+9Z9tth8mC/FLYXEY7u4Qo69BhbI9504GYHeA/RtvrHupwckqnB1BiG3o/5Nih
	 8D+uMZ1Eb6hiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4892BC25B75;
	Tue, 21 May 2024 08:31:58 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH v5 0/2] Add support for Amlogic S4 PWM
Date: Tue, 21 May 2024 16:31:33 +0800
Message-Id: <20240521-s4-pwm-v5-0-0c91f5fa32cd@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOVbTGYC/2XMywrCMBCF4VcpszYyhPFSV76HdBGSSTtgmpKUq
 JS8u7Fbl//h8G2QOQlnuHUbJC6SJc4tTocO7GTmkZW41qBRE5ImlUktr6C0u2DfX8/WMEM7L4m
 9vHfoMbSeJK8xfXa30G/9IwopVMxas/eO0OHdhGccxR5tDDDUWr8Le7g+ngAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716280316; l=802;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=8sDFlj1Gwr4M6++unKHbhg9lGquHLfbGNCat/SHDtO8=;
 b=KKSNn/ElfAgYrD7BO58I3c5C8vB5uGsP6pt7ktkMU4BuQE/FsH8XzspsgB5ryJpTkuh7AF31j
 RUpIylqtVOBDRnzK1f+s/NeZHkzNcF3E/mMKJ0suVlIDZCdvvFsrNEQ
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add support for Amlogic S4 PWM and related device nodes.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
Changes in v5:
- Add devm_add_action_or_reset for free clk when unloading.
- Replace the underscores of node name with dashes.
- Link to v4: https://lore.kernel.org/r/20240424-s4-pwm-v4-0-ee22effd40d0@amlogic.com

---
Junyi Zhao (2):
      pwm: meson: Add support for Amlogic S4 PWM
      arm64: dts: amlogic: Add Amlogic S4 PWM

 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 207 ++++++++++++++++++++++++++++++
 drivers/pwm/pwm-meson.c                   |  53 ++++++++
 2 files changed, 260 insertions(+)
---
base-commit: 124cfbcd6d185d4f50be02d5f5afe61578916773
change-id: 20240424-s4-pwm-2d709986caee

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



