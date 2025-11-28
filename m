Return-Path: <linux-pwm+bounces-7720-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C829C91A25
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 11:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A54D346C62
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CBD30BF66;
	Fri, 28 Nov 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2ODpLdl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EFE30B515;
	Fri, 28 Nov 2025 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325763; cv=none; b=l5M81s5Y+TaZmH75o4OJWOOHJSUXZw97u6jEKVmvQRTtfB35fIA2Elxze0rSXZAckRxYlVabSy6VCfq4bKClDvyAA1RHuFll7alFtxXBQM5iaW2eBKA45KkgiBJgponLT5T8nOSums085c5bRzRaAPdJM++8J73nBWj3HShlYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325763; c=relaxed/simple;
	bh=UAdMTYVBsBNbXk/Og0eSznO5zDi4I0I2Y1uL6nPcnLo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gnctjzkRVEc/wPlAExH4Vh+2dqyFL1QUPuz04vvEZ6uDcf2GPF9rq7lfXRzhgmeGusW8pOGBHWgXtEKAEjZqzkRSouYKcz+JV57biPmzd3WLAAMH9WCUubai0rsBdhjOdKehK7G9AX7L3CWz6Ru/hSbHKOLnuD3ai7ePHBHN5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2ODpLdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A62CFC4CEF1;
	Fri, 28 Nov 2025 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764325762;
	bh=UAdMTYVBsBNbXk/Og0eSznO5zDi4I0I2Y1uL6nPcnLo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=N2ODpLdlZwP+TDz0Sam1++zyyQFOVWlvgiAu1VTFdFcYD6v3vP9+JYxlPwuWU+m06
	 DCW60O4ik2i2BDyTUHfpS+dy6M0k8Dv2pqQFPv8Gra4R+M4Q40noOV1652uWdjYmwu
	 2qPfmiZXAzvg+ZhuGIgaQP2ckkjfPcVRz/aOQpJk0XHIZGXqKSXrInKAoylO9t1MB0
	 N4EDL4tAhumUSniDiaZ7Sw/Vrm4nw0iPbz0txDzPEdyHvGmL6HhNcFrqxJ5a/4qa2p
	 QX1niwMhAEa9/RV7KBmkQ5Q7konK54rSS8vSLtd7ClwJKt1Lp4VooSI6n7M5795hjX
	 4QkEVLEbwbvOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF9D116E2;
	Fri, 28 Nov 2025 10:29:22 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v19 0/6] Add PWM support for IPQ chipsets
Date: Fri, 28 Nov 2025 14:29:12 +0400
Message-Id: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHh5KWkC/22O0W6DMAxFf6XK81I5CSGhT/2PqppK4gxrg9BAW
 auKf29A2sSkPV7b5/g+2YCJcGCH3ZMlnGig2OUgqrcdc82l+0BOPg+YBKmhkpJTf+X9d8uddUY
 7URivJcvXfcJA91V1OuccUmz52CS8/PBKAGhRgtawl4VUYDQX/Hoj9+7z6z7R47gk6tzexXaRN
 jSMMT3WepMoF/faJJvEb5O84MAVQJDKIGBpj/E2fsX4uWqWMpMwW9ZuWJPZqvaFQh+cCeYf1m5
 YWW1Ym1n0NQaLoa4t/mXneX4Bl743AWABAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764325760; l=6711;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=UAdMTYVBsBNbXk/Og0eSznO5zDi4I0I2Y1uL6nPcnLo=;
 b=gWI9mpKgpavSFSWg0DtSwQ8yEo0P2JFddT9ymaCWdcz/rJdWSXg4ItUAQMOrMKPvJF8w7fzGq
 pw1hy5DLfMUC78Bn9p8HP55a8rGWECgtAiY4hV6U4Rs0wKblLG8RKvk
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
Changes in v19:
- Changed pwm-cells property in dt bindings from 2 to 3 as per Uwe's
  recommendation
- Added hardware notes and limitations based on own findings as
  requested. NOTE: there's no publically available datasheet though.
- Expanded comment on REG1_UPDATE to indicate that when this bit is set,
  values for div and pre-div take effect. The hardware automatically
  unsets it when the change is completed.
- Added newline between MACRO definition and next comment
- In config_div_and_duty, used mul_u64_u64_div_u64 to avoid overflow
- Removed unncessary restriction of pwm_div to MAX_DIV - 1 after testing
- Constrain pre_div to MAX_DIV is pre_div calculated is > MAX_DIV
- Use of mul_u64_u64_div_u64 in .apply
- Skip calculation of period and duty cycle when PWM_ENABLE REG is unset
- Set duty cycle to period value when calculated duty cycle > period to
  return a valid config
- Removed .npwm as it's taken care of in devm_pwmchip_alloc
- Added call to devm_clk_rate_exclusive_get to lock the clock rate
- Start all kernel messages with a capital letter and end with \n.
- Changed pwm-cells property in all dtsi from 2->3 for in scope IPQ SOCs 
- Link to v18: https://lore.kernel.org/r/20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com

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
 drivers/pwm/pwm-ipq.c                              | 239 +++++++++++++++++++++
 8 files changed, 343 insertions(+)
---
base-commit: e15625dc543c0fbb8db84589678613efd6fd4f27
change-id: 20250922-ipq-pwm-c8c75c147d52

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



