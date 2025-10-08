Return-Path: <linux-pwm+bounces-7412-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8606BC5B77
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 325194FB111
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E36A2F9C3E;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI0c4fZh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B41369B4;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937627; cv=none; b=QbTI/fO6GDTIUfjG9jU8Im7XHANUP3X9aCLg5zTyZ8gZX/r4f5F5bYsq3liotZZjFv0M+l/n9GkopOjjCc84fnUgARNt1R/JFs5BqDVWQfV9VvUXxo5kgw0uizzNFZJ1jDb+qUUoKt6QyZbUrrNrC8+rBjKAbUydLwGLggQI+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937627; c=relaxed/simple;
	bh=QfGqpBO4FfrWk/eVdia6596gto9Cjc58rAAt6MPwwhY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OY2WwV1Io+H8KN2pYQFn4d3f1If8oLE7CrZjMBAQIHpFQstQ9yoryy/fZfRxV720JZ52ysnA9uCTFRkizVn/jsQ7oWQA5ob0c0GlsBQehVngNVDARzro9fGV+graczlFaLm5XVTb1qX6ILRoOGW+KTEaau3vb1khkSFwCMkOGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI0c4fZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A106FC4CEE7;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759937626;
	bh=QfGqpBO4FfrWk/eVdia6596gto9Cjc58rAAt6MPwwhY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FI0c4fZhdkh/s7/oe0A8Q+rtDUs7iKnx+rKQPY6/9HzHFrAI4J3YpcP4UYINsyaGX
	 /EnN75pZzDlDq5KZo/xf49d7qHyt6BzTr1bjkjnyBU5xcjcfy6TPlhg3WL7Qq9ekVz
	 zXqpmB+WmS793azREEIb8jl2eY2BBK08ptTNbDuciyk2+o8uPuRm0Yf3Kx6jh17KwW
	 wlHDY5wu0DoxFXVcKiKrktCqSzCje/GOghwh91PBR/ucrXqzZf99qKOwcI/eDm4A1E
	 U/KAf6AVUQzOjBQbd4jobkKwTwTP/iAawVPvSBZSOIGvaCmLRDTZrXW1Rw52IfmV8t
	 TI8nv1jYfylog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857CACCA472;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v17 0/9] Add PWM support for IPQ chipsets
Date: Wed, 08 Oct 2025 19:32:52 +0400
Message-Id: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACSE5mgC/z2O3Q6CMAxGX8Xs2pJuMIZe8R6GGDKGNAob40cJ4
 d0dJHp52q+n38oG48kM7HpamTczDWS7AFydT0w3ZfcwQFUYMIFC4kUIINeDe7egM62k5omqpGA
 h7byp6XOobkXg2tsWxsab8ncfc0TJU5QSI5GIGJUEDv1E+l6F187Tku9EnY60bXdpQ8No/XLUm
 3m6u48mwcT/TcICEGLEWsTKoEmz3E7jy9rnoSm2bfsCOrm5DugAAAA=
X-Change-ID: 20250922-ipq-pwm-c8c75c147d52
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Baruch Siach <baruch.siach@siklu.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759937622; l=5394;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=QfGqpBO4FfrWk/eVdia6596gto9Cjc58rAAt6MPwwhY=;
 b=lX1OIMEtBM7ozehqeqSVroqzVhRmgLIu1EjlE12sxYg8KEc5VWGOFfcBOURtqsrcCTf+dSlt/
 ptwsWxF/xrQC/FtM6Gjgn+BwQhDcYz1HYzvQJQz3lTmRiJpuf5mPm/U
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

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Changes in v17:
- Picked up RB tags from Dmitry and Rob
- Removed unnecessary code comments
- Corrected reg property in PWM node in ipq6018 DTS in line with
  expected nr of bytes for address and size cells
- Link to v16: https://lore.kernel.org/r/20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com

Changes in v16:
- Removed reg description in bindings as the offset is not relative to
  the TCSR region anymore since simple-mfd support was dropped and PWM
  nodes defined as their own nodes, not child nodes. Updated the example
  too.
- Dropped patch to add simple-mfd support to the qcom,tcsr bindings
- Simplified code to calculate divs and duty cycle as per Uwe's comments
- Removed unused pwm_chip struct from ipq_pwm_chip struct
- Removed unnecessary cast as per Uwe's comment
- Replaced devm_clk_get & clk_prepare_enable by devm_clk_get_enabled
- Replaced pwmchip_add by devm_pwmchip_add and removed .remove function
- Removed .owner from driver struct
- Added compatibles to the bindings and nodes to the device trees to add
  PWM support in the IPQ5018, IPQ5332, and IPQ9574 SoCs
- Link to v15: https://lore.kernel.org/r/20231005160550.2423075-1-quic_devipriy@quicinc.com

Changes in v15:
- No change
- Link to v14: https://lore.kernel.org/r/20231005033053.2626465-1-quic_devipriy@quicinc.com

Changes in v14:
- Picked up the R-b tag
- Link to v13: https://lore.kernel.org/r/20231004090449.256229-1-quic_devipriy@quicinc.com

Changes in v13:
- Updated the file name to match the compatible
- Sorted the properties and updated the order in the required field
- Dropped the syscon node from examples
- Link to v12: https://lore.kernel.org/r/20230925065915.3467964-1-quic_devipriy@quicinc.com

Changes in v12:
- Picked up the R-b tag

Changes in v11:
- No change

Changes in v10:
- No change

Changes in v9:
- Add 'ranges' property to example (Rob)
- Drop label in example (Rob)

Changes in v8:
- Add size cell to 'reg' (Rob)

Changes in v7:
- Use 'reg' instead of 'offset' (Rob)
- Drop 'clock-names' and 'assigned-clock*' (Bjorn)
- Use single cell address/size in example node (Bjorn)
- Move '#pwm-cells' lower in example node (Bjorn)
- List 'reg' as required

Changes in v6:
- Device node is child of TCSR; remove phandle (Rob Herring)
- Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)

Changes in v5:
- Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
    Andersson, Kathiravan T)

Changes in v4:
- Update the binding example node as well (Rob Herring's bot)

Changes in v3:
- s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

Changes in v2:
- Make #pwm-cells const (Rob Herring)

---
George Moussalem (6):
      dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq5018
      dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq5332
      dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq9574
      arm64: dts: qcom: ipq5018: add pwm node
      arm64: dts: qcom: ipq5332: add pwm node
      arm64: dts: qcom: ipq9574: add pwm node

Devi Priya (3):
      dt-bindings: pwm: add IPQ6018 binding
      pwm: driver for qualcomm ipq6018 pwm block
      arm64: dts: qcom: ipq6018: add pwm node

 .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  |  51 +++++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  10 +
 drivers/pwm/Kconfig                                |  12 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-ipq.c                              | 212 +++++++++++++++++++++
 8 files changed, 316 insertions(+)
---

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
 drivers/pwm/pwm-ipq.c                              | 212 +++++++++++++++++++++
 8 files changed, 316 insertions(+)
---
base-commit: 4711da77d9dc21e8c3c49fa9664ad6113a02237e
change-id: 20250922-ipq-pwm-c8c75c147d52

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



