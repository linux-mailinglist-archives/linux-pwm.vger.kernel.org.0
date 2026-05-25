Return-Path: <linux-pwm+bounces-9100-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKK9AbsVFGpOJgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9100-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 11:26:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0E45C889F
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 11:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F8273005769
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46903E5EC1;
	Mon, 25 May 2026 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7H8MfXD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1D3E5A32;
	Mon, 25 May 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701167; cv=none; b=G1cVuzqSPuw3H071PtPEDv1+9TaDMELcy6Vrz6EnqAUnCanJKdrNGWqPD1WvBGx65Q5Q94xrnjJOdQlOMBbELOP2Z/Rhfz26zblbnyVWcWsjN+HmbxI0pSG23ld+zrVvvceR9yQwJ25C893MIVpyNnkLPBzHrouY4YjVAByOsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701167; c=relaxed/simple;
	bh=jmYi9k8kfIYDV6PSc0blAw2ZCe6obcAFkc4TkEVBsD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z104y+NCD/uTTfSCAHgIEO3k1gw+qNdD2zDJiNweiNflheIZzJfmOzfSf6yrxwXzLupGiGAQyhfRwDms+MyY9i0Ic5YaIrOWk9/Q7+Ayg+v/ZVYUJkvzmhnc9vGyj2vJup1jcnY9Fi936Fs223/d50RA8P0vXhcGnHez7I+Dsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7H8MfXD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A02E1F000E9;
	Mon, 25 May 2026 09:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701166;
	bh=skzTssuwru7jF3TpsgIsQPJu8IbIuLMfcBBNvTemjVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H7H8MfXDgcg2czwLwQhZFCL2kqMjRCt9tXoVzp4zeEDmKAYkQrEXUVc2JEUW2iIjK
	 Vuzy3H5k3Lla3w9XIbEjkEw8EIAEUxPr9Ik+YywZqcE3XvMlv0kK6kyA9tTXjno7ax
	 YZGG6k95KRRS3MHsk0avHWKKMJA+wHrlHeDeeYtuBWyv+l8X9+TDVPr8HJxWx+TXLZ
	 DzQ4fKJC3n1V0kfuXrlqZ9kmDUuSBoEywRGAyrWlR1QAL/PvGbajSvlG5VuW6KgYe8
	 Pg9qRoSl+NV2ibriujglyE7gRvcEXZwZx+fG2cs5PIfYpf+TQ44LxUg/jTMrE4RZvv
	 Sdbjhi2TLVoxQ==
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
Subject: Re: (subset) [PATCH v3 0/5] Initial Apple silicon M3 device trees and dt-bindings
Date: Mon, 25 May 2026 11:25:48 +0200
Message-ID: <177970089799.4336.5106410094266979561.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
References: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9100-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8F0E45C889F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 07 May 2026 09:33:06 +0200, Janne Grunau wrote:
> Hej,
> 
> This series adds initial device trees for M3 Apple silicon devices. The
> device trees contain only a minimal set of hardware not going much
> beyond the minimum required for booting kernel and initramfs and
> verify via serial console that the hardware and drivers work.
> The hardware with the exception of the interrupt controller is
> compatible with the M1 and M2 SoCs and the existing drivers.
> `make dtbs_check` depends on the already applied and dropped apple,i2c
> and apple,pmgr dt-binding changes.
> The watchdog load depends on stalled and forgotten addition of the
> "apple,t8103-wdt" compatible posted in [1]. I've replied to the thread
> to get the change merged.
> 
> [...]

Applied to local tree (apple-soc/dt-7.2), thanks!

[1/5] dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible
      https://github.com/AsahiLinux/linux/commit/4d28a9a428f6
[3/5] dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
      https://github.com/AsahiLinux/linux/commit/d0960529afbd
[4/5] dt-bindings: arm: apple: Add M3 based devices
      https://github.com/AsahiLinux/linux/commit/5701af106b03
[5/5] arm64: dts: apple: Initial t8122 (M3) device trees
      https://github.com/AsahiLinux/linux/commit/1dfa78533534

Best regards,
-- 
Sven Peter <sven@kernel.org>


