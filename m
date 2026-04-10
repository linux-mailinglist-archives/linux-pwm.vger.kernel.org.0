Return-Path: <linux-pwm+bounces-8543-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOwHH7yY2GkgfggAu9opvQ
	(envelope-from <linux-pwm+bounces-8543-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 08:29:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D0D3D2C54
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 08:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97E223006B18
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 06:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044A836A02F;
	Fri, 10 Apr 2026 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhzjfMDT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A56334C08;
	Fri, 10 Apr 2026 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802472; cv=none; b=ZiHUjMBbmBIDJygzuo7xLwdHLBlBJ8qU4VQROzKp61JnYQjipsthlIz0TJFadnrIbhQ9lbTlaHtPmX3pEbI6aQnu9YWTb/GPMviY69znSbLQazXb8UHheR3zG8d5ik2Ku4DUIWNaBhqokQP384mTDXS1Dp23INvtTCaesg2l8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802472; c=relaxed/simple;
	bh=ajthKdkAGwRhclYQfXtnXrA/phsT3uVTk3g+JGYsSm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNko+byoT+3ayZWYNSxdD62BTainL/RZm32q5Ju0vjZINDHgW6wtgJ+lS0mcagUFmTTJuoIWcWgVXO4eGJRm6/sNJadshOBJxIJJtoCCQPPNt6kJC63mwtzLG42fh1TiCYR6QkeffIpH08vOKcH+xLFeLwDuPNHt+/perHKhz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhzjfMDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E00C19421;
	Fri, 10 Apr 2026 06:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802472;
	bh=ajthKdkAGwRhclYQfXtnXrA/phsT3uVTk3g+JGYsSm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhzjfMDTjlPhnTwAKDqk9FKNM1gM6b5BBfQ7DCXXiCtElWfbwPWTeYgG50Kgkac9i
	 TBDa7zpHv7cp7DbNDee2V3htlF8K8ihWxvTGCvFrAywF/6pCpEOALM21tzIAYsPxmK
	 cR3rkbIkCojZw0UpM8O4+S8BGlhX9Dxl5CZu9S1fOC+cHsMEmp/Wkr42xaSTA4nJAp
	 Yob2/HbJdnlSPyoDE46iVJ1GJkQtxOwxbIB5YxXPUodUEsMutaCCO8iG2WE9vnaZ9v
	 z2pJJbnPpkdpbkJIH15E8VsNfRTsN5qm2oXr2PrJ3M0qdy6sWvGIDZ1KeRzcNy2YUp
	 rhI1X8J3mRrug==
Date: Fri, 10 Apr 2026 08:27:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <adiW1tBC8Imd14LD@monoceros>
References: <cover.1775223441.git.andrea.porta@suse.com>
 <28e29fbfc20c0b8a115d006233c2759d8f49e639.1775223441.git.andrea.porta@suse.com>
 <adLTwOTbkJ0VQXy6@monoceros>
 <adfQ6Tvst3Vd1Mxe@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3hvim2dtzodhjoa"
Content-Disposition: inline
In-Reply-To: <adfQ6Tvst3Vd1Mxe@apocalypse>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8543-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03D0D3D2C54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--d3hvim2dtzodhjoa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] pwm: rp1: Add RP1 PWM controller driver
MIME-Version: 1.0

Hello Andrea,

On Thu, Apr 09, 2026 at 06:16:41PM +0200, Andrea della Porta wrote:
> On 23:45 Sun 05 Apr     , Uwe Kleine-K=F6nig wrote:
> > On Fri, Apr 03, 2026 at 04:31:55PM +0200, Andrea della Porta wrote:
> > > +static void rp1_pwm_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> > > +{
> > > +	struct rp1_pwm *rp1 =3D pwmchip_get_drvdata(chip);
> > > +	u32 value;
> > > +
> > > +	value =3D readl(rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
> > > +	value &=3D ~PWM_MODE_MASK;
> > > +	writel(value, rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
> > > +
> > > +	rp1_pwm_apply_config(chip, pwm);
> >=20
> > What is the purpose of this call?
>=20
> To update the configuration on the next PWM strobe in order to avoid
> glitches. I'll add a short comment in the code.

=2Epwm_free() should not touch the hardware configuration. Changing the
pinmuxing (which I guess is the purpose of clearing PWM_MODE_MASK) is
somewhat a grey area. If that saves energy, that's okish. Otherwise
not interfering with the operation of the PWM (e.g. to keep a display on
during kexec or so) is preferred.

> > > +static int rp1_pwm_resume(struct device *dev)
> > > +{
> > > +	struct rp1_pwm *rp1 =3D dev_get_drvdata(dev);
> > > +
> > > +	return clk_prepare_enable(rp1->clk);
> >=20
> > Hmm, if this fails and then the driver is unbound, the clk operations
> > are not balanced.
>=20
> I'll add some flags to check if the clock is really enabled or not.

To be honest, I guess that is a problem of several drivers, not only in
drivers/pwm. If this complicates the driver, I guess addressing this
isn't very critical.

Best regards
Uwe

--d3hvim2dtzodhjoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnYmGIACgkQj4D7WH0S
/k7LHgf8CBP5w2EOPv0j9R+cYIsf2xK9RKcf/rdt2YwbGnx/t1arB/oP/RgMtYA8
KL7Q/OVJllRUOoSg1qp4wRb9+uSfLKNei8dFj1J/k8dp4mHmUjp5kFyqsVDE1Irm
dPpj2wRi1bB+8gx19hVBb4X8N1Z27LB+VJ/kpecLh9nmfuaGZBKWEiTJPLFmhk3R
hRb+G1F/G1k2ZGtiJ8eXB54+DP3XCcILivcgZjpOgbKGwpxFqPC85/Kh6mitcz30
KUl+UhgKPXBkhWdd5O1PWjnrb9RKNnZHgK5JHxulXWoLBffXw7JMx7p+NJMtQS5i
PqUOfwXBUQPWAQm4y7fb3wEbQ4k5Iw==
=fOaG
-----END PGP SIGNATURE-----

--d3hvim2dtzodhjoa--

