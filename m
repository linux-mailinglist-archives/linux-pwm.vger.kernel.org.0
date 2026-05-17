Return-Path: <linux-pwm+bounces-8941-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOtyNtghCmpMxAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8941-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 22:15:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B77C563B5C
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 22:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 149AC300F5D1
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 20:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDEF30BBB9;
	Sun, 17 May 2026 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9IHy5yy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD082FE074;
	Sun, 17 May 2026 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779048917; cv=none; b=l7ZmiuQe5o2yn/pkelhp/m1x4mykOfhpKZ/H/az/5rYyMRUVt+2BGGZfbd3/GVfFZszDbCTlBAMmaQTSvjbUsoGiHnWx3/z7uykFRxTkukGG3yXzr/IGvMt7D/eOAHoQeASHh0yrs9dlhBjx6HKflaHbTIsGZY/+amnY9jIHQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779048917; c=relaxed/simple;
	bh=wPGlipT5EbZIEdNt7MOHiAYU0AmXy3zaPqy5WBml5x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQuOIRBbqE2rga3TKMIZMzuKHSGpRex4UeTwXc9BQRlhSiAvt/G7uBiP7kgaMwlf/rd+4IDZsdJcFQn1Zsgyvki9uDRPZjGP8pamwkXShgLtrfVu7NGXdHTrCTchL1+An+X/RArHAFt5DNLkzl4dGfbfYCANMLgahRwKmMq5204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9IHy5yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36FDC2BCB0;
	Sun, 17 May 2026 20:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779048917;
	bh=wPGlipT5EbZIEdNt7MOHiAYU0AmXy3zaPqy5WBml5x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9IHy5yy0cEUZHHJNGSRFxXqJP7SBD/EyXD/oXlZHAy4p31o878utNEWToqVaQf8+
	 /YwiiW6481YbXNrtgdPfbh/hAcOClmpdVTw4jrVCh7zv0brNy3vjmn/W/47Idypo4C
	 2VbDjPIV2U786Sr5adfOp86IaP0Ajgpahkdo4Len+bhU15ZvQno+BwELKXmivNMFRc
	 cYzkMBDddP3rCLlfyHWJLWpJsjIbqCL1byxE8GlFTced2LiDc0+7XTU0SDr7RZ8PFz
	 /HKZ+A6k6AUtM8K82/JeF/zXYUO8eBxD+7m62MOT7/pc1umDohhGAYTe+Q2A4uoRsP
	 gLNOEzkAV9Cvw==
Date: Sun, 17 May 2026 22:15:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Message-ID: <agog7Z1wfrZAjHj-@monoceros>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros>
 <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <abkX1ssLhkGxryfM@monoceros>
 <TYYPR01MB15615FA52860D81F04E42F2C48541A@TYYPR01MB15615.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q5alohvduecpctbe"
Content-Disposition: inline
In-Reply-To: <TYYPR01MB15615FA52860D81F04E42F2C48541A@TYYPR01MB15615.jpnprd01.prod.outlook.com>
X-Rspamd-Queue-Id: 1B77C563B5C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8941-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--q5alohvduecpctbe
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
MIME-Version: 1.0

Hello Cosmin,

On Tue, Mar 17, 2026 at 11:02:12PM +0000, Cosmin-Gabriel Tanislav wrote:
> > From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> > Sent: Tuesday, March 17, 2026 11:12 AM
> >=20
> > On Mon, Mar 16, 2026 at 03:49:35PM +0000, Cosmin-Gabriel Tanislav wrote:
> > > static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > > 			      const struct pwm_state *state)
> > > {
> > > 	...
> > >
> > > 	u32 enable_count;
> > >
> > > 	...
> > >
> > > 	/*
> > > 	 * Account for the case where one IO is already enabled and this call
> > > 	 * enables the second one, to prevent the prescale from being change=
d.
> > > 	 * If this PWM is currently disabled it will be enabled by this call,
> > > 	 * so include it in the enable count. If it is already enabled, it h=
as
> > > 	 * already been accounted for.
> > > 	 */
> > > 	enable_count =3D rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled=
 ? 0 : 1);
> > >
> > > 	...
> > >
> > > 	if (enable_count > 1) {
> > > 		if (rz_mtu3_pwm->prescale[ch] > prescale)
> > > 			return -EBUSY;
> > >
> > > 		prescale =3D rz_mtu3_pwm->prescale[ch];
> > > 	}
> > >
> > > Please let me know what you think so we can proceed with the work
> > > internally.
> >=20
> > I'd prefer the `rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled ? 0=
 : 1);`
> > variant. I understand that this is also the variant you prefer, so
> > that's great, but I wouldn't stop you using the sibling option.
>=20
> I realized the check could be simplified quite a bit while achieving
> the same outcome.
>=20
> 	if (rz_mtu3_pwm->enable_count[ch] > pwm->state.enabled) {
> 		...
> 	}
>=20
> 2 > 1 -> true, prescale gets checked when updating one of the IOs if
> both are enabled
>=20
> 1 > 0 -> true, prescale gets checked when enabling the second IO
>=20
> 1 > 1 -> false, prescale is not checked when updating a single enabled
> IO
>=20
> 0 > 0 -> false, prescale is not checked when enabling the first IO
>=20
> 2 > 0 and 0 > 1 -> impossible since enable_count is always in sync
> with PWM state

I didn't try to understand that, but on first glance it doesn't look
intuitive, so needs a code comment.

> > You can gain some extra points for not using pwm->state. This is a relic
> > from the legacy pwm abstraction and doesn't make much sense with the
> > waveform callbacks.=20
>=20
> I can switch from enable_count to an enable_mask in a later commit, and
> that will allow us to both get rid of PWM state access entirely and also
> make the sibling check more obvious, by doing something like:
>=20
> 	if (rz_mtu3_pwm->enable_mask[ch] & ~BIT(rz_mtu3_hwpwm_io(pwm->hwpwm))) {
> 		...
> 	}
>=20
> Which would read like "is any other IO enabled?". If yes, don't touch
> prescale.
>=20
> But for the scope of these fixes we need to keep accessing PWM state as I
> would like them to be backported to stable.

ack, getting rid of pwm->state is a separate patch that should be
addressed only after the fixes under discussion.
=20
> enable_mask must remain per-HW channel because it makes the enable /
> disable checks simpler.
>=20
> If this sounds good to you, I will proceed with all of these changes.

It does, so go.

Best regards
Uwe

--q5alohvduecpctbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoKIc8ACgkQj4D7WH0S
/k7RGgf/VEvDtodT0+oisHcW2Z6vsU8mbZ6CyXyTYVCCAfxnCMh5+Pv0JrZGF0BB
6HTuBpK3WzDLz18WhMRvuRX0lGQ0H1GdWgRhUfCRKjK3uQ0k94jqbTS3077LogCu
KVddT3wgqd42HvVnoKKyX6kXLdhERF1feWJimAZMyN97EnCpYkXIrt6OjcqVw1uP
CovKK1sipd9yubGD50twFyD1mvrfBgtlttGK3+jch85WrVpiEivYywkYlg50raGX
nGLis6QRafoe/BszDCYaAYBcNBT9DV5Acs0ABucv1KcgUe2/wFXeQpyrLalaMk0+
4c1SKThnhzLBWSP1Dh5L+TOi7CZlzw==
=nQKn
-----END PGP SIGNATURE-----

--q5alohvduecpctbe--

