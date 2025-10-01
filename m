Return-Path: <linux-pwm+bounces-7383-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B39BB2140
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Oct 2025 01:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC174C0E01
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 23:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A3A2BDC0C;
	Wed,  1 Oct 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJgQigYw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7014A4CC;
	Wed,  1 Oct 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759362134; cv=none; b=eENvH+m3/xzuMxdiQAHwH97Nsizxrkvu5L4Cn+dqvXOMpIBzwpZiTDdS7NG4gJcdOczgpQMN8howJ2G7u5iIbnY0nTxKltlZ3lKV1DpncYuPc9aNLZU3dFvMhz3bNzIxjX+d6JDylM/r5MxTZ5wiHrhMbK8ic5ruKLxH4MNVU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759362134; c=relaxed/simple;
	bh=56Q3mKCX5WNb0zWYZjwIbTPOM9CZ0gwVrw1wqhQJrKI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=XGlRtXJk9EB06VOvR2WaaPSayjf1KSkWiHJVdqX41w99omMiT2KOQatSJO2cgJfIXf2jlUBR2fQ9VHwYaoe+iDBdoY0aE4JBTGswkXb8VEj2JWxvBnkyz8VQVcDQ96zdFDukSYCxoU4m5maDiZfGEeyf5yBCX1zpoTqYW8wI/pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJgQigYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E96CC4CEF5;
	Wed,  1 Oct 2025 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759362134;
	bh=56Q3mKCX5WNb0zWYZjwIbTPOM9CZ0gwVrw1wqhQJrKI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=XJgQigYw532nfL1FqUz9yrdRItxPUDJhR0WRtrM2Tqx/tYB4vSC9dDXau8xv8qJdu
	 lkhwfTA1UQxLosGWMweB89CKn+iXKyuBpOX43LDvPjyC/mxsisjm8Pql94Ibk6Htu0
	 Ipyx4lJRgxhnsxW6r88N0V70U/jgj5+TEW29+ZmXMuMff7kdzdcCZDvrk6SqUeqvMu
	 xfDHoMgLoYHxEXhnGeRivsqsLAvm/jUIAGxovLCfiNP3Bp1g5G6JuJLQsATr96iLT4
	 EYvdw+v8DCFrAK6aJfq9UMvRJtEZtrUIWH2U/CIS1o03994hJ96DOIsjxBJQ0ihYR4
	 9zisiHQGXIiOA==
Date: Wed, 01 Oct 2025 18:42:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Baruch Siach <baruch.siach@siklu.com>, Baruch Siach <baruch@tkos.co.il>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Devi Priya <quic_devipriy@quicinc.com>
To: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
Message-Id: <175936202881.2426650.1624694657690403545.robh@kernel.org>
Subject: Re: [PATCH v16 0/9] Add PWM support for IPQ chipsets


On Wed, 01 Oct 2025 18:04:16 +0400, George Moussalem wrote:
> Add PWM driver and binding support for IPQ chipsets.
> Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
> ipq9574.
> 
> I've picked up work based on Devi's last submission (v15) which dates
> back to 05 October 2023 as below SoCs are still active.
> 
> V16:
> 
>   Removed reg description in bindings as the offset is not relative to
>   the TCSR region anymore since simple-mfd support was dropped and PWM
>   nodes defined as their own nodes, not child nodes. Updated the example
>   too.
> 
>   Dropped patch to add simple-mfd support to the qcom,tcsr bindings
> 
>   Simplified code to calculate divs and duty cycle as per Uwe's comments
> 
>   Removed unused pwm_chip struct from ipq_pwm_chip struct
> 
>   Removed unnecessary cast as per Uwe's comment
> 
>   Replaced devm_clk_get & clk_prepare_enable by devm_clk_get_enabled
> 
>   Replaced pwmchip_add by devm_pwmchip_add and removed .remove function
> 
>   Removed .owner from driver struct
> 
>   Added compatibles to the bindings and nodes to the device trees to add
>   PWM support PWM in the IPQ5018, IPQ5332, and IPQ9574 SoCs
> 
> v15:
> 
>   No change
> 
> v14:
> 
>   Picked up the R-b tag
> 
> v13:
> 
>   Updated the file name to match the compatible
> 
>   Sorted the properties and updated the order in the required field
> 
>   Dropped the syscon node from examples
> 
> v12:
> 
>   Picked up the R-b tag
> 
> v11:
> 
>   No change
> 
> v10:
> 
>   No change
> 
> v9:
> 
>   Add 'ranges' property to example (Rob)
> 
>   Drop label in example (Rob)
> 
> v8:
> 
>   Add size cell to 'reg' (Rob)
> 
> v7:
> 
>   Use 'reg' instead of 'offset' (Rob)
> 
>   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> 
>   Use single cell address/size in example node (Bjorn)
> 
>   Move '#pwm-cells' lower in example node (Bjorn)
> 
>   List 'reg' as required
> 
> v6:
> 
>   Device node is child of TCSR; remove phandle (Rob Herring)
> 
>   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)
> 
> v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
>     Andersson, Kathiravan T)
> 
> v4: Update the binding example node as well (Rob Herring's bot)
> 
> v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> 
> v2: Make #pwm-cells const (Rob Herring)
> 
> V15:
> Detailed Change logs are added to the respective patches.
> 
> V14 can be found at:
> https://lore.kernel.org/linux-arm-msm/20231005043127.2690639-1-quic_devipriy@quicinc.com/
> 
> Devi Priya (4):
>   pwm: driver for qualcomm ipq6018 pwm block
>   dt-bindings: pwm: add IPQ6018 binding
>   dt-bindings: mfd: qcom,tcsr: Add simple-mfd support for IPQ6018
>   arm64: dts: qcom: ipq6018: add pwm node
> 
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 112 +++++--
>  .../bindings/pwm/qcom,ipq6018-pwm.yaml        |  45 +++
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  15 +-
>  drivers/pwm/Kconfig                           |  12 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-ipq.c                         | 282 ++++++++++++++++++
>  6 files changed, 435 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-ipq.c
> 
> --
> 2.34.1
> 
> ---
> Devi Priya (3):
>       dt-bindings: pwm: add IPQ6018 binding
>       pwm: driver for qualcomm ipq6018 pwm block
>       arm64: dts: qcom: ipq6018: add pwm node
> 
> George Moussalem (6):
>       dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq5018
>       dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq5332
>       dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible for ipq9574
>       arm64: dts: qcom: ipq5018: add pwm node
>       arm64: dts: qcom: ipq5332: add pwm node
>       arm64: dts: qcom: ipq9574: add pwm node
> 
>  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  |  51 +++++
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi              |  10 +
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi              |  10 +
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  10 +
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  10 +
>  drivers/pwm/Kconfig                                |  12 ++
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-ipq.c                              | 214 +++++++++++++++++++++
>  8 files changed, 318 insertions(+)
> ---
> base-commit: 846bd2225ec3cfa8be046655e02b9457ed41973e
> change-id: 20250922-ipq-pwm-c8c75c147d52
> 
> Best regards,
> --
> George Moussalem <george.moussalem@outlook.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: using specified base-commit 846bd2225ec3cfa8be046655e02b9457ed41973e

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/qcom/' for 20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com:

arch/arm64/boot/dts/qcom/ipq6018.dtsi:418.4-28: Warning (reg_format): /soc@0/pwm@1941010:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 2)
arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: soc@0 (simple-bus): pwm@1941010:reg:0: [26480656, 32] is too short
	from schema $id: http://devicetree.org/schemas/reg.yaml#






