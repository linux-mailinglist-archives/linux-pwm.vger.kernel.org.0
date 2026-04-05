Return-Path: <linux-pwm+bounces-8478-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MdyqGrAU0mnmTAcAu9opvQ
	(envelope-from <linux-pwm+bounces-8478-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Apr 2026 09:52:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A439DB4E
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Apr 2026 09:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E78D3006B0A
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Apr 2026 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1636A03C;
	Sun,  5 Apr 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYdvxgMU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360C40DFAF;
	Sun,  5 Apr 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775375533; cv=none; b=PhoBNl7hED0YfhGnDeHKRPWD/W05zJrKwsQX7Q5/Xtfady2DWh8rqt/E9o5GR+LEMGzTF9LUGvx59RRMVeB5pvsMFIYHx6qGgo9DeGJS485JbMit7Q6SrtVoF5bx4vEQkKZBue+e8C0AOkc6HnqNTEUmMtvYpNuKCyYQNT/1b7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775375533; c=relaxed/simple;
	bh=i5I87xe3rCX6jakt5XfSPaCxSLCt3vmnBkAl2OH+qO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irq4iCvSc7bsUd57Uy0azVI7jXSqTu2qLLeZzTpbGWCG2qkZ74BYBL3YGNbBS9Exwl8i+0n/ogwCtt+Hybsg2f7sKGj7aLDF8BfityNvZGvTZNfnUihstIchSglS4rLPFo3Ew0ALvLMdaF3VlCiwXK6lEAjxRGZjq4mrO6zhjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYdvxgMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8874AC116C6;
	Sun,  5 Apr 2026 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775375533;
	bh=i5I87xe3rCX6jakt5XfSPaCxSLCt3vmnBkAl2OH+qO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYdvxgMUJ8yNZjPasLh9fx9kB58YSGry8Q2LIW42mRsBu4vcmP/X02G982jWk9TH7
	 WJ3vXB/pYzX5/MoYbSdpDSBeRVqd01JQJK/agrV8J1AFJz7UUxiw6FsVpkGrdd7NHy
	 oCE8VDDwfDhG8MvSYD1niXsklqmiQBCp+5TIJLLy1pV/6f0z9n+38D0NEAfXMygDV2
	 zB1MAlAxhBocqKo34PWuOI2fkSN9geyXhhhHZTGQOVeIn9Ht87Ys9DLFRaWCPn6OzD
	 sgVz44yGwN7bsfkJf4P1bLDfrSVtcbGKoo9/Kh1NvA1CaaEn4OdwDrv/fnnjP7Q5dN
	 SnEGpNKi1l13A==
Date: Sun, 5 Apr 2026 09:52:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Message-ID: <20260405-enormous-glittering-avocet-285f82@quoll>
References: <cover.1775223441.git.andrea.porta@suse.com>
 <11b5eee3c22cfd034bb4b425d28a5a3ff2a71828.1775223441.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11b5eee3c22cfd034bb4b425d28a5a3ff2a71828.1775223441.git.andrea.porta@suse.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8478-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D24A439DB4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 04:31:54PM +0200, Andrea della Porta wrote:
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +

Missing ref to pwm.yaml.

> +additionalProperties: false

and this should be unevaluatedProperties. See other files.

Best regards,
Krzysztof


