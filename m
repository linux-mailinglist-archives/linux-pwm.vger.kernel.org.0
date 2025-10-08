Return-Path: <linux-pwm+bounces-7415-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A07EBC5E00
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 17:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0AA8425A78
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAFF2FB628;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLRi1kZj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5464B2F998D;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937627; cv=none; b=TXL0VtQJ1jgb9HhytWapLoZsvwDY0iV7qKWIY2UpJKcGw+KpuWLbgzunNqAtYg/Yp76+HaoPvb0/IzBGNA48MJFjMyqA4nb9+GCtAuRbm5aE4SEltFjhTCKEKZeZ/qJSgjwASAxwAEgAdk3aDwDjhp8I5cShUdVwaMpcd2RuBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937627; c=relaxed/simple;
	bh=BH9RyEUffqjPp+Gnltyt4X5dVubCxy25UZTDkRJK8ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tnNN153gWz3SVEofPMsP2uypVkraEgQSI2az1NM+yiWh0/VTZHJpwupiYQ1c1zhqWxOr9n+kP80aJsXIPfbvFqU4mH1/4aRNaHb19VE6aGlPiM2x+Z6ZK21KSzESa1lIHjCuZvyQKZLFOA0BmasvlCJ7tAHCRUYwaCv7hdBnpmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLRi1kZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E450BC116B1;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759937626;
	bh=BH9RyEUffqjPp+Gnltyt4X5dVubCxy25UZTDkRJK8ss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nLRi1kZj4xvK+iTdiR+NKkvqCSrgLaj+GxGISYWtepgzGDmFoIrdthb7uGWs6zRmq
	 2AtUOWampKKqHB+dgpjth23pJ1pkHHnVwyzuDfIuXWJ7GmF3nfBfHpkE/v2GAL9vJI
	 dBB692aLBz1mW2BtoBuhtn+JFgRpGpS4Xh+MdrOc5g24+CFgn/6ZOPytKP2Gm1AuWy
	 pfN4XmLFY+i1mUhyAAbHQGGAVQg3FRziUZYontfQn/UVzUbt57nzlhhPDoYtae02K8
	 ybsfNaWCLVUmQGJqRCjdR/DTiAN2kYPrR1+SN9tC6MzA6qrSxAJxJRxrKmasi9TYgH
	 an9KOLBZTtIkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD82CCA472;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 08 Oct 2025 19:32:58 +0400
Subject: [PATCH v17 6/9] arm64: dts: qcom: ipq6018: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-ipq-pwm-v17-6-9bd43edfc7f7@outlook.com>
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
 Devi Priya <quic_devipriy@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Baruch Siach <baruch.siach@siklu.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759937623; l=1391;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=O41HNKdswyFzcZl8XVjha1wsITAQCaBZJ3Hx8/DgYw4=;
 b=+N86pOedhWoXNzBaY4DZ0LAbr2QHng2kRT/nWvhCFuf/05h2KftoaKvPrqJ9cgmYkXvIZ6Ed0
 JOjXQMurxL9B3kNfSQh6wTNa3QyktpE8hbHbpdvm+7ASpr9UE2j+G4i
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
index 40f1c262126eff3761430a47472b52d27f961040..7925c9a6b0dcff9e3157dd9de01fbc2d240486a4 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -413,6 +413,16 @@ tcsr: syscon@1937000 {
 			reg = <0x0 0x01937000 0x0 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq6018-pwm";
+			reg = <0x0 0x01941010 0x0 0x20>;
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



