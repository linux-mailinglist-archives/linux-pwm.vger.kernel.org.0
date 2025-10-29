Return-Path: <linux-pwm+bounces-7520-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC2C193D3
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 09:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D566F3AE3A9
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FA4313E21;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kaq5R+D5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A943112B6;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727038; cv=none; b=QOrU4SaiBqViLxZGSfzkHFxIyKn8VP/tXr3sDZ5YZ9UdUfESOWhDDWs8co7NaaQAWoM/to+XtQQwJJM9qSdClev6blkk9WUZWlVna6NTV1Kfc16RyVJUocxQBxqPIDrjEgLPVrLfzWnLN5p0EPd8uv5JqcrEVHdYFzMWeY325cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727038; c=relaxed/simple;
	bh=llHql/u+i5fQ1U+9c9rNSqQxiXMWOdOWOOqVtConT/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQ8bk9Ge6dth8kQ7oMQdJIQmt07o9G7jN7YzeNTEpbM18u4gE/OSzenjjw3GKhS4HSstT7RPgdrUmHHRJhQ713CCEm5iItf44z11GCvBIJen9uO5UJ0k27WLR3kl28FI6vZlKShuSHQoCQPFdwH9DsGem+oiSGsJxNqv4w1dwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kaq5R+D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15BD4C19422;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727038;
	bh=llHql/u+i5fQ1U+9c9rNSqQxiXMWOdOWOOqVtConT/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Kaq5R+D5RDI35/0dljy8jDXmYRgCpWVYqAvGHu+4XgmaXaEZtqQn3XV9iosH58+4Z
	 Ib0IhL+LOMdOULN2ouYo+zCuguHcF8AiXOvIqg1RCO+jBqgDTUxkbRgVB94WBUCnhy
	 y7UgKN58v8aj6/WABxhK0taIKppuctv2vCZBAi00ENQ1iSsaqhmpwZcFt6EtCkKU2r
	 EiO1uc2I0S3eWyZS4lINZiwBsm0xpsOyTpOia3DXNjQbITT5Iq5sd31/vep+6IvfKL
	 BkoZZGxWMtXs8YH1bbogq9Bjw3hC4CSpq0N3Gsj+TbVbBENLXQV/N8NtsQFXQ0N7+T
	 d40Qj5kXhysNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E33CCF9F0;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 29 Oct 2025 12:36:59 +0400
Subject: [PATCH v18 3/6] arm64: dts: qcom: ipq6018: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ipq-pwm-v18-3-edbef8efbb8e@outlook.com>
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
 Devi Priya <quic_devipriy@quicinc.com>, 
 Baruch Siach <baruch.siach@siklu.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727035; l=1391;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=atW+yJDrnsJeLsNipKDdbSHJZ/mFlqUkSThj04bN9Yg=;
 b=w8NUtghJxEofwj0/TJP6pVqkXTsDYfGD5sKOjlnfYHfbQta/IIsGC7lFuMye7YfHSzozQpM4b
 wSRl/z9MzSWAdJK1hiEA5japGoHAS/lW5+qZZOfi+SGZK+s15j2GDWs
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
2.51.1



