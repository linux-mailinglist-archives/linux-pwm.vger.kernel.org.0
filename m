Return-Path: <linux-pwm+bounces-8197-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uACwHsGfqmlLUgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8197-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 10:34:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A30421E033
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 10:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D61B3102E31
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2026 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E19344DB6;
	Fri,  6 Mar 2026 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWQiJ39x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B62344DB0;
	Fri,  6 Mar 2026 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789380; cv=none; b=ceFYdpD8AIqQu+WV5aqJpDL5tRgaU/UQ891DRmAF/SEbizvuKB2p9wukLD+c4hieHoMYxc1YXN/57bk1ru1/F+/U4KvszPPbBukYWcWuwBegEKtDiSR+lMN48okCHGodbqFB/3LSmYfwbfaOfQDVCWn3lK0IrrPfyqj74HmPNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789380; c=relaxed/simple;
	bh=FoiIGNp6DMC3eHerJOHrvzGKeWjUt+DKC9a9Fgi4Ni8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ1T2SpL7sDcM+JGvKbfMn10dmhyBXBAnvC7I5KAHfwysWXu9B6MXMvlgV8Oek3eqKRAbRmuhicOloh2eydJj+LWB2eJ2mTKY/XDuGKSc2DQwNF4Xn6Ze/HsuBJXhAn1Uig1fsj60xJiNWmk4irrLbTrJSQbcxLgMwzffiV0wN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWQiJ39x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F5C4CEF7;
	Fri,  6 Mar 2026 09:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772789379;
	bh=FoiIGNp6DMC3eHerJOHrvzGKeWjUt+DKC9a9Fgi4Ni8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWQiJ39xbMfGlDkQBxCjEYkkBGt1Vmhyt0HWPbFAqj/TgdYixJS7+sTAacFheWQMf
	 ceaQ6zpd5Ee9wwFDibZBYb6/dliriMauMpq48W1cRMSFZ+9nD11w0NY73R6zB/pNm1
	 gxYw1kUwy/40fZHL3Vs1UYr3cnJ6xwbW8aBv7TKLHesu2iD/yFzhat7uniyKkc4Z1F
	 5vb3LJiOZ/LKUq82Qh8q7qmGrN7uaHLKZiyVwY/1ryE7I6ibsS3Bdr7agsnb/daadi
	 OSDKUZypC6ydvpXPm4eQY7vZ80ZKwFOhrItRXF1SCMi2PXtEKYzM1uKbTvQfcwxxTj
	 IeNJe38fZ0jfA==
Date: Fri, 6 Mar 2026 10:29:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Message-ID: <aaqTVDQa7xn70bR_@monoceros>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdqtu4j6eja6jess"
Content-Disposition: inline
In-Reply-To: <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Rspamd-Queue-Id: 1A30421E033
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8197-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action


--sdqtu4j6eja6jess
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
MIME-Version: 1.0

Hello,

On Fri, Jan 30, 2026 at 02:23:49PM +0200, Cosmin Tanislav wrote:
> enable_count is only incremented after rz_mtu3_pwm_config() is called
> for the current PWM channel, causing prescale to not be checked if one
> PWM channel is enabled and we're enabling the second PWM channel of the
> same HW channel.
>=20
> To handle this edge case, if the user_count of the HW channel is larger
> than 1 and the sibling PWM channel is enabled, check that the new
> prescale is not smaller than the sibling's prescale.
>=20
> If the new prescale is larger than the sibling's prescale, use the
> sibling's prescale.
>=20
> The user_count check is ensures that we are indeed dealing with a HW
> channel that has two IOs.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>  drivers/pwm/pwm-rz-mtu3.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
> index ab39bd37edaf..f6073be1c2f8 100644
> --- a/drivers/pwm/pwm-rz-mtu3.c
> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -142,6 +142,14 @@ rz_mtu3_get_channel(struct rz_mtu3_pwm_chip *rz_mtu3=
_pwm, u32 hwpwm)
>  	return priv;
>  }
> =20
> +static u32 rz_mtu3_sibling_hwpwm(u32 hwpwm, bool is_primary)
> +{
> +	if (is_primary)
> +		return hwpwm + 1;
> +	else
> +		return hwpwm - 1;
> +}

Can we please make this function a bit more sophisticated to not need
is_primary? Something like:

static u32 rz_mtu3_sibling_hwpwm(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 =
hwpwm)
{
	struct rz_mtu3_pwm_channel *priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, hwpw=
m);

	BUG_ON(priv->map->num_channel_ios !=3D 2);

	if (priv->map->base_pwm_number =3D=3D hwpwm)
		return hwpwm + 1;
	else
		return hwpwm - 1;
}

(Or if you want to save the rz_mtu3_get_channel() call, pass priv to
rz_mtu3_sibling_hwpwm() which is already available at the call sites.)

And well, BUG_ON isn't very loved, so either it should be dropped or the
issue escalated in a more civilized manner. I keep it for the sake of
simplicity during the discussion.

