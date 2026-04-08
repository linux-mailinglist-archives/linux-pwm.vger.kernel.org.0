Return-Path: <linux-pwm+bounces-8518-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGq0Iv4r1mkUBggAu9opvQ
	(envelope-from <linux-pwm+bounces-8518-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 12:20:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E18B73BA719
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 12:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D12F3103EC3
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Apr 2026 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A537CD4B;
	Wed,  8 Apr 2026 10:08:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E337CD37;
	Wed,  8 Apr 2026 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642901; cv=none; b=pmfoY+O7kXnU1u8tXP6XdddMTq+0ZYapJTGFXHs8XAFmSYTmE8ia5kKaS6YzHqcfuCHj/iOIdblYAIX8ll+hJuVS1Va5HpxtV4P/Ab/3JPfp5eu3Xevf1CkeLqWO+z7jieFt9O8QsJ4a6LwhD9B98RTPHjLhVPHsS+Ifr6p2HAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642901; c=relaxed/simple;
	bh=62ZMMJhiRf3W0pHXfgF2lD/YodlaB0xcTZ2T1wCDpPE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cAoctGWQXDoJ8HhqVyrdy66Dy8faLysu4hvQ3MdBHzoFWLc7bHDtqNHu2RJ8KfQcC6RjNQ6zpf/a34p3xBEjasitNdvpsal/HF2ca5u3D2p/UfVsExrKZpoMn+40LkIefilTp1O7aCjzRPAjX0mXZuXJvY6Yespm38Yo+CyVAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpsz5t1775642864t5fdd2343
X-QQ-Originating-IP: OPiFM+vDY32D3qaMXmjBX7aGz7F+ikzsRR0LCjXRzZ4=
Received: from [192.168.30.32] ( [116.234.85.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 08 Apr 2026 18:07:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1243427011650988679
EX-QQ-RecipientCnt: 10
From: Xilin Wu <sophon@radxa.com>
Subject: [PATCH v2 0/2] pwm: clk-pwm: Add GPIO support for constant output
 levels
Date: Wed, 08 Apr 2026 18:07:31 +0800
Message-Id: <20260408-clk-pwm-gpio-v2-0-d22f1f3498a0@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0Jm7ZihICIr72FYlNLCqFDSImJI7
 y7g2uVL3n9/Aa8daw9FtIDTE3u2/QriEIFqZd9o5HplECQySilD9Xzg8O6wGdji2WRJleQXyuU
 J1sngtOF5z93KH/tXdddq3Bqb0bIfrfvsf1O8eX/SU4yEKdXCJFKQNObqZD3Lo7IdlCGELzmsB
 De6AAAA
X-Change-ID: 20260406-clk-pwm-gpio-7f63b38908a5
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=sophon@radxa.com;
 h=from:subject:message-id; bh=62ZMMJhiRf3W0pHXfgF2lD/YodlaB0xcTZ2T1wCDpPE=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDJnXNF5e6jvRyObbf2pR3ryLIhekzkV83jXln9CbNQInV
 N8dvh57pKOUhUGMi0FWTJFFIZ5hLntl7rWnYqV6MHNYmUCGMHBxCsBE5LIYGVY3ZgYHG0qKnJm1
 cOu5Ze2vPkkLWOo5/VDZm22cm28p/5uR4an00/VBpYy8k7bZmWj+mabJNfXhXoMkWaUTu+VdLyh
 rMQIA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MyeHZuBXrvHmp1aiJyB2dH8YhNIfcOptw9xZb7F1qcN8fp1YZKcVjbv0
	COmGHklgHwiBo0bQiWV+AZpkeNgBSgkPz6Ts2kQPucNQ8oCcT7Z6hqrMwANNM9Lff+fKPgT
	h2X1n8vtGdyU6qgVO/5ClluN0e3nAQfsVmk4CPkG6tVDoQJjzK21z70cF2qIUS7cmiAdFx7
	q7VUsknzKxNzOKpdMQgn3wQPbL8q3Vj/Zd7rSwWRsB+C0hREe84XBAVeRaDxe11KN8dcqRM
	xfyh7LOelh6VbkAM6MbyfEJy31YBI/I685lxIyqD+1CFYzlcW/NhdQ18sPyFWpRoD/J3rNM
	CTRgy46eTOND5h/GCd2v0fP/D9Wh38qcV3ktmws1s2850aVpWthu4v2KP2Zvpo/1sS5efWZ
	ja1AcoVDvDX9a2bDyTDzpyyTWnFd++PS7tVFV2TH1DePZMEOmsAPB1ubtFnfRA9I9rpY+uE
	J2732sL35xPjOGbQN3oDg3QFGP4ZBKCIVgkHm+n2VQvWwskekirVRQH1hVjUv0CBPHVsPiE
	+RFH7Cc12vuaaP0SWYavMb9fUCqQYkKRwVt3AVl8JkBKfFlNJOy5VqVJccKbvUYOU3umn2p
	xDmLEAGs3dXmYGdThhml1aYiybpDf7VObQ/CF7ln6AcSo8SyeTLjA46d4ET5JC5CJN3Hxdw
	l6xB9XAO9NSFJzdpBFHu5iI0utVqBKxWZgfcejrsArpzVqVmY0QdgpR4qHZb1p7NP3p3opb
	pZASSC9Ilgu+BPTF+e/Zv8yhDNKrlMyuaHXc5A8OuzTESRjo47Za8B24MP5Rvb1bBpA1g9Z
	2wx9hT7jQ22WjCmkSI50R7fcpccXWFlY1zMX2ONGyY85sbcoTeaR3KR2FJtJm/H9K7cN05M
	y9sZh05hIVtHC0P8l/mx+p4+M6sbP5jr0LCMf1WIAmcgK2K9G1j/ko97h3FKCNQtWDRDp5M
	jtFG6iEiWhuKTexZGLiCaTBYHRNuiDD823Bcp9HLW/XKEHvQX8XCojtEJm+b/M7x7VLQu5c
	jJttraH9l8UQeKJitwzlweRg/rOuADeS9yv7ihmtIkhRVP5zixT5/mxxjonn9bqsF8tmJOk
	PN6/GWMF53BeY5AblrpMt8=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8518-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.468];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,radxa.com:email,radxa.com:mid]
X-Rspamd-Queue-Id: E18B73BA719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The clk-pwm driver uses a clock with duty cycle control to generate
PWM output. However, when the PWM is disabled or a 0%/100% duty cycle
is requested, the clock must be stopped, and the resulting pin level
is undefined and hardware-dependent.

This series adds optional GPIO and pinctrl support to the clk-pwm
driver. When a GPIO and pinctrl states ("default" for clock mux,
"gpio" for GPIO mode) are provided in the device tree, the driver
switches the pin to GPIO mode and drives a deterministic output level
for disabled/0%/100% states. For normal PWM output the pin is switched
back to its clock function mux. If no GPIO is provided, the driver
falls back to the original clock-only behavior.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
Changes in v2:
- Restore the original limitation comments
- Swap the order of pinctrl_select_state and gpiod_direction_output
- Handle a situation where pinctrl states were found but no GPIO was provided
- Link to v1: https://patch.msgid.link/20260406-clk-pwm-gpio-v1-0-40d2f3a20aff@radxa.com

---
Xilin Wu (2):
      dt-bindings: pwm: clk-pwm: add optional GPIO and pinctrl properties
      pwm: clk-pwm: add GPIO and pinctrl support for constant output levels

 Documentation/devicetree/bindings/pwm/clk-pwm.yaml | 36 +++++++++-
 drivers/pwm/pwm-clk.c                              | 84 ++++++++++++++++++++--
 2 files changed, 115 insertions(+), 5 deletions(-)
---
base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
change-id: 20260406-clk-pwm-gpio-7f63b38908a5

Best regards,
--  
Xilin Wu <sophon@radxa.com>


