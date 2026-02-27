Return-Path: <linux-pwm+bounces-8169-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JYaJwBMoWkKsAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8169-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 08:47:12 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C061B4145
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 08:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38FE7305EB9A
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1C3451CC;
	Fri, 27 Feb 2026 07:46:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C751397;
	Fri, 27 Feb 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772178417; cv=none; b=T79yb8iPIAwUY9RpEiC04vOkwDTT7AC7gOlS9DgzZLHabiqOu3FlFR/RTxnrAv0Q3Nm9ZZFbG1iFEF2G/yUCXRpxPYmyXlzt+B50hNH4gqFGFRGDTplan9PgtyawvGDGg/hPMqQ5uNqEuhxxR12SvMuRWdGgMn/Lk8yV3EKEvws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772178417; c=relaxed/simple;
	bh=Swi2P6Q/gTmIpsIEdrPw6i8z8fdQ4iYvhdMTsDeq/eo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Sxo/PCIk98rai6eeebk1v98aKRy92Rt3PhvHzZWQ0BqAzSCGDf3B7ZWZF96yQ6IUFTwcl+ERVSw1cpeoO3Go7Xc1oQv/JRXqUx/dgFvOjAUXMASPWol55Yj774f0eQBtKohaJDq2QmwVpRiH8PFLSNd04lAl0/7+akrI+Qp/jJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D2B11298580;
	Fri, 27 Feb 2026 08:46:52 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id hfUOubwOJEVy; Fri, 27 Feb 2026 08:46:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C7B78298599;
	Fri, 27 Feb 2026 08:46:51 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vzR7oCGiDGlw; Fri, 27 Feb 2026 08:46:51 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 80282298580;
	Fri, 27 Feb 2026 08:46:51 +0100 (CET)
Date: Fri, 27 Feb 2026 08:46:51 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pwm <linux-pwm@vger.kernel.org>, 
	linux-hwmon <linux-hwmon@vger.kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	julian friedrich <julian.friedrich@frequentis.com>
Message-ID: <1892064865.155.1772178411224.JavaMail.zimbra@nod.at>
In-Reply-To: <9c733024-8ad6-459d-ae5a-a9825f85c506@roeck-us.net>
References: <20260225125159.20822-1-richard@nod.at> <9c733024-8ad6-459d-ae5a-a9825f85c506@roeck-us.net>
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF147 (Linux)/8.8.12_GA_3809)
Thread-Topic: hwmon: nct6775: Register fan PWMs as PWM chip
Thread-Index: umDdz0jqWtvRem2Pc1uXQyHbpW7x4g==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[nod.at];
	TAGGED_FROM(0.00)[bounces-8169-lists,linux-pwm=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-pwm];
	FROM_NEQ_ENVFROM(0.00)[richard@nod.at,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75C061B4145
X-Rspamd-Action: no action

Hello Guenter,

----- Urspr=C3=BCngliche Mail -----
> Von: "Guenter Roeck" <linux@roeck-us.net>
>>   - Exporting a PWM for external use is only allowed when the fan mode
>>     is set to manual or off.
>>   - As soon as a PWM is exported, changing its configuration is no
>>     longer possible through the hwmon sysfs interface, reading is
>>     still allowed.
>>   - Changing the PWM period is not supported. IMHO, it is too risky
>>     since the PWMs usually control system fans and similar components.
>>   - Reading and decoding the current PWM period is only supported for
>>     one chip variant so far, for all other chips, a fixed period of
>>     100ms is assumed.
>>=20
>=20
> This is a good start, but I'll want to see stronger safeguards.
> - Creating a pwmchip entry for a pwm channel must be triggered by
>   device property data, obtained either from devicetree or through
>   DMI or through device properties embedded in ACPI data. For each
>   channel, this must be confirmed by checking that the channel is
>   not associated with a fan control channel.

In my case it's a x86 based industrial PC with direct access.
What safeguard do you suggest in this case? A module parameter?

Also for ACPI data, what exactly do you have in mind?

> - If a pwm channel is configured as pwmchip, it must not be used for fan
>   control, meaning the hwmon properties associated with that channel
>   must not be created.

Ok.
=20
> This will retain current functionality while enabling support for using
> pwm channels for purposes other than fan control.
>=20
> Thanks,
> Guenter

