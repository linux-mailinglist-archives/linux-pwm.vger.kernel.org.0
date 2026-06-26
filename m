Return-Path: <linux-pwm+bounces-9401-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NgG0JtBvPmpZGAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9401-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:25:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B56CCF66
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:25:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=R+yGa1XE;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9401-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9401-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF2CE30086C0
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC163F4DC7;
	Fri, 26 Jun 2026 12:24:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05A3F484E;
	Fri, 26 Jun 2026 12:24:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476686; cv=none; b=r+k+HbrtxzFwnedIyeCZzLnQ9i/x6LELWMwzF/9p+Phy8o7EUS7v5fUoSW9mjGXX+MbKVaq3NTcdt3vh4OVgSnKYw4XqvK7bLIRhmeJW2oxK28HMx3a21l5j17Fu+65y6hZ//5wkLFM1ytijPw3B9Y3bum08cZK5UntOEw7q7FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476686; c=relaxed/simple;
	bh=oo2KlzchszEKmeSlzGlrVuSsrAVnItDyZhmcgHfi0oY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hABb0bHIu0fXGPWPSWV3Hciknaefsyb7eI3QB541fpm//314jRfhKfmWjbxdUFW+D9HN+HekSaHK3+R4SSGkTlIpEascqxVBeWwqircpGRuHgdbG93zttxs9dyElHdS2Ksn3+4qv0OM+l5XQsbS2D/7DBYdLnFllMA5YIgF7VJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+yGa1XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9875AC2BCB7;
	Fri, 26 Jun 2026 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782476685;
	bh=oo2KlzchszEKmeSlzGlrVuSsrAVnItDyZhmcgHfi0oY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=R+yGa1XEeK/qR4yxy8zPolNmFoe5HO/EawNO9Yc6uRlG8g28FGQR2n0IPXUu8bGBh
	 Bf8mOQG9BDqhqpXeNJYAhdk6fJSYp8PQl3jMJA5F4rmz98soy71/ZrLjDP+M1t8h3N
	 Y+wypl5fkX0P4yLoBhid2T8We6HTrPFsoHoDejPQuLQwrxjA8Is6DXPbpx4MUz+8Ae
	 A083wf1CyFLnyqcsEH/QAoTH3SQ1dC9orvV3of0XizMWeQuwE6YFdZguJQO+E1k5Zr
	 dbFrxHJ4CQcq5kpR8Kamc6BRvRZh2ruytB8YYq20kkDwIzadrvUJe5W7W2YbNoSKCz
	 IcllxUO2dmabQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C354CDE00E;
	Fri, 26 Jun 2026 12:24:45 +0000 (UTC)
From: Keguang Zhang via B4 Relay <devnull+keguang.zhang.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] pwm: loongson: Fix PWM configuration handling
Date: Fri, 26 Jun 2026 20:24:21 +0800
Message-Id: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVvPmoC/2WNQQ7CIBREr9L8td8UqNS68h6mC2yh/UmBBgxqG
 u4uNnHl8k1m3mwQdSAd4VJtEHSiSN4V4IcKhlm5SSONhYHXXNaScVyfFhfv3RS9Q0MvZGfRStG
 cmO4ElNkadIl35a0vPFN8+PDeHxL7pj+Z/JclhjU2HRvvplRUa66TVbQcB2+hzzl/AP62C6SwA
 AAA
To: Binbin Zhou <zhoubinbin@loongson.cn>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Keguang Zhang <keguang.zhang@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782476683; l=1224;
 i=keguang.zhang@gmail.com; s=20231129; h=from:subject:message-id;
 bh=oo2KlzchszEKmeSlzGlrVuSsrAVnItDyZhmcgHfi0oY=;
 b=qNJb8qLIPXV6XX5uBmcZnye20QRHXS9ZDd35ewgEa3iqZ7zJfw7kKAODKUF6uiwsRbBweZ2aI
 GmqMfdm1jzBBDoWSj1RFEv2orvOlUGBI6o4sggv8QwxSgv5wG5krdJM
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9401-lists,linux-pwm=lfdr.de,keguang.zhang.gmail.com];
	FORGED_RECIPIENTS(0.00)[m:zhoubinbin@loongson.cn,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:keguang.zhang@gmail.com,m:keguangzhang@gmail.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 348B56CCF66

This series fixes two issues in the Loongson PWM driver:

- Fix the handling of the Low Pulse Buffer Register, which was
  incorrectly treated as a duty-cycle register.

- Reset the PWM counter when disabling the PWM and release it when
  enabling the PWM so that updated LOW and PERIOD values are latched
  before the PWM starts running again.

The fixes were verified on LS1B, LS1C, and LS2K0300 boards.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
Changes in v2:
- Drop the -ERANGE return change and restore the original behavior.
- Use mul_u64_u64_div_u64_roundup() to calculate the low pulse width.
- Update the commit message accordingly.
- Link to v1: https://lore.kernel.org/r/20260616-pwm-loongson-fix-v1-0-491dbf260a7f@gmail.com

---
Keguang Zhang (2):
      pwm: loongson: Fix low pulse buffer register handling
      pwm: loongson: Reload PWM configuration through counter reset

 drivers/pwm/pwm-loongson.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)
---
base-commit: 8d6dbbbe3ba62de0a63e962ee004afb848c8e3ac
change-id: 20260612-pwm-loongson-fix-183763451e93

Best regards,
-- 
Keguang Zhang <keguang.zhang@gmail.com>