> +
>  static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_p=
wm,
>  				      u32 hwpwm)
>  {
> @@ -322,6 +330,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	struct rz_mtu3_pwm_channel *priv;
>  	u64 period_cycles;
>  	u64 duty_cycles;
> +	bool is_primary;
>  	u8 prescale;
>  	u16 pv, dc;
>  	u8 val;
> @@ -329,6 +338,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> =20
>  	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
>  	ch =3D priv - rz_mtu3_pwm->channel_data;
> +	is_primary =3D priv->map->base_pwm_number =3D=3D pwm->hwpwm;
> =20
>  	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
>  					NSEC_PER_SEC);
> @@ -340,11 +350,15 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
>  	 * different settings. Modify prescalar if other PWM is off or handle
>  	 * it, if current prescale value is less than the one we want to set.
>  	 */
> -	if (rz_mtu3_pwm->enable_count[ch] > 1) {
> -		if (rz_mtu3_pwm->prescale[ch] > prescale)
> -			return -EBUSY;

OK, I understood the issue. If the sibling is already on and the current
IO is still off, enable_count doesn't account yet for the current
IO and thus is 1 but still the prescaler must not be changed.

The commit log needs updating to make this clearer.

An alternative would be to check for

	if (rz_mtu3_pwm->enable_count[ch] + (pwm->state.enabled ? 0 : 1) > 1)

but I'm not sure this is better.

> +	if (rz_mtu3_pwm->user_count[ch] > 1) {
> +		u32 sibling_hwpwm =3D rz_mtu3_sibling_hwpwm(pwm->hwpwm, is_primary);

Maybe add a comment here saying something like:

	Not all channels have a sibling, but if user_count > 1 there is
	one.
> =20
> -		prescale =3D rz_mtu3_pwm->prescale[ch];
> +		if (rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, sibling_hwpwm)) {
> +			if (rz_mtu3_pwm->prescale[ch] > prescale)
> +				return -EBUSY;
> +
> +			prescale =3D rz_mtu3_pwm->prescale[ch];
> +		}
>  	}
> =20
>  	pv =3D rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);
> @@ -371,7 +385,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	if (rz_mtu3_pwm->prescale[ch] !=3D prescale && rz_mtu3_pwm->enable_coun=
t[ch])
>  		rz_mtu3_disable(priv->mtu);
> =20
> -	if (priv->map->base_pwm_number =3D=3D pwm->hwpwm) {
> +	if (is_primary) {
>  		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
>  				      RZ_MTU3_TCR_CCLR_TGRA | val);
>  		rz_mtu3_pwm_write_tgr_registers(priv, RZ_MTU3_TGRA, pv,

All in all I'm unhappy with the hwpwm to channel+IO mapping, this makes
this all more complicated. This is something that already bugged me when
this driver was created.

It's out of scope for this series of fixes, but I wonder if we could
create a mapping from hwpwm to an IO-id like this:

	hwpwm | IO-id
	------+------
	   0  |    0	(channel 0, io 0)
	   1  |    1	(channel 0, io 1)
	   2  |    2	(channel 1, io 0)
	   3  |    4	(channel 2, io 0)
           4  |    6	(channel 3, io 0)
	   5  |    7	(channel 3, io 1)
	   6  |    8	(channel 4, io 0)
	   7  |    9	(channel 4, io 1)
	   8  |   12	(channel 6, io 0)
	   9  |   13	(channel 6, io 1)
	  10  |   14	(channel 7, io 0)
	  11  |   15	(channel 7, io 1)

then the sibling would be just `io_id ^ 1` and the channel could
be computed by `io_id >> 1` and the base id for a given io is just
`io_id & ~1`.

Tracking of an IO being enabled could be done using

	enabled_io & (1 << io_id)

I think this would be a simpler scheme that needs less memory and less
pointer dereferencing and the check for the sibling being enabled would
also be a trivial bit operation.

Best regards
Uwe

--sdqtu4j6eja6jess
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmqnn0ACgkQj4D7WH0S
/k7Wzwf/e+vzpYwwhFhW3E9JQ2D3JmIcRmgwwXg58CTquzjL9OqqWbAOb8er6weD
dkefvUn8AT0d6TyuO8mEffQsdQJXl+G8P0NyB34Tyc+5xOKdeu5fPb2anOSPt1hO
iRH9QlcU191sEnLCjkTIixMAAJWrJ4nmD8izL11D0QwC8QTSyp76pPzhl+b1f3x1
jvDPNaWJiUmGfSFDdWsplrAmTqjUWgQoBENly8gE2iNzQiYnLeoi4H/y6rkjCrnL
Q4wXUaue6LDo9WdkyfZF03p5rbja6v+glKggHyhoLzTeFfjFsSCWFLeyseaRGJLn
WORN1nKDyxhQlwcdFDgyH/wuvsQrLg==
=WvAD
-----END PGP SIGNATURE-----

--sdqtu4j6eja6jess--

