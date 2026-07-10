Return-Path: <linux-pwm+bounces-9682-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cxxYN4yIUGqR0wIAu9opvQ
	(envelope-from <linux-pwm+bounces-9682-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 07:52:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AE67376D0
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 07:52:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aIOX9Shj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9682-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9682-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4779300E71B
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Jul 2026 05:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D28C233958;
	Fri, 10 Jul 2026 05:52:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26B261B8D;
	Fri, 10 Jul 2026 05:52:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662730; cv=none; b=AALTy+rcKCe8lyLrJZc/HfHeTI6hFGwOdSpWEo9KoK3SeQZitCkaqHE/O1ZjXH2vsOUIcJHEJpbGeT/I6UBDPlgGmmm5ztzRysvvk042NVMCKLZyyrKzINz1xaTKcEZppK1G2rLAhd2YXEMqQCq7P+GkqPf8g/PKe4IlaWmQeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662730; c=relaxed/simple;
	bh=C4dNNoFjTmPVDTd4umr8f7jmGd8315uAllp4/LlblxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGh/ltMk3Aytxtjo0p2Q5dQOP22ozXNmBRtOF+ovK1R38gC78I9ny/bIxqUuOBJK+Sto0iU+LVUICwO5Ad2rtSTT5g66MfkdejeA0DVaOIFVP6SaMmVOmCJrHN+UhQjaOH6jDcN94zXyBGcieKwEOlWcHBIRQsOpfpX1AtQW4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIOX9Shj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 785011F00A3A;
	Fri, 10 Jul 2026 05:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783662729;
	bh=ZlU/SLfr9dTR0mdUitfTL77FTvnZBZpyDlOZV2Imu08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIOX9ShjNelV0k+BMzoYK183zFCk/u95tFkL52ITZ0QIvUUWuA7Ee4APMimULIqP0
	 yf+RzAf2uuh2tjmx92xYZsTW5kQPv2y0lUWzcH5ECLppWnLopoLlLiFDe/kykGsj1E
	 xwYAVBFjiLxTGEzLddV7KP1bKYyzSWLpuVOXn9bmJFs6kuR4xjizEl7TFYR9AGi+1w
	 HmlNjAyuI+ROhxEqzVuk7KDBMGr47KjqRl8O7M0GfmroZngfJt8s5NnyjrSqs8WTa7
	 5qcbvTiQiwN1MZdU7RHDbWl2votRN3czdFlJstJwRHPeDj5TsBy7xT1eFhdZuN5x1D
	 lezXDmL3US5rw==
Date: Fri, 10 Jul 2026 07:52:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: loongson: Fix low pulse buffer register
 handling
Message-ID: <alCIB5nGfYlEZsMg@monoceros>
References: <20260626-pwm-loongson-fix-v2-0-5492db953879@gmail.com>
 <20260626-pwm-loongson-fix-v2-1-5492db953879@gmail.com>
 <aktdkn-NcQt7J1YS@monoceros>
 <CAJhJPsVffZLTzXyA41rxm=A54sZhROVg-+K-gWo1KEzuKGv15w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pg2hkufpcicibmwc"
Content-Disposition: inline
In-Reply-To: <CAJhJPsVffZLTzXyA41rxm=A54sZhROVg-+K-gWo1KEzuKGv15w@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:keguang.zhang@gmail.com,m:zhoubinbin@loongson.cn,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:keguangzhang@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9682-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32AE67376D0


--pg2hkufpcicibmwc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] pwm: loongson: Fix low pulse buffer register
 handling
MIME-Version: 1.0

Hello,

On Thu, Jul 09, 2026 at 03:25:38PM +0800, Keguang Zhang wrote:
> On Mon, Jul 6, 2026 at 4:00=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
> > > -     /* duty & period have a max of 2^32, so we can't overflow */
> > > -     state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)duty * NSEC_PER_S=
EC, ddata->clk_rate);
> > > +     /* low & period have a max of 2^32, so we can't overflow */
> > > +     state->duty_cycle =3D DIV64_U64_ROUND_UP((u64)(period - low) * =
NSEC_PER_SEC, ddata->clk_rate);
> >
> > What happens if low > period?
>=20
> pwm_state_valid() in drivers/pwm/core.c ensures that duty_cycle <=3D
> period before the framework calls the driver's .apply(). Since this
> driver always programs low =3D period - duty, low cannot exceed period
> when configured through the PWM framework.

But this is only the case when .get_state() is called after the hardware
was programmed by Linux. The function should also work for the state the
bootloader left the hardware in.

Best regards
Uwe

--pg2hkufpcicibmwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpQiIMACgkQj4D7WH0S
/k6sKwf/bnIBymcZ/fJgylLmT3nJ/s8EtYF02hfFrxZA6aOX62BqWC4jM8sqBrAr
LF2Rvnyhs0JAgaqYUE75gRscrS8oLJgMjKpFQ/0PIPmsukVRRTKq6QRDKh4zRRF7
nOQ62cu1jzqjytxEX3rtoLMmCuzuNd9FhrgSIV3QYixkXAhxRnMU10BvHl6mKgYX
WDtMf0p2Yr0yJcvOn57zs+buCh9toA2cS4KFy36mSvyubipQRxNSrQ+gdzT7E+5q
Ft6ZZ4dQuJKsHOkrCyhflr5dG4PHXB9vpA7boSFZYfmtvHs3M08FRTl9k7I5SN8t
EN70pwOc/dAenzNuCjiaqKKBX0XHFw==
=NEj/
-----END PGP SIGNATURE-----

--pg2hkufpcicibmwc--

