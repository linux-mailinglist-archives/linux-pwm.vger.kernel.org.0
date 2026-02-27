Return-Path: <linux-pwm+bounces-8173-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMS9B1z4oWknyAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8173-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 21:02:36 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4428F1BD2A7
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 21:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9D193006010
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Feb 2026 20:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C163559C0;
	Fri, 27 Feb 2026 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaqNwYYX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA974368978;
	Fri, 27 Feb 2026 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222532; cv=none; b=Q5hXGNsNgH0+AzUHucW+ncCBNAOUzpLE9Pue0SLP9US27Vu6m+b8WRDJVAu1c4PxgdSNAQoZI5HT0bCzIXYG/OEBU/iaZAH+EkTdFOR0SGujZyMvFjnDfObIUXvdR7P3BjEE9dFk2EJQxYyBptIM7trxBT11w9CQSqVMGeHu0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222532; c=relaxed/simple;
	bh=x5y3xbY4OB64VJsX30ev9CFhBXFoGdQunCjDl8VCE/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvQ0RsJFdwAIjg6eR12worBgGvD6vdANLSFAZWj9ZnzEfKJEdXdgULHR4GAjtX088WP0F/Dfm+lNXag1YnPPcbt3A4Os83DQD6GEJc9wyE9IPo/0hOq27P8npcMOAccJnn5cUpIYamDdlAfuJPmcPSFmdEOthGXQntTrxT7Nn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaqNwYYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AA6C116C6;
	Fri, 27 Feb 2026 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772222532;
	bh=x5y3xbY4OB64VJsX30ev9CFhBXFoGdQunCjDl8VCE/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EaqNwYYXWT3wTh1sT7dKhrF6HRxpyXCrLfyeaBUN1SAXy43BGjwmA9pyAT3KGND6b
	 yhztYVwrMnTXA1R8OR4NnoLOT1s5/enbFOhQsGXgQ6WvMcDd421HP/SJUaUOwvv+pm
	 YjonZpN+yIIVR9CdNeCN14Zo/2xxr86T+sothbASPrWynbDBxfubMqOEN79Iur2piF
	 /XhpNcKKvinWYFj7gVI1okSJUwI3/S4mAh/Kwd2woKDdLwJ8JKDE/BP92OorLwHbUk
	 LGVGNmb2r/C+IZ7RUxyBRhdrHdO+7UWurmc+/JsLED6vwyrcxKOwPEFnQSvb1ROp8c
	 QfkkI1YICzafw==
Date: Fri, 27 Feb 2026 21:02:09 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Richard Weinberger <richard@nod.at>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-pwm <linux-pwm@vger.kernel.org>, 
	linux-hwmon <linux-hwmon@vger.kernel.org>, julian friedrich <julian.friedrich@frequentis.com>
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
Message-ID: <aaH3ZgfMiYuRhvp4@monoceros>
References: <20260225125159.20822-1-richard@nod.at>
 <9c733024-8ad6-459d-ae5a-a9825f85c506@roeck-us.net>
 <1892064865.155.1772178411224.JavaMail.zimbra@nod.at>
 <163f68da-c31b-4ee6-a187-a81d14202311@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p6hvmqhxmsmyzucv"
Content-Disposition: inline
In-Reply-To: <163f68da-c31b-4ee6-a187-a81d14202311@roeck-us.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8173-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4428F1BD2A7
X-Rspamd-Action: no action


--p6hvmqhxmsmyzucv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
MIME-Version: 1.0

Hello,

On Fri, Feb 27, 2026 at 12:17:00AM -0800, Guenter Roeck wrote:
> Hi Richard,
>=20
> On 2/26/26 23:46, Richard Weinberger wrote:
> > Hello Guenter,
> >=20
> > ----- Urspr=FCngliche Mail -----
> > > Von: "Guenter Roeck" <linux@roeck-us.net>
> > > >    - Exporting a PWM for external use is only allowed when the fan =
mode
> > > >      is set to manual or off.
> > > >    - As soon as a PWM is exported, changing its configuration is no
> > > >      longer possible through the hwmon sysfs interface, reading is
> > > >      still allowed.
> > > >    - Changing the PWM period is not supported. IMHO, it is too risky
> > > >      since the PWMs usually control system fans and similar compone=
nts.
> > > >    - Reading and decoding the current PWM period is only supported =
for
> > > >      one chip variant so far, for all other chips, a fixed period of
> > > >      100ms is assumed.
> > > >=20
> > >=20
> > > This is a good start, but I'll want to see stronger safeguards.
> > > - Creating a pwmchip entry for a pwm channel must be triggered by
> > >    device property data, obtained either from devicetree or through
> > >    DMI or through device properties embedded in ACPI data. For each
> > >    channel, this must be confirmed by checking that the channel is
> > >    not associated with a fan control channel.
> >=20
> > In my case it's a x86 based industrial PC with direct access.
> > What safeguard do you suggest in this case? A module parameter?
> >=20
>=20
> Presumably it has DMI information or some other means to identify the sys=
tem.
> That information can be used to set device properties, which would then b=
e used
> in the probe function to determine if a channel is modeled as pwm channel.
> See device_add_software_node() and friends to get an idea how that works.
>=20
> How exactly those properties would look like needs to be documented in
> nuvoton,nct6775.yaml. I'd assume that the pwm channels would be described
> in there just like for any other pwm chips.
>=20
> > Also for ACPI data, what exactly do you have in mind?
> >=20
> ACPI can be used to provide devicetree properties. The information is emb=
edded
> in the DSDT table. Conceptually that is identical to devicetree data. Tha=
t is
> not something you need to be concerned about unless you are responsible f=
or that
> system and in control of the firmware. Technically the company selling th=
at
> industrial PC should provide the information in the DSDT table, but of co=
urse
> that needs to be standardized first (and then they would have to actually=
 use it).

That would imply that derRichard has to update the BIOS, or at least
fake some ACPI tables, right?

For me it would be good enough if the first consumer of a channel "wins"
and others get a -EBUSY. Compared to describing that in dt or acpi this
has the advantage that the use can be changed without a reboot.

Best regards
Uwe

--p6hvmqhxmsmyzucv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmh+D4ACgkQj4D7WH0S
/k7gfAf/fTy0KhofiduCPxSyy5lTVYUhSz8HrORZb/MkkfPhXLB1oxWVZ5bmQWLq
mP4xvh8fK7R8zAqLmx15ir2ErraZZiyY8a37vg6LMdWFVYMQmr2LvY+ykJhPygDr
Pg71vNzdvG+YGvCEWXMI7aKsRYxSU4xOtoNFPEKTnkGWKIXAIwuHFkO9X4v3FdNO
/FWOFTHhoCMWUljcH0ww/XeM8C77PItgJ6K1M9mab78tw38A2zvlr/aEaxdXv7ke
jV+S36jRZodf37KZexpjeUkY37HZIh8kut/p5tF1y/Go4lGZXMQqbhxQDkBncdmC
dT1LBCDm/7Ux2YTQFl0JJq8rbGJnVg==
=Ktm5
-----END PGP SIGNATURE-----

--p6hvmqhxmsmyzucv--

