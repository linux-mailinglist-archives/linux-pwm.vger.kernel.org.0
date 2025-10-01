Return-Path: <linux-pwm+bounces-7372-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CACBB09F7
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EED3BCD3E
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA472303A2C;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1ENreQJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EE30216C;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327463; cv=none; b=d1lFE4TB7kMAl86YDUpKq9Nq4OoCdxaFqgw4Iu1uJ9nAD+GPbc3a3Py9xC0GDMd3S1JxG67LuvBu5K19Fq1iSt7raR7Myhmlb6/WMNse1wbkhPxzmDnPNx2Jkf2gnW5oLIUoiABR+ZQpxyOoHu/BqJyw1wmgfpOcZZZVEq4sk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327463; c=relaxed/simple;
	bh=1jW/pw93M9ZTt2+XfXJpx1QIagE29diOB2yA8Z6Eh38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkClrZPnI4y2KpAPB+KB3SxswyqaWgRD3G4c9a6gIr7hhYBkM236d/Qelxfl5IDoyBt+b8GUUQGo0QDRK2mo5NxtN2Z+RR+MTIV0cO6Cw3lBmlISuCY4lz8GWuAkMUdQyWTKIU/LntGZwSjH+32dfzFc4QAFmebsytaFVz+shAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1ENreQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BF4DC4CEFC;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327463;
	bh=1jW/pw93M9ZTt2+XfXJpx1QIagE29diOB2yA8Z6Eh38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W1ENreQJE4iMsM0CPpOW4SnG4delAs6r9cuhlrUewNvglbGon8aHtQNcMTaW1eVUc
	 s8/Soiupj2199EEOYXjowNvaDUCoBsJEA4+cjvNfmSIgLgUXPVOkjQ9uVSLjtkNlrO
	 D987fCne/MpZmtlbUzcOtmQTGvBArb3bBjW5ax3AxtMx8wRuP9T4FBvAa7rqTdiie4
	 XdTx3N+K8HzLnAaTyAE6KWfjtigzk86ZU3H6GzABUo4ShttVjXwMxGh9lsmfbnOz2L
	 CXTyrrrl7LQMY7PMbe3AzO0mxL67B5lwdPhANZHSP/u4tifYA2B/plrRMcg/tI1MpU
	 jYBswvgaCi30A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F417CCA470;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 01 Oct 2025 18:04:22 +0400
Subject: [PATCH v16 6/9] arm64: dts: qcom: ipq6018: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-ipq-pwm-v16-6-300f237e0e68@outlook.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
In-Reply-To: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
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
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759327459; l=1383;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=aXkvbG/7UnHwE6F120GhEEEi6SRmzhki3XGP6tCrgxM=;
 b=t8ayXSkiFsad3nxWe+r+nFkcDK7Nya2k4tZf9kbAnUAB7mNCwX2Io9rjCv9pDcvDb5ImcEatG
 pkxa5VPkC+WD0dlk/PHqpg9Jsp5vtaGrJw+0oY8TPEeSHoMvFW40vXv
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: Devi Priya <quic_devipriy@quicinc.com>

Describe the PWM block on IPQ6018.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 40f1c262126eff3761430a47472b52d27f961040..84bc2dec2b22f9634d4ec926daeebb9b40cb112f 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -413,6 +413,16 @@ tcsr: syscon@1937000 {
 			reg = <0x0 0x01937000 0x0 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq6018-pwm";
+			reg = <0x01941010 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clock-rates = <100000000>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		usb2: usb@70f8800 {
 			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
 			reg = <0x0 0x070f8800 0x0 0x400>;

-- 
2.51.0



