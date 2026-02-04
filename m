Return-Path: <linux-pwm+bounces-8092-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPHHHvAtg2kwjAMAu9opvQ
	(envelope-from <linux-pwm+bounces-8092-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:30:56 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B5E523B
	for <lists+linux-pwm@lfdr.de>; Wed, 04 Feb 2026 12:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26FAB3010146
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Feb 2026 11:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97A32ABCD;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGWrD8Tq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E032571B;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204642; cv=none; b=ATkOiav+cA+CQXhqQMkuIiNzQSc+tTpxyCtYaPpPxDH8WVqZOZcNCbkdtJXTlJrL/vUgV8NB1aMzT/zqTYv4WGeN4SKXGXoBxsrYaHaUlsZmWb8jYh1zonYvWQWE+v2Z5VWBvkydz0B9p6VQHrwv1Yyijsn+sN/O0FAuNXoaJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204642; c=relaxed/simple;
	bh=3Qoag22QfHkljcDoVCkjtyQ2+4W+gOHp2y/mu70bSTc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eU5ssxcFrlktXvjntlRModNfXBoPFEtjoNI+HyqvOLpm+0pTW513ri4l8mihcE6Ocn54KkSyUifCFvl/LPXq1xJTxsRJckR2WxhbfZhcJleh8aSDBCS8asOhluEiz5CcYTculhgKZ5BBaKuwAqc2KKi9fZU/MB0Ss/oVJzVz3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGWrD8Tq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70477C4CEF7;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770204642;
	bh=3Qoag22QfHkljcDoVCkjtyQ2+4W+gOHp2y/mu70bSTc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dGWrD8TqLTYCOjIji6OIQP+nQ1wnAOHCFHzjtkawQPUL8eDA3QTCo0ehCJat/XXrb
	 uWDQATOev1geMMIvhZ/qIUdWlvHL7m6R3p+p8m4Zx6mkL9L4RBaxSLIELAVxegk5Vh
	 5H6X4fJLKO5hgGgwC3Xen8/1qyGCMW+B0WRXihb6MoBId1XcVJRX0rYybBc0/1iQBh
	 ECm5BNa6JtmbqxgHAgCI+eJAPdgQI4eRcCj7MevW7zBchzwq3dPcEhKweoIRXM058U
	 LOGqmZ6oEOGJiSPWb9ceD2KL6eng5X1tyBWWGFv0BLED+E9KFVxoiJOKsF6k72+DGc
	 aV3Vs9yNsHaIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C212E9538A;
	Wed,  4 Feb 2026 11:30:42 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Subject: [PATCH v4 0/3] pwm: add support for Andes platform
Date: Wed, 04 Feb 2026 19:30:40 +0800
Message-Id: <20260204-andes-pwm-v4-0-67016bb13555@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAtg2kC/32Nyw6CMBBFf8V0bUlnWlpw5X8YF1AGqQmPUEQN4
 d9tMcaVLmaSm9xz7sI8jY48O+wWNtLsvOu7ENR+x2xTdBfirgqZoUAtUChedBV5PtxbDoIKrQG
 stDUL/WGk2j021+n8zv5WXslOURAbjfNTPz63sRliL3oVCMzCGYQEcg2Y5Rx4SZ0Bc9zmJrJNY
 vuWRe2MXzA8oQUokwAaQK3+gvIDpgJQQi5TqZLMKEz1T25d1xdWMcSzJAEAAA==
X-Change-ID: 20260204-andes-pwm-10ea6611c3cf
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770204641; l=3232;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=3Qoag22QfHkljcDoVCkjtyQ2+4W+gOHp2y/mu70bSTc=;
 b=KW5KWM+YBOpWcm4Ri4pd6+VYTq8E60auwgmivEt/zZXM0QIG2zEJH7N0B3Rs/ldPvCGqup0e0
 OphjzW35qx2CRc/CL92tAbgm56kXQNjtd4Az03fJaVHV0U0649lVVPy
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8092-lists,linux-pwm=lfdr.de,ben717.andestech.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	HAS_REPLYTO(0.00)[ben717@andestech.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: DC2B5E523B
X-Rspamd-Action: no action

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
 drivers/pwm/pwm-andes.c                            | 306 +++++++++++++++++++++
 5 files changed, 384 insertions(+)
---
base-commit: 9321f9d27fbaf6c4f32772fc2620961a0c492135
change-id: 20260204-andes-pwm-10ea6611c3cf

Best regards,
--  
Ben Zong-You Xie <ben717@andestech.com>



