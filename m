Return-Path: <linux-pwm+bounces-8091-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIRmMOQsg2kwjAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8091-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:26:28 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE84E5179
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E51C13028346
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787F3ECBDF;
	Wed,  4 Feb 2026 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBdXYFei"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488673ECBC5;
	Wed,  4 Feb 2026 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204314; cv=none; b=uwndTXZwjatScjw/qfG0MiKqSIzmIqMgv7TVXWmxKetvRuaAg31sb9ZhW77UPjPX/lMOditmtVgqxnruPV2O6MZjPnZYpu9HApUfhtwTIOzw3WjizZC/AgH49PFHOWCDPWcP9WGPKoDjEz3vupzf1ki1h0rXV4pbjkJtO2Dgfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204314; c=relaxed/simple;
	bh=vE8UXlKfInB73S8Crc3gaHWqLQg+oOyoCtzeWharQS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nr0qlzwFsS+ce2fu7iqjeCzNSpG8h2LgSxcLUcVXPjNCM2Ync4ajZxf9s+2yE/jV1FuPogUTSu/Npx6P4esNTjiZnUNQQGO/vqBBzhAUOsRZh5kDpfIZD4XNW94nSCFEnymaMZDVMojvZSF25aKaWLbrWAehNVPyQMhyGyXG2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBdXYFei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FBA8C16AAE;
	Wed,  4 Feb 2026 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770204314;
	bh=vE8UXlKfInB73S8Crc3gaHWqLQg+oOyoCtzeWharQS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eBdXYFeiLIl+QGeTfz6IIUeYBuEEDl+b419qodE2EVomGdqaNo6884pycBeWBvZMh
	 haX7oelDQSKnWGiF9sQjVUxz4Bay2BEZVQ1GmcghWtGQg7w+d4/fdfvByLW08F//at
	 iN1OoKPRpYgIVaVKk7kEOMlXr20t38YcZLXpVfFG+fIWwnxTLMzJ8Gau5rLyluyr8P
	 eM9GvY4qwgMgvdyujRQepS7Oi+ovHftu/43TRRxbdoIE8N8kI7jYvsCdHJ61HDu2ls
	 NNNef1ZfWkcdGaVDLNWZmQ6VTGMTNKrX1uWcdOfsGts6/lMd7pc+dMVMn4md9rJWnb
	 Ul0Go0aD9V1TQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE25E95389;
	Wed,  4 Feb 2026 11:25:14 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 04 Feb 2026 15:25:12 +0400
Subject: [PATCH v20 6/6] arm64: dts: qcom: ipq9574: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-ipq-pwm-v20-6-91733011a3d1@outlook.com>
References: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
In-Reply-To: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770204310; l=1234;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=1ixhFwq2rEjXYJIhs5+j+ngAUcQh5KQa6+Qdzh8kp4o=;
 b=ky+nnCBbPuFce/HNZnz6s4ubdKccwoR4mGT7VVjp1Q+YR30lXS7xluR+rnmLy73TfU2J3/6kO
 144Si65ChORDD0KZk1dvy+masC3Igfhy8O3qYSqMdoqSlttNJsS5eZR
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8091-lists,linux-pwm=lfdr.de,george.moussalem.outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com,oss.qualcomm.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[george.moussalem@outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.29.142.104:email,0.29.158.18:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.928];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,outlook.com:replyto,outlook.com:email,outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.119.20.96:email]
X-Rspamd-Queue-Id: 3CE84E5179
X-Rspamd-Action: no action

From: George Moussalem <george.moussalem@outlook.com>

Describe the PWM block on IPQ9574.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index d7278f2137ac58305cc4e82c1d6c26c08bc7a405..31f4bcc92c986e1c0b02ea56acdf707af92b7f84 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -449,6 +449,16 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq9574-pwm", "qcom,ipq6018-pwm";
+			reg = <0x01941010 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clock-rates = <100000000>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>,

-- 
2.52.0



