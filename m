Return-Path: <linux-pwm+bounces-8688-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLA6O/xJ62ntKgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8688-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 12:46:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE945D534
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 12:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD89D30247E3
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Apr 2026 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6883C38A72C;
	Fri, 24 Apr 2026 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDMQHrfz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B338425D;
	Fri, 24 Apr 2026 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027412; cv=none; b=q0VHUnJT+oDMWHnIAqRQK9VyNnQQFYN/byeB4pRnf5KuIBJLDXNVDbuXU+g9Qg0cHyc7BWP3wgHpPM8Sonvy7fA3yNBdn8+5JhDLuC823gHvsDCmFN/432kdZtqvB7pistNvnOaGdwKDl/75GDg0tuckyc++N+JOeRAHokmKm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027412; c=relaxed/simple;
	bh=kknDDv9TuvxwgtonleSpBC/+VyXVDvyX2AE+3GnIAw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRueYZwAfUAjnYSyKKmQhrxJgIfCm3bLevRgHKnQzl2B2+Sl60Luba/B9g2xrcp/v1i2W45tf/H9Aq4gD1VJ9A9MWJEPNuZyOuKw9s2ERaGxi028/OF1qt3cd7xfzFW9G5fx22KqZnELQ+F7qk0jqhca23vrh1N1g0IYaMBR3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDMQHrfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2B3C19425;
	Fri, 24 Apr 2026 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027411;
	bh=kknDDv9TuvxwgtonleSpBC/+VyXVDvyX2AE+3GnIAw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDMQHrfzRkuh92o/aG4I5AFMn1snndSnL+7WSnv5nef9ruDSGgGHKYWXEj7SPnJRm
	 LY24+LVI4JMn1/V+jz/EXg2ysR8wksLiEdHrEs4oDg2Sg77Yv95DdREYTz1A6MHlbm
	 zahdprpJZ8p9EDrFlUBQYhcXq4HLG3Th+yEgwKzPFS4yBqgKcaW0Hsg5UewY116SPo
	 /UW4PgZfJUoJBxnt0rZHnVuSWp1AVHunPk5zviLN7TnXoiGy9WO8r5RAPu5LgZ0YNi
	 yt01acpjkuo++DRtrv2I/a5YrVDa3/WsYv1ERETrMb6GtLkE+eGYnzouqLWZH2mPGZ
	 x4CrRrJbSwWVw==
Date: Fri, 24 Apr 2026 12:43:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Damon Ding <damon.ding@rock-chips.com>, kernel@collabora.com, 
	Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 0/6] Add Rockchip RK3576 PWM Support Through MFPWM
Message-ID: <aetFgdIUlDG0AiMn@monoceros>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260421165656.168fe262@jic23-huawei>
 <dB_doorKQsK5TdJ40Tv8Lw@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqpklusenoeywtel"
Content-Disposition: inline
In-Reply-To: <dB_doorKQsK5TdJ40Tv8Lw@collabora.com>
X-Rspamd-Queue-Id: 50AE945D534
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8688-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,rock-chips.com,collabora.com,gmail.com,lists.infradead.org,vger.kernel.org,microchip.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]


--nqpklusenoeywtel
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/6] Add Rockchip RK3576 PWM Support Through MFPWM
MIME-Version: 1.0

[Dropped Jonas Karlman from Cc:, their email bounced for me in the past]

Hello Nicolas,

On Wed, Apr 22, 2026 at 01:31:14PM +0200, Nicolas Frattaroli wrote:
> On Tuesday, 21 April 2026 17:56:56 Central European Summer Time Jonathan =
Cameron wrote:
> > On Mon, 20 Apr 2026 15:52:37 +0200
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> >=20
> > > This series introduces support for some of the functions of the new P=
WM
> > > silicon found on Rockchip's RK3576 SoC. Due to the wide range of
> > > functionalities offered by it, including many parts which this series'
> > > first iteration does not attempt to implement for now. The drivers are
> > > modelled as an MFD, with no leakage of the MFD-ness into the binding,=
 as
> > > it's a Linux implementation detail.
> >=20
> > Just thought I'd point out that as this includes the linux-iio
> > list sashiko took a look at it.  Quite a few things and at least
> > the first one I looked at was valid (a dereference before a validity
> > check)
> >=20
> > https://sashiko.dev/#/patchset/20260420-rk3576-pwm-v5-0-ae7cfbbe5427%40=
collabora.com
> >=20
> > Whilst this tool does generate some false positives, it also finds
> > quite a few things it seems us humans fail to spot.
> >=20
> > Jonathan
> >=20
>=20
> While I'm not entirely opposed to this, I do think reviews should happen
> on-list when possible. Sashiko is a Google service, so it has about a 50%
> chance of still being around in 2 years time. One of the benefits of the
> kernel development workflow is that discussion going back decades is still
> accessible.

I mostly agree to your point. A possibility that I would consider
compatible with on-list review is looking through what Sashiko found and
address that on the list. Something like
https://lore.kernel.org/all/20260420204647.1713944-2-u.kleine-koenig@baylib=
re.com/

> The reason why these aren't posted to list goes into the other thing
> that I currently am not stoked about, which is that I'd have to act as
> a filter for a Bring-Your-Own-Brain noise generator to pick out the
> parts that aren't convincing lies.

I didn't look through the complete feedback, but the part that I looked
at (I'd say the rough half) seems to be legitimate.

I'm also have reservations about AI, but my (little) experience with
this one seems to show that it's in the better half of the scale between
helpful and useless time consumer. So when I come around to review your
series I will for sure look through their feedback in more detail. That
means that if I'm too slow for you, looking through the feedback
yourself and addressing that (or deciding against it) might be a good
way to spend the waiting time and maybe even making it easier for me.

Best regards
Uwe

--nqpklusenoeywtel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnrSU4ACgkQj4D7WH0S
/k5RbwgAosunTIJtGGwUzsLZV8Zw2wd/vePOh4BvI6BFVJqacUQI3GU2p7tDClfB
CdyBjNdiFYBInb1IzLr2sBOr089SEgf6BzpuZn/ZHATI8hGw+ZeAUkJDfVkeJtno
qRd6UZuLbzftwQqGudASQBbgc4/mTSqFC9kL7GriORrJ3FJNhtZdoLfUpglbCP65
G6q2RWvEGqhht5UMfc7cjUk8l67cMru0ctOP32tzCQVBXGpZdbM3cBdcs8ZtBwN0
KouApV1mbrQhFVXtvCPFTYTosXBb+rsRnq/mO8UWBeOVboAxVASK9PhP1eHJgutn
Tk3r77pzRnSnrSTnagBFPlKU45DHOg==
=/p0a
-----END PGP SIGNATURE-----

--nqpklusenoeywtel--

