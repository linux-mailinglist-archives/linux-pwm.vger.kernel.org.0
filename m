Return-Path: <linux-pwm+bounces-8513-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COFyK/ct1Wli1wcAu9opvQ
	(envelope-from <linux-pwm+bounces-8513-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:16:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEAF3B1A53
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFA23310C030
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2026 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBFA3D5236;
	Tue,  7 Apr 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJuEw+gY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E163CFF5D;
	Tue,  7 Apr 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578101; cv=none; b=oXYh0p9lFznV1QePCabws8WsKzq9ONILdGeVG8uTJa+d/8bx8TFCkUXE2ulpptXAcXCH7h6BcepDdWQ0KxXuzpPHk5ISYcA6uS55i1Il6yPMBBUZHnF7njWy6mPtWdilCpjajCPZB8+F27F+qqK4FeY829ZoIWEEchesoAoZeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578101; c=relaxed/simple;
	bh=PXBAi1nyZNe0POH0mrVfGKnl6R46G/pAs4DRJvmzDcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqQGIpO+d5PGJ+s5sI/TMIW31j7nFiySva45eBFzgpPE01G4mjsxs25Nrsfd+r73B6pkCZh/OtbPnRp7GHb9XCHcFsY+g4jbRpPvimPkcwLX838oNskX5wHs2De4MjXoSk/tFoXZvgGyfWnwunFm60X3kb0ka/S8M1iBncbF+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJuEw+gY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9560C116C6;
	Tue,  7 Apr 2026 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578101;
	bh=PXBAi1nyZNe0POH0mrVfGKnl6R46G/pAs4DRJvmzDcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJuEw+gYV/IV/rNgCegLEhZWu9yKusTM1hwRgmswBM4lx9MkmxBLHBtA10oBsRSE9
	 jwYiq291dPLBtIpwErtS8e+LJxOCvgtDGNsHujnAy4FwG6ILF1dVcki0gNwOpqNk/I
	 QicjuFPEPsD5nUg1izW//M3psyDyF+idf2LeH1h+dCuW3fvQlMZpxe0tzCO0qKbzMt
	 FeJvIsRc9ivR1FsAI7oSYvXKktKANgo3M1VBOkcfklSgfn90aNMqYN90Jm6A12s+JB
	 Ee159BX70fNy3p5ufpCDLLt/GEIF5oyxprLbAYvaJLI6qinSNgvI6eh3p2tGpUg3el
	 bBf4I1kCpYwcQ==
Date: Tue, 7 Apr 2026 11:08:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sven Peter <sven@kernel.org>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	devicetree@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev, Mark Kettenis <kettenis@openbsd.org>,
	linux-pwm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 6/9] dt-bindings: i2c: apple,i2c: Add t8122 compatible
Message-ID: <177557809827.2662834.14463962257840305430.robh@kernel.org>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-6-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-6-5842e1e393a8@jannau.net>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-watchdog.org,vger.kernel.org,gmail.com,gompa.dev,lists.linux.dev,openbsd.org,roeck-us.net,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-8513-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3BEAF3B1A53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 20 Mar 2026 13:23:24 +0100, Janne Grunau wrote:
> The i2c block on the Apple silicon t8122 (M3) SoC is compatible with the
> existing driver. Add "apple,t8122-i2c" as SoC specific compatible under
> "apple,t8103-i2c" used by the deriver.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


