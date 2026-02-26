Return-Path: <linux-pwm+bounces-8163-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFbvKZoroGmLfwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8163-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 12:16:42 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00D1A4F15
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 12:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A518A300B743
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 11:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5C349AF5;
	Thu, 26 Feb 2026 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtFoqFVg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238234404B
	for <linux-pwm@vger.kernel.org>; Thu, 26 Feb 2026 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104537; cv=none; b=uYdbVTZn4Z64d2xv69MJJTuRiRYBN4L404IY7JqByjxCaPjw0GS6QGJBwJn+8u7WGSsIkX7HTVYbKMqn8oUMqEFzqR5nF+oUq71F+0sSUS5zXRGdm/NtN66FlLIu4IFZD//EdSi7gLhIf9BAy1j4QVz25rqmNhRULKWWVBBmeBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104537; c=relaxed/simple;
	bh=URbaMimkw20wxvcwAz/G1jMtCCTVR9aX8NC4nAQeFpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr5vGvNB34KFnwHCgoRE1oCqb/lPwBiMkc0tmD5Un9qShsoYlgQs4N2zGXffEBgwGa1OJiyvxQFDqBs43jVgdUQMyC6aVzATteDeAxtxKsf0HTODXMCZ+zrPRM1kltgM3aucMGysHQSLmQwx1F5rqbJdSA0A7e2x9KHy0mY1xE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtFoqFVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E9AC116C6;
	Thu, 26 Feb 2026 11:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772104537;
	bh=URbaMimkw20wxvcwAz/G1jMtCCTVR9aX8NC4nAQeFpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtFoqFVgPkY+uZijXosn6ofsjvA7stsioRUUmSLA1oEAH+V4XeDZnh40qyNayU5hI
	 OhO+lazbkmz1YuWjAUSA/XJmz9Kqilt2KxKqJ+eewdoPd9HBphtY0cR0MTsOBfCTNc
	 qbiyQOhpbfL9o1QreBT/SMr0FcHhAADq2CTcQA6KYqT/jV8tt/ghV/5phah8dMSoUT
	 8imCewX/CwD6Rg6qir/aq9O0D9aHMM0lAaHT02dExnUJgL6F8+7eh4dUVZ90wdsAjU
	 t1MAD4In7CEfJM5EX3lwBEaiRL8YkAM4vLxKP4VIlhc7dkVxlhdRUEsMK9PFb0ZYiy
	 5G5nQ9tzEjmLw==
Date: Thu, 26 Feb 2026 11:15:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Yu-Chun Lin =?utf-8?B?W+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"brgl@kernel.org" <brgl@kernel.org>,
	James Tai =?utf-8?B?W+aItOW/l+WzsF0=?= <james.tai@realtek.com>,
	=?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
	Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= <stanley_chang@realtek.com>,
	=?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
Subject: Re: [PATCH 5/8] dt-bindings: pinctrl: realtek: add RTD1625 pinctrl
 binding
Message-ID: <20260226-rippling-reliant-8210097fb9cc@spud>
References: <20260128033936.27642-1-eleanor.lin@realtek.com>
 <20260128033936.27642-6-eleanor.lin@realtek.com>
 <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
 <20260225-reconvene-troubling-947eb972cef8@spud>
 <7450228dba6a4497b4cdf23747f5830b@realtek.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dIQWeVTnOnABGXVn"
Content-Disposition: inline
In-Reply-To: <7450228dba6a4497b4cdf23747f5830b@realtek.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8163-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email]
X-Rspamd-Queue-Id: 2B00D1A4F15
X-Rspamd-Action: no action


--dIQWeVTnOnABGXVn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 10:47:30AM +0000, Yu-Chun Lin [=E6=9E=97=E7=A5=90=
=E5=90=9B] wrote:
> > On Wed, Jan 28, 2026 at 01:33:00PM +0100, Linus Walleij wrote:
> > > Hi Yu-Chun,
> > >=20
> > > thanks for your patch!
> > >=20
> > > [Uwe, can you check this a bit down!]
> > >=20
> > > On Wed, Jan 28, 2026 at 4:39=E2=80=AFAM Yu-Chun Lin <eleanor.lin@real=
tek.com> wrote:
> > >
> > > From: Tzuyi Chang <tychang@realtek.com>
> > >
> > > Add device tree bindings for RTD1625.
> > >
> > > > Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> > > > Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> > > > Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> > >=20
> > > Overall this looks good!
> >
> > Where can I find the binding patch? What this is in-reply-to does not
> > exist:
> > https://lore.kernel.org/all/CAD++jL=3D445wx467ZKE3-qm_BaVzKYXE-7zmReTFZ=
A0KUAaSNyw@mail.gmail.com/
> > Nor can I find anything else from Eleanor that would appear to be what =
this is:
> > https://lore.kernel.org/all/?q=3Df%3Aeleanor.lin%40realtek.com
> >
>=20
> Hi Conor,
>=20
> I apologize for the confusion. I realized that when I sent out the v1 pat=
ch, I
> missed the mailing list, which is why it's not showing up in the archives.
>=20
> Since I had already received some feedback on v1, I missed the timing to =
resend the v1.
> However, you were included in the CC list of the initial v1 patch email.
> You might be able to find the full patch in your inbox.

Nah, anything that goes to conor+dt@kernel.org gets deleted once someone
has reviewed it, so I deleted it when Linus replied unfortunately. I'll
check out the other mail, but I think your revised name is an
improvement. Also, probably add more to your description to make it
clear that its not a PWM but rather minor adjustments to the signal.

--dIQWeVTnOnABGXVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaArVAAKCRB4tDGHoIJi
0g8zAP4whnD16VY3iiGP4bN78lFcZXpRHo+VzQNeP1bQwisUJgD7BFUCar15lGHk
fQ5sAVP8llTpI4geQYlAo7GoSYTchQ8=
=U/lG
-----END PGP SIGNATURE-----

--dIQWeVTnOnABGXVn--

