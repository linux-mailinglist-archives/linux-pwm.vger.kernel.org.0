Return-Path: <linux-pwm+bounces-7374-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F14BB09FA
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8A024E2B24
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E40303C87;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBbN2/eY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9205302176;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327463; cv=none; b=US1qPVs1cZhvRarTLB50PVT3AknlyKsf5OorOvfqEyHNtijA9dqStkA5H2DTC48DdGQTOBOU0w1Wk0qIs+otEkiHfYi1/J+mgfgfrIm0t46R3FWxFW/adcy4MJyeZfGtAA4C/LRxQTAp582AUzXhsS2EfEGw5zdtG5Uk9s74m7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327463; c=relaxed/simple;
	bh=Spr04DQ7XY9/ry1ZPrbDw96CNr3+u2z1MRgJct4ul8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTubPN3Rlhq0TmJXVHoxOrVQOObXm2qq474eIeN4FIErxWSJICb1ZyoEjZBsRGiogSytDSOItXWqLEpL5TCwk1dhuIjlFK5v64Kfioe0sM3oz/zx/4CFHBPX6LYiWiddFpCnn92srB9ZsGQTCGp/AymiBwefy5Kc0Y1TL5ubLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBbN2/eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FDADC2BC86;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327463;
	bh=Spr04DQ7XY9/ry1ZPrbDw96CNr3+u2z1MRgJct4ul8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hBbN2/eYdbWYERly0xm93y5Z/TKc+HwqvnNH/JE+KFWQKDEqNYgpVnZmNc6TgSrgn
	 sXFLDHJcJ+hwNF5GAHPYEILdP+BpEvF2bRVWQs1Wd+FI8CsvSHtLvxGiSj/KDKP4Z8
	 kUayAbGfUydkHcZUg6d5jGb63guCiz1h+B9DQeLR6sAEOuZojoPNh50rN+onsCM1Qq
	 5SoQhkJQS0QRDpT1jVt7nyUrgtiu9JkKLmPTFp0tkC0F/GIiT33GP4kkI+aR2engnc
	 znleGYGfNA0EA/xRZ389Y9zZ/c2RDxdGroDOP0lgt0khcdD8gxKYkd8Xt3BMNSzVwA
	 iTDS24GmTDuVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCB5CCD180;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 01 Oct 2025 18:04:23 +0400
Subject: [PATCH v16 7/9] arm64: dts: qcom: ipq5018: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-ipq-pwm-v16-7-300f237e0e68@outlook.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
In-Reply-To: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759327459; l=1166;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=ga1rBlYVYLnYBPfkk+/zhO3WBfe7APc074QH0n50Pa0=;
 b=arTo/hNHvUFsrep46RZGgDiY7pvvzaCrt7RPKJl3kmCSMSyMks2LdcYrAz0zWiECFbdcNmPhk
 7ymOkWZqjLRBxrlGA8IX6ifSg8xwKt2LWBCDSOZab4ZeCRwAA2AiwrI
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Describe the PWM block on IPQ5018.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index f024b3cba33f6100ac3f4d45598ff2356e026dcf..d4bdf2884aa7f73711cf8a37b7a4c4e7e54c503c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -453,6 +453,16 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq5018-pwm", "qcom,ipq6018-pwm";
+			reg = <0x01941010 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clock-rates = <100000000>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq5018-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x7804000 0x1000>;

-- 
2.51.0



