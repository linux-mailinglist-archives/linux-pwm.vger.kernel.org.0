Return-Path: <linux-pwm+bounces-8287-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBsPF8obuWm+qwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8287-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 10:15:54 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BA12A6582
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 10:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F6D307BD83
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D235B138;
	Tue, 17 Mar 2026 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeSsBWqP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923F2359A9F;
	Tue, 17 Mar 2026 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738713; cv=none; b=Iiqw0LxhS7/QAm+/u00a1XOEpzIsaoVjy/rutXggGsTAVOsjmN7MB6ED2O1V5Row6+PrtlQkaZYz8tpfiobBfXJcijmNsPvC/cGp6phbgN/snqffiuJOFmF0YvGuw2sJtIvqUAg7WHNswD6dgk8SYNUSDdD62w0rixI4r4dSFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738713; c=relaxed/simple;
	bh=0l/t4CYYEEuOnqrcSlC1/kHh+SqwOHv3bW2imv6CkdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFi2zweDrFsQvRV3ZaMgjAZRgHFwiOOxg/DwhxeFmnJBtFsQlpH73hR98RM3XREvSFsP6dOyTM6fVi18r0e+KLA1jjPZ/oXgYIZo2caVQIHGfEPzNjBCb+l2HoHLeNk9wm7G65Uz+YmD8CaPam4Y+Rv0EStrAhWpjdQtESQxPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeSsBWqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6116C19425;
	Tue, 17 Mar 2026 09:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773738713;
	bh=0l/t4CYYEEuOnqrcSlC1/kHh+SqwOHv3bW2imv6CkdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeSsBWqPfpZBsUSt6TPTi+zNR+hwQIp/QBF9B/3XBvowELF+YzpAdZrkD3obDQQHS
	 +i56lWkjYNVdH19g7cMhJ4rBuRVJkaEA/Gl/Tu/8l35vmdFpzXzvI3hCSm4sqIByW7
	 dMpeYIn2znqMvGHuzI0Ybm682ety0XBWiesIUVa6jhQ41cGSfozzeZ1m/XwL6zUXVS
	 ukKoj3oKMLxarbAsn3fLCuTGPWtitkncsDH/iuD5Vr2yu8fVZcL1An1j4stBo0vYKG
	 fStdm1+ICXgFhc3+zJxr089Dr5YcFFBsi74hWvwbky4maXvCZuAeFQ1RgJqkxym2Fv
	 hS6P5qsu5sTOA==
Date: Tue, 17 Mar 2026 10:11:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Message-ID: <abkX1ssLhkGxryfM@monoceros>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros>
 <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hkbpaws2c2rivpjg"
Content-Disposition: inline
In-Reply-To: <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8287-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05BA12A6582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--hkbpaws2c2rivpjg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
MIME-Version: 1.0

Hello,

On Mon, Mar 16, 2026 at 03:49:35PM +0000, Cosmin-Gabriel Tanislav wrote:
> What do you think about this setup for mapping from PWM to HW?
>=20
> #define RZ_MTU3_PWM_IO(ch, secondary) \
> 	(((ch) << 1) | (secondary))
>=20
> #define RZ_MTU3_PWM_1_IO(ch) \
> 	RZ_MTU3_PWM_IO(ch, 0)
>=20
> #define RZ_MTU3_PWM_2_IO(ch) \
> 	RZ_MTU3_PWM_IO(ch, 0), \
> 	RZ_MTU3_PWM_IO(ch, 1)
>=20
> static const u8 rz_mtu3_pwm_io_map[] =3D {
> 	RZ_MTU3_PWM_2_IO(0), /* MTU0 */
> 	RZ_MTU3_PWM_1_IO(1), /* MTU1 */
> 	RZ_MTU3_PWM_1_IO(2), /* MTU2 */
> 	RZ_MTU3_PWM_2_IO(3), /* MTU3 */
> 	RZ_MTU3_PWM_2_IO(4), /* MTU4 */
> 	RZ_MTU3_PWM_2_IO(5), /* MTU6 */
> 	RZ_MTU3_PWM_2_IO(6), /* MTU7 */
> };
> static_assert(ARRAY_SIZE(rz_mtu3_pwm_io_map) =3D=3D RZ_MTU3_MAX_PWM_CHANN=
ELS);

I think the RZ_MTU3_PWM_1_IO and RZ_MTU3_PWM_2_IO macros are a bit too
magic and would use

