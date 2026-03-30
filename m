Return-Path: <linux-pwm+bounces-8405-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Lh8JkUqymnX5gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8405-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 09:46:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C09356985
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 09:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D064E3007E39
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170A83A2549;
	Mon, 30 Mar 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLE0g4ON"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D83A6B72;
	Mon, 30 Mar 2026 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856745; cv=none; b=dEo34vRI2qEfp/3CR7ShyngUOXYTsLDyGMqYI7xd86zvL0dSN7E90sZRKRnUitxflhlynbu2etgRBhJYszkJgMbNxSQcME4bKJlQrU/zvL2BpUTduKLdD1kEX3yUsxDl8ena2eIijczob0RF3U0BVBECPj7nqL8UR4fqVQrFbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856745; c=relaxed/simple;
	bh=7Fo3jVCC8hwVStRvGW0Q1tYK6679IPrcIgWpjNA/zQc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KCLtR6UpjGyKHaVRZ2d0UKDgd9biirawsfVVXDbbiX9OCiDtQJzE1pOrY7CbIXAO0p6JkE761NzirUgTZjw6WDfLVPBCD+fVvw7z8mJmslOZRSVcbajbg4NXcK8I1+GJ4XRAV7pPlEfjauQ8nRGoJn+HtHFy+TNLp0bjFDeYB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLE0g4ON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A577C4CEF7;
	Mon, 30 Mar 2026 07:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774856745;
	bh=7Fo3jVCC8hwVStRvGW0Q1tYK6679IPrcIgWpjNA/zQc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZLE0g4ONVGsyFGRxsfoKGTVUpR4xapqWvLdpJQivjod6U7Mjb4CtXEZix1KlD4VYt
	 4kMi4j/Z1tGmF4zxB9Fc4LhMAhortUDFYAgrDUoFmJVgqzKkk36/xD6sVTv37E/CDg
	 zj9i7goZeRNkrog5NXThCBGOO9yu0V5M70RIor8nv7Leos2vR7GtsyEP4/S6bskyWL
	 ODmJ+00f0kbt3HLvxyz/aU9UEgNTOjqnePGHSsavNl28dSqV4UhSSwXfRN7zCw20Pf
	 /lcvlK275MAg4dWg84KoIsiFF48+8/zxY3r7vg+pMI1Hhsl/PGV9MQrRgCSPELCT5/
	 2DUJHvMnds5dg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F856FF4958;
	Mon, 30 Mar 2026 07:45:45 +0000 (UTC)
From: Ben Zong-You Xie via B4 Relay <devnull+ben717.andestech.com@kernel.org>
Subject: [PATCH v5 0/3] pwm: add support for Andes platform
Date: Mon, 30 Mar 2026 15:45:42 +0800
Message-Id: <20260330-andes-pwm-v5-0-01c59a659d2c@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACYqymkC/32QwWrDMAyGX6X4PAdJtuVkp73H2CFx1caDJiXOs
 o2Sd6+dUgo99CDBD//3CXRRSaYoSb3vLmqSJaY4Djm4t50KfTscRcd9zoqAGAisboe9JH3+PWk
 EaZkRgwkHlfvnSQ7xb3N9ft1y+um+JcxFUBp9TPM4/W/HFiy94rUIVOfxhBU2jFQ3GnUng0f/s
 Z2bJfRVGE+qaBd6gHkBA1pfIXkkti9BcwcdIBlsjDO2qr0lxy85e+eeP7BYDZo9IHcdGufcM72
 u6xUCeadEYgEAAA==
X-Change-ID: 20260204-andes-pwm-10ea6611c3cf
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Zong-You Xie <ben717@andestech.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774856744; l=3420;
 i=ben717@andestech.com; s=20260120; h=from:subject:message-id;
 bh=7Fo3jVCC8hwVStRvGW0Q1tYK6679IPrcIgWpjNA/zQc=;
 b=AjO4pcGgOeZO6/wJevhW4+mYZ4WFVj7fGjv6oHVG3RMT4n07LkN/Enq3OVwJ/xTkCGB7T9FSb
 wGZvW9/8+sdAwamFfCKrfpGQECuRCYWgl2CrG3Z30Z+tUVdLzS8OAcm
X-Developer-Key: i=ben717@andestech.com; a=ed25519;
 pk=nb8L7zQKGJpYk0yvrYKjViOZ34A36g1ZIsCmCsP518s=
X-Endpoint-Received: by B4 Relay for ben717@andestech.com/20260120 with
 auth_id=610
X-Original-From: Ben Zong-You Xie <ben717@andestech.com>
Reply-To: ben717@andestech.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8405-lists,linux-pwm=lfdr.de,ben717.andestech.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	HAS_REPLYTO(0.00)[ben717@andestech.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,andestech.com:email,andestech.com:replyto,andestech.com:mid]
X-Rspamd-Queue-Id: E0C09356985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v5:
- Rebased on ukleinek/pwm/for-next
- (1/4)
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
 drivers/pwm/pwm-andes.c                            | 306 +++++++++++++++++++++
 5 files changed, 384 insertions(+)
---
base-commit: aa8f35172ab66c57d4355a8c4e28d05b44c938e3
change-id: 20260204-andes-pwm-10ea6611c3cf

Best regards,
--  
Ben Zong-You Xie <ben717@andestech.com>



