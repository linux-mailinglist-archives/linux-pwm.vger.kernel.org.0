Return-Path: <linux-pwm+bounces-9743-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E/kVBm9qV2o9NQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9743-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 13:09:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D875D614
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 13:09:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=UhOaT7Ad;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9743-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9743-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76814301A399
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 11:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD1A446842;
	Wed, 15 Jul 2026 11:05:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFD41D63E;
	Wed, 15 Jul 2026 11:05:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113529; cv=none; b=q72cQZBfhfHb8BZk8MqpFfgElnHIRv6tYvRJubSncP02EVUk9P2uw+m3SWm8amcib3o06HkTPcEpzvmkTKe4Ynn7k+fLtDztScHEa+LgnC1yQ9TNkGnjHHyn6q1j4pXSX/iORyU7Cl7nE0zstGRd1KuBQspOIj3e967p1AFuq1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113529; c=relaxed/simple;
	bh=l/qhZrympsE5KEgXEO5QvluKCO3+AiZ430txFKLvYOc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bI9Pui9ICVFcXIk1x/BEux4ErpqmqdOEntgFiBk8/rdv97HNgAzOwCAe40T/6cR3WUCGzKQpmNsjuRirpEkyxclV6h++czxDYtAOC4vZj62TR0w5trj0lVzVjGPiw7OVFMpC+MRBHFKMXUFNUdV2RdMlmga+5Q76j/MIQXXg83M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhOaT7Ad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0EBC2BCB7;
	Wed, 15 Jul 2026 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784113529;
	bh=l/qhZrympsE5KEgXEO5QvluKCO3+AiZ430txFKLvYOc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UhOaT7Ad5w6qHQ3wzVq5nS2AKh10RanDS4WUoF/VQ3KQhrJzGyp/ACUG7ew9aOug5
	 LthjuNow/lgrmMMlobiVO15h0NI2NFRKH9RKbWJiEzXeEr6xRZcljD8ecGKJedKK6H
	 +GuiJKgpyz3p7mk2oxxDd92nWSyhHI5jM+ACz9LbLxDaob6FoqyvMf6SogEsSPLlHQ
	 0a60+l1rlT3olmi0kcXf0y8R8X3lWzek8IX+DCGYJvJHy5/hbHxlrkuSa95IBcUGa8
	 w4PfELP+o+nontgkWdChhUX7tIBR5u1QHhl76iUby9W1+UcsMwM/kA8Lx1swpevnSI
	 +j/nDcUowmR3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6AC44508;
	Wed, 15 Jul 2026 11:05:29 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] pwm: loongson: Fix PWM configuration handling
Date: Wed, 15 Jul 2026 19:05:22 +0800
Message-Id: <20260715-pwm-loongson-fix-v3-0-0aab2847eaa7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJpV2oC/23NTQqDMBAF4KtI1p1iEo2mq96jdOFP1AFNJClpi
 3j3jkJBaJfvMe+bhQXj0QR2SRbmTcSAzlKQp4Q1Q2V7A9hSZiIVKlVcwPycYHTO9sFZ6PAFvJS
 FklnOjZaMZrM3VO/k7U55wPBw/r1/iHxrv5j6xSKHFDLN27qjk6rorv1U4Xhu3MQ2LIoDIP4Bg
 oA806KtdS7LQh+BdV0/yGReUvEAAAA=
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784113526; l=1512;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=l/qhZrympsE5KEgXEO5QvluKCO3+AiZ430txFKLvYOc=;
 b=pEOLPflSQeame2lfhTLdd//re8Wcx7yxsM+TMcZKaoDxNz7+eSNUqCh0bT7uJrqJD+gl30ZAc
 +zEP1fpAQQjAITDpavMJ6mBUX+z8dpF9mBZGuTZ2vGJW4Bx4hmOdUbf
X-Developer-Key: i=keguang.zhang@gmail.com; a=ed25519;
 pk=FMKGj/JgKll/MgClpNZ3frIIogsh5e5r8CeW2mr+WLs=
X-Endpoint-Received: by B4 Relay for keguang.zhang@gmail.com/20231129 with
 auth_id=102
X-Original-From: Keguang Zhang <keguang.zhang@gmail.com>
Reply-To: keguang.zhang@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9743-lists,linux-pwm=lfdr.de,keguang.zhang.gmail.com];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:keguang.zhang@gmail.com,m:keguangzhang@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	HAS_REPLYTO(0.00)[keguang.zhang@gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C3D875D614

This series fixes two issues in the Loongson PWM driver:

- Fix the handling of the Low Pulse Buffer Register, which was
  incorrectly treated as a duty-cycle register.

- Reset the PWM counter when disabling the PWM and release it when
  enabling the PWM so that updated LOW and PERIOD values are latched
  before the PWM starts running again.

The fixes were verified on LS1B, LS1C, and LS2K0300 boards.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes in v3:
- Calculate the low pulse as period - duty after rounding the duty cycle.
- Handle LOW > PERIOD in pwm_loongson_get_state().
- Add a Fixes tag to the second patch.
- Link to v2: https://lore.kernel.org/r/20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com

Changes in v2:
- Drop the -ERANGE return change and restore the original behavior.
- Use mul_u64_u64_div_u64_roundup() to calculate the low pulse width.
- Update the commit message accordingly.
- Link to v1: https://lore.kernel.org/r/20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com

---
Keguang Zhang (2):
      pwm: loongson: Fix low pulse buffer register handling
      pwm: loongson: Reload PWM configuration through counter reset

 drivers/pwm/pwm-loongson.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)
---
base-commit: cc2b5f627e8ccbae1188ef2d8be3e451d7f933a5
change-id: 20260612-pwm-loongson-fix-183763451e93

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>



