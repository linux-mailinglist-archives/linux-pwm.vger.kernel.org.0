Return-Path: <linux-pwm+bounces-7369-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241CBBB09DC
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 16:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A203AC9DE
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B482130277A;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iekGiq3I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F43019DA;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327463; cv=none; b=PePYXiBefH9YjDzPoJ8PZyI7yYlMx0zk8eKAMap2CR5uBFRyKlj8XskEN9HLVknKE1XR8gDE4wHd+tbp17VS3m/P8fv052trF+ER0b0dhaKNLq3ZPRbDlc1nS1KBiZz/l7DCLMMQ/h/PDlJqAXCcYV0yOVAayaqjVjx+yPhnaHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327463; c=relaxed/simple;
	bh=7+BKdybQdA+TbIKKvtFc6vQ+I/JxwRRAUowkGuhh7dA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tcnFtYRNbRti2TXyg6QehN8v5QeGLGiWdFk82GkbqdLkWlKPwThXwuae1BToTk2ax5u/ccxJfXz1vwx9xfX82zvrtXhQeZF8+GgyE4HaLTxCe4Lj3yVg3Q8GncVWqPbZ6vcIJl0y0v1p0LIUKqiJP9BtE+tviv8LsvNwg2BrsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iekGiq3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0545C4CEF1;
	Wed,  1 Oct 2025 14:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327463;
	bh=7+BKdybQdA+TbIKKvtFc6vQ+I/JxwRRAUowkGuhh7dA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iekGiq3I3YSMFaMc1NhJVtYMmJbyAcCFYeXWuAON9/YGVMx2kshIOApJHn+l8izP3
	 xf0Kp+TkxR3a+j9HCDFlBzXrVcwmb+hjEQjJkb/6ALbF9DlCUdFLnuXJdxNnfpTrkO
	 T+UO9KtlqXzvuq80SH2I548s7c7xZ8+0n99DmDJF5ullF6xeonZzrPqG9K2doR80UB
	 Lt0d3tU7nknK/8vpwrcR/ggLmZtIgemoceU3o275ByP8a4CIAWj45v9peFRgeH68nC
	 MCOGrSDjTa2rKedAkT5RXOYDGhe9YQOaFQoAf9U0CDrVjBNPtEXF0E4AD+A/zDZZxm
	 fOkEyVBsmrXGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB10CCA472;
	Wed,  1 Oct 2025 14:04:22 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v16 0/9] Add PWM support for IPQ chipsets
Date: Wed, 01 Oct 2025 18:04:16 +0400
Message-Id: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOA03WgC/zWNzQ6CQAyEX8X0bEm3UFBPvocxhpRFegCWxd8Q3
 t3VxOM3mW9mgdlH8zMcNgtE/7DZxiGBK7cb0K4erh6tSQEwsdCeGS1MGJ496k4rUVdUjTCkdoi
 +tddv6nRO3Maxx1sXff33c0ckriQRyrjgnCpBh9Pd9NKk6xDtffySDZrp2MO6fgAls/aQnwAAA
 A==
X-Change-ID: 20250922-ipq-pwm-c8c75c147d52
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Baruch Siach <baruch.siach@siklu.com>, 
 George Moussalem <george.moussalem@outlook.com>, 
 Bjorn Andersson <andersson@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759327459; l=4387;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=7+BKdybQdA+TbIKKvtFc6vQ+I/JxwRRAUowkGuhh7dA=;
 b=/0tv5ydgdeNWP7z8mhbWkfAZBJKAvz/jLW2yE2D21TSCQcIvgeormrV7z68m6x0LtqKBJbtch
 lMgm/BtqT8xB7oY852gOced/kxRRnBhQ13dOU4N/fccy1KR6MgPlDXk
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

Add PWM driver and binding support for IPQ chipsets.
Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
ipq9574.

I've picked up work based on Devi's last submission (v15) which dates
back to 05 October 2023 as below SoCs are still active.

V16:

  Removed reg description in bindings as the offset is not relative to
  the TCSR region anymore since simple-mfd support was dropped and PWM
  nodes defined as their own nodes, not child nodes. Updated the example
  too.

  Dropped patch to add simple-mfd support to the qcom,tcsr bindings

  Simplified code to calculate divs and duty cycle as per Uwe's comments

  Removed unused pwm_chip struct from ipq_pwm_chip struct

  Removed unnecessary cast as per Uwe's comment

  Replaced devm_clk_get & clk_prepare_enable by devm_clk_get_enabled

  Replaced pwmchip_add by devm_pwmchip_add and removed .remove function

  Removed .owner from driver struct

  Added compatibles to the bindings and nodes to the device trees to add
  PWM support PWM in the IPQ5018, IPQ5332, and IPQ9574 SoCs

v15:

  No change

v14:

  Picked up the R-b tag

v13:

  Updated the file name to match the compatible

  Sorted the properties and updated the order in the required field

  Dropped the syscon node from examples

v12:

  Picked up the R-b tag

v11:

  No change

v10:

  No change

v9:

  Add 'ranges' property to example (Rob)

  Drop label in example (Rob)

v8:

  Add size cell to 'reg' (Rob)

v7:

  Use 'reg' instead of 'offset' (Rob)

  Drop 'clock-names' and 'assigned-clock*' (Bjorn)

  Use single cell address/size in example node (Bjorn)

  Move '#pwm-cells' lower in example node (Bjorn)

  List 'reg' as required

v6:

  Device node is child of TCSR; remove phandle (Rob Herring)

  Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)

v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
    Andersson, Kathiravan T)

v4: Update the binding example node as well (Rob Herring's bot)

v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

v2: Make #pwm-cells const (Rob Herring)

V15:
Detailed Change logs are added to the respective patches.

V14 can be found at:
https://lore.kernel.org/linux-arm-msm/20231005043127.2690639-1-quic_devipriy@quicinc.com/

Devi Priya (4):
  pwm: driver for qualcomm ipq6018 pwm block
  dt-bindings: pwm: add IPQ6018 binding
  dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
  arm64: dts: qcom: ipq6018: add pwm node

 .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 112 +++++--
 .../bindings/pwm/qcom,ipq6018-pwm.yaml        |  45 +++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  15 +-
 drivers/pwm/Kconfig                           |  12 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-ipq.c                         | 282 ++++++++++++++++++
 6 files changed, 435 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
 create mode 100644 drivers/pwm/pwm-ipq.c

--
2.34.1

---
Devi Priya (3):
      dt-bindings: pwm: add IPQ6018 binding
      pwm: driver for qualcomm ipq6018 pwm block
      arm64: dts: qcom: ipq6018: add pwm node

George Moussalem (6):
      dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq5018
      dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq5332
      dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq9574
      arm64: dts: qcom: ipq5018: add pwm node
      arm64: dts: qcom: ipq5332: add pwm node
      arm64: dts: qcom: ipq9574: add pwm node

 .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  |  51 +++++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  10 +
 drivers/pwm/Kconfig                                |  12 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-ipq.c                              | 214 +++++++++++++++++++++
 8 files changed, 318 insertions(+)
---
base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
change-id: 20250922-ipq-pwm-c8c75c147d52

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