static const u8 rz_mtu3_pwm_io_map[] =3D {
	RZ_MTU3_PWM_IO(0, 0),
	RZ_MTU3_PWM_IO(0, 1),
	RZ_MTU3_PWM_IO(1, 0),
	RZ_MTU3_PWM_IO(2, 0),
	RZ_MTU3_PWM_IO(3, 0),
	RZ_MTU3_PWM_IO(3, 1),
	RZ_MTU3_PWM_IO(4, 0),
	RZ_MTU3_PWM_IO(4, 1),
	RZ_MTU3_PWM_IO(5, 0),
	RZ_MTU3_PWM_IO(5, 1),
	RZ_MTU3_PWM_IO(6, 0),
	RZ_MTU3_PWM_IO(6, 1),
};

and then maybe just:

#define RZ_MTU3_NUM_PWM_CHANNELS ARRAY_SIZE(rz_mtu3_pwm_io_map)

instead of the static_assert. But I guess this is mostly subjective and
I won't try to convince you of my approach if you prefer your
suggestion.

> static unsigned int rz_mtu3_hwpwm_ch(u32 hwpwm)
> {
> 	return rz_mtu3_pwm_io_map[hwpwm] >> 1;
> }
>=20
> static bool rz_mtu3_hwpwm_is_primary(u32 hwpwm)
> {
> 	return !(rz_mtu3_pwm_io_map[hwpwm] & 1);
> }
>=20
> static struct rz_mtu3_pwm_channel *
> rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 hwpwm)
> {
> 	unsigned int ch =3D rz_mtu3_hwpwm_ch(hwpwm);
>=20
> 	return &rz_mtu3_pwm->channel_data[ch];
> }
>=20
> This gets rid of the loop inside rz_mtu3_get_channel() quite nicely.
>=20
> priv->map->base_pwm_number =3D=3D hwpwm checks will in turn be reduced to
> rz_mtu3_hwpwm_is_primary(hwpwm).
>=20
> If you decide that we should keep the sibling check inside
> rz_mtu3_pwm_config() as-is then we can do the following, without having
> to encode the number of channels for each HW channel explicitly.
>=20
> Please note that hwpwm + 1 is fine in this case as the last hwpwm of
> rz_mtu3_pwm_io_map is never primary.

This needs a comment plus (if possible) an assert.

> static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)
> {
> 	if (!rz_mtu3_hwpwm_is_primary(hwpwm))
> 		return hwpwm - 1;
>=20
> 	if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
> 		return -EINVAL;
>=20
> 	return hwpwm + 1;
> }
>=20
> Although, I would much rather have the following logic rather than the
> sibling check, which matches one of the alternatives you proposed earlier.
>=20
> Hopefully, the comment explains the situation well.

I got it, thanks.

> static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *p=
wm,
> 			      const struct pwm_state *state)
> {
> 	...
>=20
> 	u32 enable_count;
>=20
> 	...
>=20
> 	/*
> 	 * Account for the case where one IO is already enabled and this call
> 	 * enables the second one, to prevent the prescale from being changed.
> 	 * If this PWM is currently disabled it will be enabled by this call,
> 	 * so include it in the enable count. If it is already enabled, it has
> 	 * already been accounted for.
> 	 */
> 	enable_count =3D rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled ? 0=
 : 1);
>=20
> 	...
>=20
> 	if (enable_count > 1) {
> 		if (rz_mtu3_pwm->prescale[ch] > prescale)
> 			return -EBUSY;
>=20
> 		prescale =3D rz_mtu3_pwm->prescale[ch];
> 	}
>=20
> Please let me know what you think so we can proceed with the work
> internally.

I'd prefer the `rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled ? 0 : 1=
);`
variant. I understand that this is also the variant you prefer, so
that's great, but I wouldn't stop you using the sibling option.

You can gain some extra points for not using pwm->state. This is a relic
=66rom the legacy pwm abstraction and doesn't make much sense with the
waveform callbacks. The alternative would be to check the hardware for
being on or not. But there are many users of this member, that I also
won't yell at you for also using it.

Best regards
Uwe

--hkbpaws2c2rivpjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmm5GtQACgkQj4D7WH0S
/k4Rwwf9Hut4P4Qx1G7RdoBINBH/21rIgc1qZkpDovIq6qmB1grJs2EFSNviWTp3
7ANYEwouj4hNWBkQERzDT46d3kHkVqpxuP9Lqk5KmJpx1Qkt+zLBgL2Na30Nt1PP
9U1YYQSCkLXOJXCH6RR+B/1GD0VU5pm4oxbBMlfBehFD1XXk3DJP2IJF1vFi/4FL
EVBV0IIr63Vy9jKhTwB2qQl4KlowI/B6VPH3n7EFr6EyUR0dF6rlYbtJd16eoKJu
EL1aNGKblInghfnbXd8r81ScCb3MuO/wmwIdJ5P5HJn+eAv2cDDGR5uDUu1XAfTI
urSPuimscoRgY5KtF/soj0iroNek5Q==
=6oTZ
-----END PGP SIGNATURE-----

--hkbpaws2c2rivpjg--

