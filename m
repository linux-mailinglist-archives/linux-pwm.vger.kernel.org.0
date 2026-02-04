Return-Path: <linux-pwm+bounces-8085-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHgELqwsg2kwjAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8085-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:25:32 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A67E50E8
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 247BA3002505
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283763E9F93;
	Wed,  4 Feb 2026 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBQX0PDs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B53E9F87;
	Wed,  4 Feb 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204314; cv=none; b=fsg/aQNudFOt3nqPgPFtjMxufiJYsMpGzerdN8F0fXnfDxY+beH8csyD9wp4ZFH02VpYZh37M4Wnc1nJhjpyzAXqxV90/m6UQbTmm7gepg7Hmkj0frDves9IcRHcQHzkoQD7xc3A6vTmwbwFWSORuD4yv+8aGg5oeH1tEOS5h/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204314; c=relaxed/simple;
	bh=lWoMc7TqQFVxuHYqNXppAV75HA+/N7T/7cdmOpJldZM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t/MKLjxBCTE2GpuCeC92WlmqTKM950B6t9umWZQ4SeQD7TqST7//PL7Ui2WhIBHOf5+QKGdSF+x+lwTMvJ68cOsR5NH72Ww87Lja/omT1gjyJdcRIkJVSppFrddzqsQfWyKPaTNQWZpuDJFKTQTZzk4YEUD4kTtT6kIj4sempSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBQX0PDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 965ACC4CEF7;
	Wed,  4 Feb 2026 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770204313;
	bh=lWoMc7TqQFVxuHYqNXppAV75HA+/N7T/7cdmOpJldZM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=oBQX0PDsRUf3g2spsE3Vq/ySMbB5XJe/2/Mm50sy02WDTLEJPl5rKDCYYtvp97Slk
	 b1uPOJ3K50zOlRwKBwUbwZ7fMV3d+gZm39LxFasScyPwfV8TPMCS/0VmW7BzlF7VPb
	 PtX53XChRj+KuRSlnHK0ZzA96XGua/kgz/X6Ol2nXulR2StPggEiooCbgPLCaL49zH
	 Qg377In53oXz94rtVE3RDi/u59sLY6ceyFUjBlcCFlFydkwGbitTJ8Kc56xd+M7cfr
	 hbdwiSW759t5pLWS0PaKCUsx3lLZ+r0AnxMtR0WgrO1JX3uB1h4GF2OIRM4ZgoAlgf
	 Cda/DOTl8dNjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E9E95388;
	Wed,  4 Feb 2026 11:25:13 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v20 0/6] Add PWM support for IPQ chipsets
Date: Wed, 04 Feb 2026 15:25:06 +0400
Message-Id: <20260204-ipq-pwm-v20-0-91733011a3d1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJIsg2kC/23O0W6EIBAF0F/Z8Fw2wyCC+7T/0TSNwlBJq7jo2
 m42/nvRpK1N9nFgzp17ZyOlQCM7He4s0RzGEPs8IDwdmG3r/o14cPmBIaCCCpGH4cKHz45bY7W
 yotBOIcvbQyIfvrao55c8+xQ7PrWJ6h8vBYASJSgFRyxQglZc8Ms12FeXTw8p3M7rFHp7tLFbQ
 9swTjHdtnqzKNfsrUlOEr9N8gcHLgE8Sk1ApTnH6/QR4/sWs5aZhd5bs7M626pxhSTnrfb6gTU
 7i9XOmmzJNeQN+aYx9MBWf1bg/m6VrZCN1VBYW9bqv12W5RuEan9onAEAAA==
X-Change-ID: 20250922-ipq-pwm-c8c75c147d52
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770204310; l=6197;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=lWoMc7TqQFVxuHYqNXppAV75HA+/N7T/7cdmOpJldZM=;
 b=dSgDFKkncIy02owZzwas08bBX4PDhp7M9oeHWkU9NMDHUyt/TvT6y3iut9ygxcA2MRnvVPxst
 EYkcbmN4yjXAtLnLdv2+tnH8IdpWSswVvFj4+TfRNBAlrRrMeSSxh2/
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8085-lists,linux-pwm=lfdr.de,george.moussalem.outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.com,quicinc.com,siklu.com,oss.qualcomm.com,kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[george.moussalem@outlook.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:replyto,outlook.com:email,outlook.com:mid]
X-Rspamd-Queue-Id: E7A67E50E8
X-Rspamd-Action: no action

Add PWM driver and binding support for IPQ chipsets.
Also, add nodes to add support for pwm in ipq6018, ipq5018, ipq5332, and
ipq9574.

I've picked up work based on Devi's last submission (v15) which dates
back to 05 October 2023 as below SoCs are still active.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
Changes in v20:
- Updated IPQ_PWM_MAX_DIV macro definition to use FIELD_MAX
- Removed clk struct from ipq_pwm struct and added clk_rate field
  instead which is set during probe.
- Consolidated config_div_and_duty into ipq_pwm_apply
- Fixed arithmetic overflows in apply and get_state 
- Fixed off-by-one in divider calculation
- Enabled 100% relative duty cycle support
- Aligned continuation on next lines relative to opening parentheses
- Return 0 instead of ret in probe
- Link to v19: https://lore.kernel.org/r/20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com

