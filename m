Return-Path: <linux-pwm+bounces-8504-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCBdIIoX1GksqwcAu9opvQ
	(envelope-from <linux-pwm+bounces-8504-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 22:28:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D939C3A7372
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 22:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 422D73045208
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B1430FF32;
	Mon,  6 Apr 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXN88ZPV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC708302140;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775507137; cv=none; b=GxARqx0Bvjw06T08VNEE/c4/zSrAdFVO6laoms9j0tG36A1MvX08xJeg690BiXeA8oWvnKRhy8sJEslnwmoiCvu/ukiF1u5Rh5k1AQHux5hlYYuXtNwpqulaFPZrfjkskE3sa7lrr/8xUhOXUf+nVbJpx0rdiXrt2dLTIhdi5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775507137; c=relaxed/simple;
	bh=ribnztIR4jWaiDRYmWtd83mRF1GazSvlgDdIiliQ/NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNWctWMgyZyTBMIhFOPTZavtRU8AhmykZDncshCaGAtRlqd17g4OM2kXK7cm+dJX0QTHHu/rtIzm4sNVZXfyr4g+Hy+DGdSOFQrPi7QQdcPViHvaCx/0ptOj1rFE4jpsObpvTUEhR0TGc5K5zdKk7wAZu4pdGjeAPHRRTACnC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXN88ZPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEC07C2BCB0;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775507137;
	bh=ribnztIR4jWaiDRYmWtd83mRF1GazSvlgDdIiliQ/NI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CXN88ZPVaZbVCe3Oe5FGn+/aTE03Q5FCHQkzYAnD/s21Wr7UxVKf0Dnceh9rtm6Qw
	 HIAutMWdcdmorlFfyT1/29P9V/T3M4ogB5b2Q0WHJ+RDc+LPk85l3nYmvcLJsJnHQv
	 Y2lbw2Liat16pry+XxcKZMCf8abPngsuHxEOJjcQWHCZlo6vpBQigWGLjoGeEPOhRZ
	 k5OxS6MSFqNv9liD2eCGtPZRtSobvgt6+fnoFtE6b9RSbI2D6Lm1ZdtaSs9w8uoGCT
	 7RVGfUntc3me3cpHM7trYfhN7NSz9siA6gUybWEEp7dcjnO09OxtqhFpu8LO4AMe9B
	 DbD/Wjpnc6JYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65F6FB516F;
	Mon,  6 Apr 2026 20:25:37 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 06 Apr 2026 22:24:43 +0200
Subject: [PATCH v21 6/6] arm64: dts: qcom: ipq9574: add pwm node
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-ipq-pwm-v21-6-6ed1e868e4c2@outlook.com>
References: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
In-Reply-To: <20260406-ipq-pwm-v21-0-6ed1e868e4c2@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775507135; l=1239;
 i=george.moussalem@outlook.com; s=20260406; h=from:subject:message-id;
 bh=ZGylQ/mkBST8aMMXzv/c+bz2PK+194wczC4slSURFQY=;
 b=XvLPQ0OY93o1OdqdxLdxqFja7hrUaeFR/mqYjahxFcHPpWCwUkH9Gj8CSE2ZykcEZGdBrV7jc
 7urHSEWvPY0CrtGq6tA4aWFofLpikodtPUD1labvUdn6mbCLPNsKrU/
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=uqspem3ahtBvPEBuxVbyyXT/0Vp3JNb/mo1EPbmBzWg=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20260406
 with auth_id=722
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8504-lists,linux-pwm=lfdr.de,george.moussalem.outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com,oss.qualcomm.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_PROHIBIT(0.00)[0.119.20.96:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[george.moussalem@outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,0.29.142.104:email,outlook.com:email,outlook.com:replyto,outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.29.158.18:email]
X-Rspamd-Queue-Id: D939C3A7372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: George Moussalem <george.moussalem@outlook.com>

Describe the PWM block on IPQ9574.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 622cfa96ed2b..3f15c40f7841 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -445,6 +445,16 @@ tcsr: syscon@1937000 {
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
2.39.5



