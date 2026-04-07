Return-Path: <linux-pwm+bounces-8511-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCNvAuIt1WmF2AcAu9opvQ
	(envelope-from <linux-pwm+bounces-8511-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:16:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4A83B1A33
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D5BF3087B8A
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2026 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9825B393DD9;
	Tue,  7 Apr 2026 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIAC5Y/L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A485C386C3A;
	Tue,  7 Apr 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578068; cv=none; b=blr1g3Ljn/ar+igVwGT2qRj0vAIL3KaoxbhXgJPz39fJVXaRJU+NUd7/okuCEKlE6DvkGQHWZAvrQRfa+CVuZ2RGjBq5CeHsmMnqNYdTK1J6PoZoDqEHmAr/5gStEyguIN4y5yZfuoHTtOk+Rv99UTyULVdYH9NiNs9/wJpCi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578068; c=relaxed/simple;
	bh=a8f50lh5fA9hxzVyPE4idNgBqFtpQ3j17xPrmyDtRAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDerbNxo0ZBzIYry/YqXZC+yVMwSywP9z21WwjQmyZhqIzqq6/YkoQXE7x4qq6VrYH6BlCpdQzqz8Fk6eiPGz4koV2nBMxcEmpELFHMTGF8Z2TCLHr5QGUacENkz7AqPUREMGGVkQWIM1JvRxIPH1QmicSzXO3B4Yi/ajyj2hw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIAC5Y/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78F0C116C6;
	Tue,  7 Apr 2026 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578068;
	bh=a8f50lh5fA9hxzVyPE4idNgBqFtpQ3j17xPrmyDtRAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uIAC5Y/LBhLO9INatQI6tmlUtW5UHotCnMhrz2f6dSE1am4z1kzi5V7ideheHP3MO
	 z2MYeMxfqcRI/fnvc4sC7BMxyHnUymQOpY44/CLIbSpqdYrduI4EMuBV6++ugdU9OD
	 oqeM5oEC1JnyUXszbv+WIxUUHt1oNpMFVhKQJdfS1IC+dDDmRudnTIX4cSNT2NWmnS
	 fT8t5TApXAuIs+7IOqn7zAcK8ZLSBawLkg6xk3IJdWU8fwBMmmumEVT3vofmawZ/kl
	 qkptwfxGa2006RXFhO3ZtJ/e2CLA5rgIDY8+8f4XpoO4++x0KBjdGk9L5nKNlktkFO
	 q4TG+e6v1x8xg==
Date: Tue, 7 Apr 2026 11:07:46 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>, linux-i2c@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	devicetree@vger.kernel.org,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sven Peter <sven@kernel.org>, asahi@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 4/9] dt-bindings: watchdog: apple,wdt: Add t8122
 compatible
Message-ID: <177557806556.2661973.776224786066669604.robh@kernel.org>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-4-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-4-5842e1e393a8@jannau.net>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gompa.dev,vger.kernel.org,kernel.org,openbsd.org,roeck-us.net,gmail.com,linux-watchdog.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-8511-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C4A83B1A33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 20 Mar 2026 13:23:22 +0100, Janne Grunau wrote:
> The watchdog on the Apple silicon t8122 (M3) SoC is compatible with the
> existing driver. Add "apple,t8122-wdt" as SoC specific compatible under
> "apple,t8103-wdt" used by the driver.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/watchdog/apple,wdt.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


