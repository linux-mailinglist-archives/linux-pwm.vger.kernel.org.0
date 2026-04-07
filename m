Return-Path: <linux-pwm+bounces-8512-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP39MYMt1Wli1wcAu9opvQ
	(envelope-from <linux-pwm+bounces-8512-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:14:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 737403B197A
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E16C304F64D
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2026 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC83D412B;
	Tue,  7 Apr 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DED6xyp8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A003AB29C;
	Tue,  7 Apr 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578085; cv=none; b=Z8h7Be3mDGE5+XhgDoKSfODNJhRcS2F3E0Ldzhr4uTQNgHBvZ1l9ZwN3cPeDNK1Osk59agAzQ/3MakPHOptWPzllhcKwCU4KQRAeUvP1KVdCfXHEYsk0aGZsXY00w3FXLCFHONceBYzOUICB5JsfG3DBMjdKzDe/cKAkev1EaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578085; c=relaxed/simple;
	bh=8trqOvymtySKFHxGiIFzGhJy6W6b/leyLuH7GdE85NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkUbUMrZ44cpPM/CMMlDMPQ0ROISqjeoePksZrC1QRbuAcF55J8Z0AupHsOJSedjDUXUtQv6beIEah8RlFDFOgz4ezyvsPsRE4P9YRUHlibcSX0ZkKzzIY75taGLtwISryP3oBXsWqDWAR1hcDG9LAZ1xYDOmKOgSNAAMR14268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DED6xyp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C76C116C6;
	Tue,  7 Apr 2026 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578084;
	bh=8trqOvymtySKFHxGiIFzGhJy6W6b/leyLuH7GdE85NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DED6xyp8G2cygWWTVjdVo3Xj1yqlt4lpXXCHuiVr7MI7Wvtr0AeXaEfphlZCY2LKO
	 +ZWxjNvBZ/UcoHoGLfLwJpu++uAEMkpwWF5y+59b00Zrk7gJIMn7zQbpShgemHm1qD
	 OHJ47FEE+njXpJQfZavqb4aAWrJINz5bkF+RAcc/4Q0a+t7W88Df9NRe39rV3eCOfb
	 3pRIpVQvw2kgxFt07QzkK8JAFvb4Sdi6O0R8jAr+6NJFoctlooF/7o3u3MqGX85Tid
	 2T84BiCzh2J/521wLLSnL5vcGzs1uqpUkqU/qICKf7i2hSIAq9exH89fdL/Op6Yc7R
	 A31DLJ2Ks9hqg==
Date: Tue, 7 Apr 2026 11:08:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Neal Gompa <neal@gompa.dev>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>, asahi@lists.linux.dev,
	linux-watchdog@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 3/9] dt-bindings: power: apple,pmgr-pwrstate: Add t8122
 compatible
Message-ID: <177557808164.2662432.8266259969992444267.robh@kernel.org>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-3-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-3-5842e1e393a8@jannau.net>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,linux-watchdog.org,openbsd.org,gompa.dev,gmail.com,roeck-us.net,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-8512-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,jannau.net:email]
X-Rspamd-Queue-Id: 737403B197A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 20 Mar 2026 13:23:21 +0100, Janne Grunau wrote:
> The device power state management of the PMGR blocks on Apple's t8122
> SoC (M3) is compatible with the existing driver.
> Add "apple,t8122-pmgr-pwrstate" as SoC specific compatible under the
> existing "apple,t8103-pmgr-pwrstate" used by the driver.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


