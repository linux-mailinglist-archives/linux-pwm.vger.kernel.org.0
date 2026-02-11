Return-Path: <linux-pwm+bounces-8115-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFX0MAi4jGnlsQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8115-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 18:10:32 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C712676F
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 18:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDE5630148B1
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Feb 2026 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB47D3451AA;
	Wed, 11 Feb 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPUCpqes"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BA8318EC2;
	Wed, 11 Feb 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829803; cv=none; b=KvAL7zqPL0Q0p+LXx99gntiv3/eblRxoAXBatM43aylhz3YlRCLK25XHByKNxCd68vgLRuGTCOLF+pUzQwVu/doXBGJCgP6D5xoVZwgqZvXCHQUecN7EK2WyOCXNGg/DOntyMNf82wm+7/ZsCNmXCkpuyrihVdkmW0p+9hsfkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829803; c=relaxed/simple;
	bh=7upHBVEG2uZ4tUa36JEchClxWzr7WEN4Moqq4nZx3TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESbHtbOKwLIgm1c9IGwDpQ5VsuBDVE+aR3E5aAiQtzI1NFEWztD9CPua/HN7L6x/jvFc+v5v2ttAO/zxmoLGTfB1A3cxRieeNqHamyLecwGKUSCIcqgnBfDVCmjoiD0U+EZGQUEermyp/2YNyTbaPdmV4a/aAs84l8+ZtJjYzT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPUCpqes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C51EC4CEF7;
	Wed, 11 Feb 2026 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770829803;
	bh=7upHBVEG2uZ4tUa36JEchClxWzr7WEN4Moqq4nZx3TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPUCpqeshNrFe7QwVZo35hpGE0PPMURxmpxFlY59YAgwUHkpowMwHp8PzUVj3Ucie
	 5G3Gm61SeYcAxxh9q0FFJlTHdGJxInsnz02k/5sa5bQBFvOzXj1HefF/V0qmC2WUlD
	 qka/8lepkA8dZNqia0wv7vahTt6/JPKswRilyCVfFYQ7hAztI4hVlYiiAyKMZ7nXVB
	 hypZXN47GCC6Z+tyE3EdU8cMskxnxyjGftL6cPRWxF14LPJUMOHR6oumE+gaTvwrXT
	 U/JTKnYQtQyTRk2VXBVOCwCT9dCfXTVXW4lmH96GcYOKPNXjH7FQlPJRrOmeePZfkj
	 DuCD2HQtB+nqQ==
Date: Wed, 11 Feb 2026 18:10:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, 
	Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: PWM implementation in HWMON and backlight
Message-ID: <aYy0bO7ZWUsj0ENu@monoceros>
References: <CAFLxGvyhdpQMnW6VqyXjLPKyZSQvrV-+GFdUogV4JX7DiGePyg@mail.gmail.com>
 <aYxaXmguGRk1pWpT@monoceros>
 <e5ccfd91-9c0c-45f1-bbc8-40e93bffca43@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5nv7bzmwhj2lfjf"
Content-Disposition: inline
In-Reply-To: <e5ccfd91-9c0c-45f1-bbc8-40e93bffca43@roeck-us.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-8115-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 234C712676F
X-Rspamd-Action: no action


--r5nv7bzmwhj2lfjf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: PWM implementation in HWMON and backlight
MIME-Version: 1.0

Hello Guenter,

On Wed, Feb 11, 2026 at 07:47:36AM -0800, Guenter Roeck wrote:
> On 2/11/26 02:46, Uwe Kleine-K=F6nig wrote:
> > On Wed, Feb 11, 2026 at 10:28:55AM +0100, Richard Weinberger wrote:
> > > The backlight of a board I am working with is controlled via PWM.
> > > Naturally, I thought this would be a straightforward task using the
> > > pwm-backlight driver.
> > >=20
> > > However, the PWM in question is implemented using an NCT6106D chip.
> > > The associated HWMON driver, nct6775-core.c, does not implement a
> > > standard PWM device interface but rather its own custom one.
> >=20
> > Looking around in drivers/hwmon made me a sad. There are four drivers
> > that handle parsing #pwm-cells:
> >=20
> > 	$ git grep pwm-cell drivers/hwmon/
> > 	drivers/hwmon/adt7475.c:        ret =3D fwnode_property_get_reference_=
args(fwnode, "pwms", "#pwm-cells", 0, 0, &rargs);
> > 	drivers/hwmon/amc6821.c:        if (of_parse_phandle_with_args(fan_np,=
 "pwms", "#pwm-cells", 0, &args))
