Return-Path: <linux-pwm+bounces-7519-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E923FC1930A
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 09:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A104012F9
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8982331329D;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsVsks/x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589AA30B533;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727038; cv=none; b=X7ijjvkWSF+sMLtmE+XHdwMjfyVwGdBqylG5h0FeSJzlODz1qTuF+cp4X9zgAyw/zTdnu8DxexlhOU5ga6z1LEPjov7yaL5gKN7A0236iKhRJRVgI0rK3+aFOBZ2exJHTmB33N2wlHERrsp2UVCzsHgcjqylytYbcaZPUJIn3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727038; c=relaxed/simple;
	bh=GJAfy7iKEcJpEfXRc0Uu3ufFD0wbM4VeuQSosfa52Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWfWCUBD6g+Xch+vT6yUCs9Y+GVR7fxxE8FnaEC5vzzPkOkxG5jctbjdlIaZs2JApfB9UnTrxi88dbM++tqF6s8bg3oPLrBnFSnmsjANCHkIOTRgp3FawOTgAJEaSdjhwyi9RdutYN0iwZ9DK9e38kXu89h9ApfA2YXL+uqiWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsVsks/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20417C4CEF7;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727038;
	bh=GJAfy7iKEcJpEfXRc0Uu3ufFD0wbM4VeuQSosfa52Vc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KsVsks/xdOve8Ep3E7YiKEdtxIfVorqAFAjiViyiO84OIfEXvNzGW3qpSlPgLD9g+
	 IoEgoySO6BKqriHq8zv4BM1GtlegxIBor0XfJjuaWoMeU1hdjUBbeULMBfHWbjMXSA
	 STSf6sDPqX1sEC488KpYMZ8Wta5mo21o/WSq+i6UGWKwpRuZ4fl1DShzJRUFW4K39W
	 awaaAH0WO6zxJj1tgxMs1uNhheeD5Kbf5fd/DtnxuydCgtncewcnVSZZnbo/u3Onrq
	 C/7+z4D9rumnpBsw+gwNbRPMIi1xqt9DlTqLvtLY5STdOZ/vFvlSSilE3dcK0AsDqY
	 hrV4RP/nOqDNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169B4CCF9F6;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 29 Oct 2025 12:37:00 +0400
Subject: [PATCH v18 4/6] arm64: dts: qcom: ipq5018: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ipq-pwm-v18-4-edbef8efbb8e@outlook.com>
References: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
In-Reply-To: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727035; l=1233;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=+/1aXltD7q4tXAN+T3JtxPoncHcVNEKWMgEN9+0w1GA=;
 b=i3q1JE/4S1Tu1RWYInUDD8rmTZiDQocGH8conPr4Kla25HlnvgknFXIl5hu+YjWdHlHwCAKnK
 qgNOdez+TAhBDSeSSv0mVHXGVGw4srRUmA1iRmbFSEUiaTMUaw6GTt0
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
2.51.1



