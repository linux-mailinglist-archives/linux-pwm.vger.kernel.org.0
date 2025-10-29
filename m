Return-Path: <linux-pwm+bounces-7521-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C46C192E0
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 09:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E380582319
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6F314B85;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3cljkLO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B08311951;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727038; cv=none; b=HYqOEYMvI1iZ+s4d0GS75CR4ixiSS63B8BITa9M+BWeIG92GRcOMaebEJsOJEA6wI7rDoZwhyuXio497NtcQzy39xBx7bzOWMaLI6fitGsyLCFK6cIz8ao2MmNfV5fEbOJzvwjnprTDQGZutRoGy6p5ZvM38jsWzeNiPPiWfyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727038; c=relaxed/simple;
	bh=g3PLnFhIAD3MPzFWZaC1yc/r/jWqxyVn09enL7OcU/g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GZZA3jH8ZsjeWrOF/vdfBstg63l39RZYMq6NZRTAKlH4alc/ohHOf6qG+eaeW7IKorJQHh4pDm1saRDZJSqUU+6vy3q/3boWdC3eH/Km7qKxddDeIx8pXEkC/q6+y4Bwc00GF3j1Rjk+QO3enaaoy3UXETllxwr+eaEnO78Q+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3cljkLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7E49C4CEFB;
	Wed, 29 Oct 2025 08:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727038;
	bh=g3PLnFhIAD3MPzFWZaC1yc/r/jWqxyVn09enL7OcU/g=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=B3cljkLOJkZ7GGmsem04/p+bQSiau+rBpT2ewEQj9+Bxyaka1M8YDuOn+b+ZTukXi
	 n6SOaQjw2+xUUhH9VRRwZfOeSdF61/5KqmlCeya8YsU0+NE3XZWixd4SgS2eQgqm+O
	 1ZYgEfeMfCdeqTKgaSo246ZfRDYq1Qrd9aq/OExDl2WcRcE704HJ5myGun7snH9cyX
	 Yoon2p6MY2M319crm73mQoJwSLpzvk1jB9Xy+TYzDYAdHvpXgti3euey09kfrmCuB9
	 qpmEjvNKD1Cto7qsTamhgqmtTNJcAIVxwtT/yOrqSf5L5doKoQbSLw7SpN7KyiNpU0
	 IYkxaKh1r5+pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA45CCF9E9;
	Wed, 29 Oct 2025 08:37:17 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v18 0/6] Add PWM support for IPQ chipsets
Date: Wed, 29 Oct 2025 12:36:56 +0400
Message-Id: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACjSAWkC/1WO0W7CMAxFfwXleUZO0jSFp/7HNCGWOKu1tSlpK
 UOo/05aCQSP1/Y5vjcxUGIaxH5zE4kmHjh2OcjqYyNcc+x+CNjngVCoDO6UAu5P0F9acJWzxsn
 CeqNEvu4TBf5fVZ9fOYcUWxibRMcHryWikSUag1tVKI3WgITTmd3B59d94mu9JO7c1sV2kTY8j
 DFd13qTLBf32iSb5LNJXgCCRgxKW0Iqqzqex78Yf1fNUmaS9pWtXlib2d23LzT54Gyw7+w8z3c
 BNp6mJAEAAA==
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
 Baruch Siach <baruch.siach@siklu.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727035; l=5438;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=g3PLnFhIAD3MPzFWZaC1yc/r/jWqxyVn09enL7OcU/g=;
 b=CCe8UOTaj4TWXJPneYOO+SCUFX5S7gdMs58LJ5UtRV7X3b9fj2uM1w++vEhUJtCX///OiD599
 MtqA6zBFkSUBUPcUgdiRze1fDN2D5S6mcAMkUeUBzIneV9ytQ1beKnl
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
Changes in v18:
- Updated maintainer info in binding
- Squashed dt bindings patches into the first for adding compatibles for
  IPQ5018, IPQ5332, and IPQ9574
- Link to v17: https://lore.kernel.org/r/20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com

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

George Moussalem (3):
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
base-commit: 56592520a52b43e69e5cf8afa0af032690c70175
change-id: 20250922-ipq-pwm-c8c75c147d52

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