> > 	drivers/hwmon/emc2305.c:        ret =3D of_parse_phandle_with_args(chi=
ld, "pwms", "#pwm-cells", 0, &args);
> > 	drivers/hwmon/nct7363.c:        ret =3D of_parse_phandle_with_args(chi=
ld, "pwms", "#pwm-cells",
> >=20
> > instead of using the pwm subsystem. Also the driver mentioned by Richard
> > above has some self-made PWM handling including a set of driver specific
> > sysfs files to control the PWMs. I stopped looking at the output of
> >=20
> > 	git grep pwm drivers/hwmon/
> >=20
> > after finding some more sad things. (My "favourite" so far was:
> >=20
> > 	dev_dbg(dev, "chmod -w pwm%d failed\n", nr + 1);
>=20
> That code is from 2006. Are you serious ? Did you bother to read
> the context ? Did you bother considering that this was possibly the
> best means available at the time to control visibility of an
> attribute file ?

This was just something that I spotted while looking at the git-grep
output. The thing that actually triggered my mail was commit
46b94c485ed197bc681da242440c6e2315697c57 and less that it doesn't use
the pwm stuff (which was only in next at that time probably), but more
that I wasn't involved.

> For the most part the pwm implementation in hwmon chips is tied to suppor=
ting
> pwm output for fans and isn't usable for anything else. This gets worse f=
or
> chips where pwm vs. voltage control on the output signal can be selected.
>=20
> Unless there is an actual use case for utilizing the pwm subsystem for a
> given chip, doing so would just create overhead. _If_ there is a proven
> use case, I don't mind if people submit patches to add generic support
> for the the pwm subsystem to such drivers. Keep in mind though that suppo=
rt
> for the ability to switch between pwm and voltage control (as is very com=
mon
> for fans) is mandatory for chips with that capability.
>=20
> Talking about this specific driver, it has been in the upstream kernel si=
nce v3.10
> (2013). Almost all hwmon drivers supporting pwm fan control are much olde=
r than
> v6.13. While many of those would benefit from a modernization update, sup=
porting
> the pwm subsystem just because it exists would, from my perspective, be a=
 waste
> of time. I most certainly won't do it.

The bit I don't like about these drivers is that their binding (using
#pwm-cells) suggests that these chips are usable as generic PWM. That's
what Richard seems to have expected, too.

> In my opinion calling it "sad" that drivers are not re-implemented to use=
 a
> newly available out-of-subsystem API is close to being an insult to those
> who would have to do that work.
>=20
> Sorry, you folks really got me on the wrong foot. If there is anything sa=
d,
> it is people complaining about 20 year old code without doing anything ab=
out
> it themselves. I by now spent months if not years of my time modernizing =
hwmon
> drivers. Did you ?

That wasn't the message that I intended to transport and I'm taking the
blame for that. The actual intended take away was: Please for the next
driver implementing PWM stuff, poke me, such that the nice things in
drivers/pwm are reused instead of partly reimplemented with less
functionality and that the maybe not so nice things are improved.

I didn't want to blame you (or anyone else) with my mail, and I'm sorry
that this was how you received my mail.

Thanks for being honest,
Uwe

--r5nv7bzmwhj2lfjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmMt7sACgkQj4D7WH0S
/k6EZgf+LK4+qEc/Wf3mhkqpelRgXUyxLRPmvypGyjy1ysoP11EC9EkBvEp9y+ZX
Su87iK9acDmUa5mAB+Ql/EXiKI4NhIi/CuqOPT8vPW7yKKIAGtmrOsBxjj/YqGfq
62XifKi6mb60CVBqQDd4TrLu/qCEWIRppFHBazBei9UutCzynFWfklc1o+85Axyc
fgqF4YHx8sUC5mVJ7yqJ15p0iqcX5NxIV86seZoZHBuRq3eNY6SgnxGzqQ8T9Obz
+y5ujU7SQJMoyQH1K5DvuHsJBD98hbx/nMvwlwOQDqwxDNc81TmYxEOGcHPQkunh
/aZpDQqlqVP8NuizNPEcaUsS7AeQDg==
=MzJ3
-----END PGP SIGNATURE-----

--r5nv7bzmwhj2lfjf--

