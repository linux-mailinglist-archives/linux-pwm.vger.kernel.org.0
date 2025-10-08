Return-Path: <linux-pwm+bounces-7417-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640F7BC5DE2
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 17:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029B3425B2C
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90EF2FB96A;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqOxRcfa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260A2FA0C6;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937627; cv=none; b=nq9aqvT7lDM5mGGg7+SqhfXUN20KYGgZdxtbmL8hoRIyVSYSl6Wk9/1Km0eoIWE3LnyB68rvkSlThHHKS8wV438zuVBedRlDvZ3odZ68DR+Kp5briqBeQ1xYg/mvufuvZMRuDD0pA1vCZ8kkPj6VQinpH1QROs0BjiyEUCcczlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937627; c=relaxed/simple;
	bh=17jHRnynMi8fb/tCT5jWG4U5l21xzqOHR0+glWmEBMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlKA0UQqHQ3at2I5DAZ49QSHsb4fz5IP4hrV7jiElEJ7CIjzhui/dMZrgnlhRC8FBwHOfiR5bxD/+MlZlqJrq6XG7IbTGyLWA7quR1YIj4H3D4ms2huG38Z6Kf5mc5cVf1oHI7Zwl9/iGX2ZD3OcGOmzVG8AkMdmnFtL3Rfq2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqOxRcfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CB43C19422;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759937627;
	bh=17jHRnynMi8fb/tCT5jWG4U5l21xzqOHR0+glWmEBMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WqOxRcfaIk4WYLB8XWdY7u8ePBast8t8HTlXMT2qjjdatAEnfWM14QNjQdyJ3QAVm
	 I9b8ZQadZ+A2oOT+dFXvgTRktXOQfabeyEA/LvWkRdUfYWJv9k8/PJ1ypGK8XKiCYm
	 ZZwedHqaGe7r158+EdlptQw8on+KGqAxUmZ2Od1RJYDIb/Y7bN1vChOsojbEBQNf5N
	 8ZARxD++9bcjmyNECXcM3nP0UacAcmwjn0xzJaKQVHjM/rJIp6iNUburB2BtfEZ1h4
	 8x4DwdwB77Vfxt1EZlii6CR1X9o/mga4Cvi0BpfTikhHbdBjdRSLkvkHfH7nHFv/QO
	 5pBITMunfLaYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03825CCD183;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 08 Oct 2025 19:33:00 +0400
Subject: [PATCH v17 8/9] arm64: dts: qcom: ipq5332: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-ipq-pwm-v17-8-9bd43edfc7f7@outlook.com>
References: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
In-Reply-To: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759937623; l=1253;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=e3rNVi2zON87okZlfd1mnPPujU2uXXwCmlIqEOFb5CY=;
 b=fYPZ95JzsPZMYOOb124LNlFTu7TbrfUF7vppu3WzXVTi6VknWvLdUVZWkmUl9CBztwaP4GpCY
 SROtHqXbWoGBgdMrREXu81hrTOFILb1kAT76FZgYeZX3yCiXjTuRvcZ
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Describe the PWM block on IPQ5332.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 45fc512a3bab221c0d99f819294abf63369987da..4ff6e38521ed94fac0f4caac5c5b0d9be3704d7e 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -334,6 +334,16 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq5332-pwm", "qcom,ipq6018-pwm";
+			reg = <0x01941010 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clock-rates = <100000000>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		sdhc: mmc@7804000 {
 			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;

-- 
2.51.0



