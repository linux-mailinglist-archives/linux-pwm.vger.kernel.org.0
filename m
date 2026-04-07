Return-Path: <linux-pwm+bounces-8510-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJdoMSUt1Wli1wcAu9opvQ
	(envelope-from <linux-pwm+bounces-8510-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:13:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A86003B18FE
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B2113049ECE
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2026 16:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561E386C1F;
	Tue,  7 Apr 2026 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgUdQPKi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69C234973;
	Tue,  7 Apr 2026 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578048; cv=none; b=LAcSGBBnWgYDZccFhytdygNFv7vumrQJ+dhFRUP8TlG+C/vxV0m1lsuCLVDoY0b4WCKOOpMSOVgLM1zWRMPjtgDFwqnvnq/3UnbE8wyIzC2s0vmSTlDbDeKNAqJUd2daM7SbZRASnR34wHVMcOcZsBZj4mujEyBdAghKyLOSOt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578048; c=relaxed/simple;
	bh=PeC5naBBK1FeWu9bbU5Wh9SWJPCNfdcAAENIH6WbzAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvMBg7vmsP+2/mQ10eC/fq2Fc6w8Pr1KWYS+b0Z3bxnFbDKtFI0H3kHGpmLSaqKMtakc80NBPq/asjOL8RDHZY7k9T6i+5XyIrwzzK/CyFp60e5jvJnkJftbu1ZVG+SjrbX5ksHlSJ0x7fOJhBJPjM/RAMDLa9RZ8nu4+ILtUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgUdQPKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C401C116C6;
	Tue,  7 Apr 2026 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578047;
	bh=PeC5naBBK1FeWu9bbU5Wh9SWJPCNfdcAAENIH6WbzAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgUdQPKiI7+sUGUYqoVbVSoQJwGUCcM+skVp99Ax7Y6CHnI3QY0QuZ7QUP0kEz5Zr
	 NmpSCseM3p6BQu4dXM2pnPTDnSXsV6fggo4YsrHNv53xc7CAndXTN5zx+nzEoL+rp8
	 IRHA/XryRhKtEhrRk9KtCt0yPLwISGHXDwe3dmbz9LD984cwsos/ii+MXujyUfzHW1
	 kxIuio9dIwIWiSRiS6Xr4KV9vRqiIiTZVcDSv8blGw3UxPQYKjMAyI7M2ON36nAzh9
	 YOdTMIEaE2xDXW0lhsJ5U6PGFKEtq9boshHS1jX/AgAU4zvKGtbSY6K1Pg6ab8VUji
	 /bV2K6UakFnXw==
Date: Tue, 7 Apr 2026 11:07:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, asahi@lists.linux.dev,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-pwm@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-watchdog@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/9] dt-bindings: arm: apple: apple,pmgr: Add t8122
 compatible
Message-ID: <177557804504.2661217.32030940173770569.robh@kernel.org>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-2-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-2-5842e1e393a8@jannau.net>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,vger.kernel.org,lists.linux.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-8510-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,jannau.net:email]
X-Rspamd-Queue-Id: A86003B18FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 20 Mar 2026 13:23:20 +0100, Janne Grunau wrote:
> The PMGR blocks on Apple silicon M3 SoCs (t8122) are compatible with the
> M1 and M2 predecessors. Add "apple,t8122-pmgr" as M3 specific
> compatible.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


