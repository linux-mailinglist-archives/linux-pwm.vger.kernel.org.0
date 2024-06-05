Return-Path: <linux-pwm+bounces-2343-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6B38FC1F4
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 04:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10D31F23222
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 02:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5C61FFE;
	Wed,  5 Jun 2024 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIy5GOnE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983D184E;
	Wed,  5 Jun 2024 02:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555501; cv=none; b=op48QOgEI8A1A93ApHUVqnwpAWicCvZOxK7QCqyczz/4sZyO6Gr0kXLdtoXCkT0MhypE00da5iCizQqOYMEz6ODjZDHbEARhXrutmxbtDbBrCt3puU5ihwSjeCVPUrTXbHru2tb5TSQv1fzG4SyqcWJ8pUSM0NgXD5aKa0nTx3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555501; c=relaxed/simple;
	bh=cLv+hU1PT81IObLXKDBLkjzJCQUWh86T/crgT79hhdQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WUakWrZMtgh5GsKbmN/QJuEavbXUZ5eGj07a/upPgSWc4E3P4kJ0Lz0I750YxybYMLpuhMPEv4Q7u7m14Y3fE08E+CE2Ftf8BO89fgLi3k718Eq0sDAVoRbM0umn68huBLG/ygJSufrCat7dRguHj7h75ksljsbpXlJL7Kiq+3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIy5GOnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E640C2BBFC;
	Wed,  5 Jun 2024 02:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717555500;
	bh=cLv+hU1PT81IObLXKDBLkjzJCQUWh86T/crgT79hhdQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MIy5GOnEK6nKk2Ux3Q047E5CQBY+tDMZZtlT0TfWfIONIAtgrgT2dtEj4B0A0gXth
	 ATnJJOmhR1L4P5k9B2zNPFqeW49DipSFPr5rQlt2AlDfmumwrB089HWregOGgnDo6N
	 aw2WF3bfDIFP6ZLyI+GLV4a4tQbu3eamtY5Rw5e2vO03856Dzlu9X0FW3Xe3ZubyqU
	 f7orPuu09sePvZgcG9M/nmlnQeTaCHTbdllWXDBwjCz4HpGxBltNw4gwRFyGTYbBZC
	 Zgmii/NFKO0yr6Wf8d8lN0jBjvlzUMG4lW5Hbj/OWuqBzdzD7quKknB39WFLpc6pqT
	 h/Z2t+gcntX8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54219C27C54;
	Wed,  5 Jun 2024 02:45:00 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Subject: [PATCH v7 0/2] Add support for Amlogic S4 PWM
Date: Wed, 05 Jun 2024 10:44:54 +0800
Message-Id: <20240605-s4-pwm-v7-0-e822b271d7b0@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACfRX2YC/2XNTQ7CIBCG4as0rMVMp5SKK+9hXBAYWhL7EzBV0
 /Tu0i6qsctvwvMysUjBU2TnbGKBRh9936VRHTJmGt3VxL1NmyGgAIGCR8GHZ8vRVqDUSRpNxNL
 jIZDzrzV0vaXd+Pjow3vtjmK57hKj4MCJEMk5K8DCRbf3vvbmaPqWLZGx/MIS8w2WCYJRuSudL
 tDYPZS/UG1QJogVOFmAUA7/fpzn+QNi2SjkEAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717555496; l=1446;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=cLv+hU1PT81IObLXKDBLkjzJCQUWh86T/crgT79hhdQ=;
 b=wMU0AqOpojggxkgYVyGOUVH5wqws3gXc/InRdro0/5QWNYeapYskxyO7vDK8TdYFIDz8lxoLx
 /y4sXyNIrCXA+75/yXMzNRFBFodb0WC5XuzjZj7sbi+ABfEtmyLxcxL
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

Add support for Amlogic S4 PWM, including the driver and DTS.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
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
 drivers/pwm/pwm-meson.c                   |  36 ++++++
 2 files changed, 235 insertions(+)
---
base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
change-id: 20240424-s4-pwm-2d709986caee

Best regards,
-- 
Kelvin Zhang <kelvin.zhang@amlogic.com>