Changes in v19:
- Changed pwm-cells property in dt bindings from 2 to 3 as per Uwe's
  recommendation
- Added hardware notes and limitations based on own findings as
  requested. NOTE: there's no publically available datasheet though.
- Expanded comment on REG1_UPDATE to indicate that when this bit is set,
  values for div and pre-div take effect. The hardware automatically
  unsets it when the change is completed.
- Added newline between MACRO definition and next comment
- In config_div_and_duty, used mul_u64_u64_div_u64 to avoid overflow
- Removed unncessary restriction of pwm_div to MAX_DIV - 1 after testing
- Constrain pre_div to MAX_DIV is pre_div calculated is > MAX_DIV
- Use of mul_u64_u64_div_u64 in .apply
- Skip calculation of period and duty cycle when PWM_ENABLE REG is unset
- Set duty cycle to period value when calculated duty cycle > period to
  return a valid config
- Removed .npwm as it's taken care of in devm_pwmchip_alloc
- Added call to devm_clk_rate_exclusive_get to lock the clock rate
- Start all kernel messages with a capital letter and end with \n.
- Changed pwm-cells property in all dtsi from 2->3 for in scope IPQ SOCs 
- Link to v18: https://lore.kernel.org/r/20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com

Changes in v18:
- Updated maintainer info in binding
- Squashed dt bindings patches into the first for adding compatibles for
  IPQ5018, IPQ5332, and IPQ9574
- Link to v17: https://lore.kernel.org/r/20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com

Changes in v17:
- Picked up RB tags from Dmitry and Rob
- Removed unnecessary code comments
- Corrected reg property in PWM node in ipq6018 DTS in line with
  expected nr of bytes for address and size cells
- Link to v16: https://lore.kernel.org/r/20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com

Changes in v16:
- Removed reg description in bindings as the offset is not relative to
  the TCSR region anymore since simple-mfd support was dropped and PWM
  nodes defined as their own nodes, not child nodes. Updated the example
  too.
- Dropped patch to add simple-mfd support to the qcom,tcsr bindings
- Simplified code to calculate divs and duty cycle as per Uwe's comments
- Removed unused pwm_chip struct from ipq_pwm_chip struct
- Removed unnecessary cast as per Uwe's comment
- Replaced devm_clk_get & clk_prepare_enable by devm_clk_get_enabled
- Replaced pwmchip_add by devm_pwmchip_add and removed .remove function
- Removed .owner from driver struct
- Added compatibles to the bindings and nodes to the device trees to add
  PWM support in the IPQ5018, IPQ5332, and IPQ9574 SoCs
- Link to v15: https://lore.kernel.org/r/20231005160550.2423075-1-quic_devipriy@quicinc.com

Changes in v15:
- No change
- Link to v14: https://lore.kernel.org/r/20231005033053.2626465-1-quic_devipriy@quicinc.com

Changes in v14:
- Picked up the R-b tag
- Link to v13: https://lore.kernel.org/r/20231004090449.256229-1-quic_devipriy@quicinc.com

Changes in v13:
- Updated the file name to match the compatible
- Sorted the properties and updated the order in the required field
- Dropped the syscon node from examples
- Link to v12: https://lore.kernel.org/r/20230925065915.3467964-1-quic_devipriy@quicinc.com

Changes in v12:
- Picked up the R-b tag

Changes in v11:
- No change

Changes in v10:
- No change

Changes in v9:
- Add 'ranges' property to example (Rob)
- Drop label in example (Rob)

Changes in v8:
- Add size cell to 'reg' (Rob)

Changes in v7:
- Use 'reg' instead of 'offset' (Rob)
- Drop 'clock-names' and 'assigned-clock*' (Bjorn)
- Use single cell address/size in example node (Bjorn)
- Move '#pwm-cells' lower in example node (Bjorn)
- List 'reg' as required

Changes in v6:
- Device node is child of TCSR; remove phandle (Rob Herring)
- Add assigned-clocks/assigned-clock-rates (Uwe Kleine-König)

Changes in v5:
- Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
    Andersson, Kathiravan T)

Changes in v4:
- Update the binding example node as well (Rob Herring's bot)

Changes in v3:
- s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)

Changes in v2:
- Make #pwm-cells const (Rob Herring)

---

---
Devi Priya (3):
      dt-bindings: pwm: add IPQ6018 binding
      pwm: driver for qualcomm ipq6018 pwm block
      arm64: dts: qcom: ipq6018: add pwm node

George Moussalem (3):
      arm64: dts: qcom: ipq5018: add pwm node
      arm64: dts: qcom: ipq5332: add pwm node
      arm64: dts: qcom: ipq9574: add pwm node

 .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  |  51 +++++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  10 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  10 +
 drivers/pwm/Kconfig                                |  12 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-ipq.c                              | 239 +++++++++++++++++++++
 8 files changed, 343 insertions(+)
---
base-commit: 6db894fcdec4d214812f3e6f656639f1b0081127
change-id: 20250922-ipq-pwm-c8c75c147d52

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



