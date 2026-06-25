Return-Path: <linux-pwm+bounces-9378-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7acXItIEPWpqvwgAu9opvQ
	(envelope-from <linux-pwm+bounces-9378-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:37:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D472C6C4B39
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 12:37:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=rTlyEXEN;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9378-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9378-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51047303ADE9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37363D349A;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF3638D3E8;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383761; cv=none; b=KDH9SXDmm1UYeEFaoZUMa2TK6NeFTtyXZmP1n3s4spaw+iwWRBJh0nJBG5K0TP+WNAIAWorZPO+VkLbzDETnlnPbDBtLObi8WjGjwRbI3bcFjE8L0uMF/ldey9+FJSk3KchJKg4t8nIIV0YMWfLnbT0Jy8wrlMxG0otq920JHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383761; c=relaxed/simple;
	bh=Le4Y3en6CTsOWFOCRU6zRKyD43hSFHUHBIfk02cFcfM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B+hPTG9ymHUs1TMQb0hvGOUGqCxrXEIwZ4rhttN0IB0hlcoblpA93BR1os5PBEodkSWuKSG0DyUrqDl/78A7xHEcYWM1CAtkZxIzIPE8BIyfaUPXG9BLGmGwVNrmy1SH3SudgkKJS1pR+K5JH2StV0OeDQdMDtXaQXjp5zFpBh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTlyEXEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E8C8C2BCB3;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782383761;
	bh=Le4Y3en6CTsOWFOCRU6zRKyD43hSFHUHBIfk02cFcfM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rTlyEXENeY9RNEIRnvJorzc/8h/cnXt0fENW6U693sY0j2XMu1maU9aaE/UmmvZce
	 dEox8vJ4XePl2B1ttVkyX5kZLhc3oqraeb9fW0EjBLARVv3toqAJTfEgJ7zA0uhiTf
	 nzis3qhTGkmIDfbHVsxlo7VL1I+vbbQfhu/5JFcPrj0q3r4rcWCAgjc0CNwgLtgPKK
	 V2dQBcswMsSYSIrBBsWXLGf5VaODc5knpEQla5qzr4Uoq4pOVEHCkQTtkpq6dl5IPh
	 mBIUTUST5hOh4DHUwTQhc2ovSJDFoW7+tDqlatl2YRcR62ij0NPB1gfVL554VbGpH2
	 S5wyF4YWN+lpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444C0CDE007;
	Thu, 25 Jun 2026 10:36:01 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Subject: [PATCH v6 0/3] pwm: add support for Andes platform
Date: Thu, 25 Jun 2026 18:35:58 +0800
Message-Id: <20260625-andes-pwm-v6-0-3aef11711017@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI4EPWoC/33QwWrDMAwG4FcpPtdBkm057mnvMXZIHHdxoUmJs
 2yj5N1nZ5SOMnqwQfB/v0BXkcIUQxKH3VVMYYkpjkMeeL8Tvm+G9yBjl2dBQAwEWjZDF5K8fJ4
 lQmiYEb3yR5Hzlykc49fW9fr2O6eP9hT8XApKoo9pHqfvbdmCJVd6NQLV+VnCCh0j1U6ibMNg0
 b5s6+bg+8qPZ1FqF7rD/AEDalshWSTWT6G6QQNICp0ySle11WT4qdM393iBRUuQbAG5bVEZY/7
 T5q6Vgr/aZA3ojWvYuI78o17X9QdHaKaUoAEAAA==
X-Change-ID: 20260204-andes-pwm-10ea6611c3cf
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782383760; l=4497;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=Le4Y3en6CTsOWFOCRU6zRKyD43hSFHUHBIfk02cFcfM=;
 b=eiK0JLEgxVMhXThE4pvfrOJxd1oXcY9c5ReVQ/t86R4jS1/+IcVK1iFEbn/q/gFIIWbl79Ct8
 4tibKumeuU0B//fpe22kLexux8KSZd2khJzpFTV8u+QUIap+kfiZz1I
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9378-lists,linux-pwm=lfdr.de,ben717.andestech.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ben717@andestech.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[ben717@andestech.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,andestech.com:replyto,andestech.com:email,andestech.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D472C6C4B39

The ATCPIT100 is a set of compact multi-function timers, which can be
a simple timer or PWM, or a combination of the timer and the PWM. This
IP block is a core component of the Andes AE350 platform, which serves
as a reference architecture for SoC designs. The QiLai SoC also
integrates this controller.

This device driver was previously part of the Linux Kernel, and the
compatible was its IP name "andestech,atcpit100". However, the driver
and its binding were removed due to the deprecation of the NDS32
architecture [1]. Although Andes now dedicates our effort on RISC-V,
ATCPIT100 is still one of our peripheral IPs, and that's why we are
re-introducing it now. Since only using the IP block name as the
compatible is forbidden now, change the compatible to
"andestech,ae350-pwm" and "andestech,qilai-pwm".

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aec499c75cf8e0b599be4d559e6922b613085f8f

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
Changes in v6:
- Rebased on ukleinek/pwm/for-next.
- (2/3)
  - Round a too-large period or duty cycle down to the largest achievable
    value, and emulate 0%/100% relative duty cycles by parking the channel,
    instead of erroring out. (Uwe)
  - Choose the period from the requested period alone, so it no longer
    depends on the requested duty cycle. (Uwe)
  - Convert the period to ticks and compute the high/low phases in the tick
    domain to avoid rounding errors. (Uwe)
  - Reconstruct the period in .get_state() with a single DIV_ROUND_UP_ULL()
    over both phases, shared by both polarities, and read the control
    register with FIELD_GET(). (Uwe)
  - Set an out-of-range clock rate to 0 so that source cannot be selected,
    and name both rates in the "no usable clock" error message. (Uwe)
  - Rename to_andes_pwm() to andes_pwm_from_chip(). (Uwe)
  - Capitalize error messages. (Uwe)
  - Tidy up the in-function comment and the limitations list.
- Link to v5: https://patch.msgid.link/20260330-andes-pwm-v5-0-01c59a659d2c@andestech.com

Changes in v5:
- Rebased on ukleinek/pwm/for-next
- (1/3)
  - Added Rob's reviewed-by tag.
- Link to v4: https://patch.msgid.link/20260204-andes-pwm-v4-0-67016bb13555@andestech.com

Changes in v4:
- Updated cover letter title and its commit message.
- (1/3)
    - Updated the compatibles and the binding file name.
    - Added the description to the binding.
    - Corrected device register size.
    - Dropped the changes to the MAINTAINERS file.
- (2/3)
    - Updated the driver name.
    - Made the driver support inversed polarity.
    - Changed the clock selection algorithm.
    - Made the configuration depend on ARCH_ANDES, instead of RISCV. (Krzysztof)
    - Dropped the changes to the MAINTAINERS file.
- (3/3) (new)
    - Collected all changes to the MAINTAINERS file into a single patch.
- Link to v3: https://patch.msgid.link/20250123193534.874256-1-ben717@andestech.com

Changes in v3:
- (1/2):
    - modified the compatible string. (Krzysztof)
- (2/2):
    - added a check for the clock rate to prevent the overflow warning.
      (kernel test robot)
    - removed the unnecessary check in .apply(). (kernel test robot)
- Link to v2: https://patch.msgid.link/20241202060147.1271264-1-ben717@andestech.com

Changes in v2:
- (1/2):
    - changed "title" in the yaml file.
    - removed vendor-specific property, and added clocks property.
- (2/2):
    - added a description for hardware limitations. (Uwe)
    - switched the clock parent depending on the requested setting
      instead of statically configuring the clock source in DT. (Uwe)
- Link to v1: https://patch.msgid.link/20241028102721.1961289-1-ben717@andestech.com

---
Ben Zong-You Xie (3):
      dt-bindings: pwm: add support for AE350 PWM controller
      pwm: add Andes PWM driver support
      MAINTAINERS: add an entry for Andes PWM driver

 .../bindings/pwm/andestech,ae350-pwm.yaml          |  61 ++++
 MAINTAINERS                                        |   6 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-andes.c                            | 343 +++++++++++++++++++++
 5 files changed, 421 insertions(+)
---
base-commit: 898ab0f30e008e411ce93ddf81c4099abd9d4e46
change-id: 20260204-andes-pwm-10ea6611c3cf

Best regards,
--  
Ben Zong-You Xie <ben717@andestech.com>



