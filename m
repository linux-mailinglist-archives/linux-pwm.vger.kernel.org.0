Return-Path: <linux-pwm+bounces-7722-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90351C91A04
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 11:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE7F4E1DE9
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1230C619;
	Fri, 28 Nov 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND9uSNys"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E530BBA9;
	Fri, 28 Nov 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325763; cv=none; b=Iy2elp2knV2H5/gO40XQZGEZDvsntvXwKY/miSUj2O/8u1wKAV2dnxE+x9BuBtN28yb7mAJp4kiAR7Z/UxMtnE1ud7FepigRBXsBY0oYqcLH2iFIDXzBsbu3cVfZJQRwa+lVsGc0PUM9sF+OC/5BMCnqCm7S4JrJ1S2RajZfgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325763; c=relaxed/simple;
	bh=m4LNeWD+6Or9/Co1nTyttTYcaHDaduqoQx3w4HyIJ08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLWy7gu9hK5kN6VK/AugMbx+KhUta3cyiTsqR7IHMCGxZ9YxcrUbipyb3gHTB/xCFq2AZASyJtsAnXGh4Up0HHZkCv8KJa+CgJIPDi0HOBZ+nBRJ+CE3Be2fnzXXhMgl5zF4mKLQlhPVpJZhKqC7g3yzjvBDqq7MgCW/Fwu75ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND9uSNys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D14EDC19423;
	Fri, 28 Nov 2025 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764325762;
	bh=m4LNeWD+6Or9/Co1nTyttTYcaHDaduqoQx3w4HyIJ08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ND9uSNysWq1qGIhesFNjmvB+4q/vgKiW/73GaE7SKOimgqs/DWEuQqTYxXJi9N/UX
	 nJn9Hs7sDiS/6RriCdEwxxvqD+Be3ida+3IvJNOrlrb4F4K6Vgvft4XEHyLLsxcf64
	 w5a8oB6JsFoR5hl645JWGnVUujL1ucNUnVKuuS8crO4PoSr+3U5XbUTCDJ6qVlnWGd
	 J9mLdBoalhmS48en+lupKo8oMF+s0cHbtkBOsTAN9ouvE/3xFAgf40JWu9kXT5ZWqC
	 rcCxjGXOZDjtcvM1CPdYrvvfGjDIfWQ4QIvAVxz4sTl6JwSzioHAR84d94GFBgdpGh
	 yAlaXeg4P/omg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FA2D116F6;
	Fri, 28 Nov 2025 10:29:22 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 28 Nov 2025 14:29:15 +0400
Subject: [PATCH v19 3/6] arm64: dts: qcom: ipq6018: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-ipq-pwm-v19-3-13bc704cc6a5@outlook.com>
References: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
In-Reply-To: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764325760; l=1391;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=P5CK/w1B6zAAyU8rGtps6nkSbcs6bEiQ8DwAdl5cL3U=;
 b=/6XPsu39QbBZI3Mfycrd4KpyfOG5UfVQqg/ELTSp6pCKpOdt+L7d095xWp4jaKWkCWFEZAiS3
 yx3LqvDbLPODoUhscnnWCvTkGGzfplAVS6dAFTt2OY51lGc7ZO/WvZ1
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
index 40f1c262126eff3761430a47472b52d27f961040..7866844cc09fd2c2c2f512ce2c8fa7826fabc7aa 100644
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
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		usb2: usb@70f8800 {
 			compatible = "qcom,ipq6018-dwc3", "qcom,dwc3";
 			reg = <0x0 0x070f8800 0x0 0x400>;

-- 
2.52.0



