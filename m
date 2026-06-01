Return-Path: <linux-pwm+bounces-9218-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEeBI+PeHWpsfQkAu9opvQ
	(envelope-from <linux-pwm+bounces-9218-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Jun 2026 21:34:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E64BA624B1A
	for <lists+linux-pwm@lfdr.de>; Mon, 01 Jun 2026 21:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 070843043520
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2026 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBD737D104;
	Mon,  1 Jun 2026 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7HvLvVO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81D360EDE;
	Mon,  1 Jun 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342091; cv=none; b=WIXCBGTyoGshjjJAyLabR94QkHh+xi6RDF0CFjaJIEGz/g+8nZy9qzuQERJ2lyjPsbRw3AYBDXzd4EDNSfalhfmjx4ktO6JUQ1+L232T5xy2qB2a87vRLDwCZyHhq31528Giwsi4TY7Q+Urz9jGRQXagekmlfYiSDlDxzEOxZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342091; c=relaxed/simple;
	bh=oJvVtxM1xLc2HjJ1CGbHcAeaHfyfE1pqqFuTdIpKjvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWoo9gBxZh3WMGBB+V3wJzm4T4z9Fsuso1bSKdWh696exhftG/BnkMSokF/eGKu52MwWtLJu5mCEMQWlYrwYGI74V94ZEFwRVQpr84PjZzSnCRnwKC7xoRmD1eCIdOdzDdzBxXfbxugGJbTNMr+Ns3B5ijzinpJKJr8parNRcSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7HvLvVO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EEE1F00893;
	Mon,  1 Jun 2026 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780342090;
	bh=tq9hC/3pSjCU1zQh1hrpFiGfKgYq/LkIGM+ulqsQyiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T7HvLvVOibi7qLus6vM4bZcU/nYKtFxRDkObZU4Ht6bjnAvszWEQaWIE7f3lghyIN
	 JJy7Nkxjyh196lRU2i44LmfFaBu4j75sVgtwkQFtOKctxO9UWvnC0wJjMkpziwbBhE
	 RL78lH7nm5ttrkft3JDArP2TxydubsfCNRQXstUb8LvJ+ItghrBrYCGbPz1/iJuFZE
	 884xhIC7/yhZvkL21KoTwua5HEf8//gMzUsFtJ5FF7HjGM5Dia1nhmsbsnrR08g/Ql
	 smWOIDdem/8ePu6Ik1FYG9j+QhoaHU5VzByUaJa/GFgY1N+yYnAHic48Jhnsa6iQRZ
	 TtzbXfCrhBeBQ==
From: Sven Peter <sven@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Joshua Peisach <jpeisach@ubuntu.com>,
	Michael Reeves <michael.reeves077@gmail.com>
Subject: Re: (subset) [PATCH v2 0/6] Initial Apple silicon M3 device trees and dt-bindings
Date: Mon,  1 Jun 2026 21:27:52 +0200
Message-ID: <178034193517.3711.18153194478204531400.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net>
References: <20260505-apple-m3-initial-devicetrees-v2-0-b0c2f3519e0e@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9218-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,ubuntu.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E64BA624B1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 05 May 2026 13:02:38 +0200, Janne Grunau wrote:
> Hej,
> 
> This series adds initial device trees for M3 Apple silicon devices. The
> device trees contain only a minimal set of hardware not going much
> beyond the minimum required for booting kernel and initramfs and
> verify via serial console that the hardware and drivers work.
> The hardware with the exception of the interrupt controller is
> compatible with the M1 and M2 SoCs and the existing drivers.
> `make dtbs_check` fails due to already applied and dropped apple,i2c
> dt-bindings change (commit c5f25f5800f5 ("dt-bindings: i2c: apple,i2c:
> Add t8122 compatible") in
> https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> i2c/for-next).
> 
> [...]

Applied to local tree (apple-soc/dt-7.2), thanks!

[1/6] dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible
      https://github.com/AsahiLinux/linux/commit/0407ad56fbbf

Best regards,
-- 
Sven Peter <sven@kernel.org>


