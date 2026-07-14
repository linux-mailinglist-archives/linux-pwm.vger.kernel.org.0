Return-Path: <linux-pwm+bounces-9708-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3B4xN3L+VWovxgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9708-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 11:16:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDE0752B8D
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 11:16:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SVLt9lGm;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9708-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9708-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B4BD301AA5F
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jul 2026 09:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EE643CEF6;
	Tue, 14 Jul 2026 09:14:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0543CED2;
	Tue, 14 Jul 2026 09:14:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020499; cv=none; b=s2VU58HhdELrb9MWw1HdwRaPG3t4iqKgnNEMRfyHLpNGAGC0GbNdKJgbSPcWefD0NImJZ8zsi3b6cxCyERioy4pTZsh7Qth5ZacdV1/8xdMZzgC5Dy2ZVFtavYP2erpZEaxnInEMvObaoCVPDTM7LNR6fIxVu91TAU+hkTdDCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020499; c=relaxed/simple;
	bh=ntaX10T+l7fqMbR+dGbqfrjrfCYGygcO5GmmObgI3Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUm7FfEchFSpNYRZZ0UQo9ODKVxZZzkXMy8saqstzE9INr++9X4Dz1LvK2v0BuftnoprLELKNtDLK2/lCZqPHUp7XCUPinYmOK2AitVaWVz4hxpZzRlqTCYZiv3m8zf0DbBjJnya56tx4IgQWEpp0kLYeYOuzwzOlii+eaaHcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVLt9lGm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8F11B1F000E9;
	Tue, 14 Jul 2026 09:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784020498;
	bh=brxNjFFy9om48qRoAb792mhLDXah3EnrFZs6Q+OXfKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SVLt9lGmBSR2mBzo8KlRtisylJEmyNQ5oOB347SIQKvIbNFCXpFSRHrl1xBph4bEd
	 kgYLOvxgUcIQV92rlaIlb1a+8f7Spvnf/4myRjFr+7gIlLHAePxY10ifDxL6OKdoNB
	 BHUf6vwq332+M7OC+I0/rCuE4vaTyeeKr3TQ3jXdnmwOtSiAGalNWXDYA2EmynZN+M
	 WGd4fjOg1w/oRz61AG9wXjKlm67u8h1XLJOPphLH1o7W49W9egMtg7YuzOXjnjsD5Y
	 3MpBCrNZ4/75KwnHp+SNy52OczI3eq6qfo8GTje5oqv8u2tll6HxA9qlD45gwqhuF9
	 7HxUPlN4xk77g==
Date: Tue, 14 Jul 2026 11:14:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Ola Chr. Vaage" <o.c.vage@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH] pwm: tegra: fix doubled output frequency due to divider
 truncation
Message-ID: <alX5fmfHs1CW_bps@monoceros>
References: <20260713111541.473547-1-o.c.vage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3lqlu3v5zgu43npu"
Content-Disposition: inline
In-Reply-To: <20260713111541.473547-1-o.c.vage@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:o.c.vage@gmail.com,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ola.christoffer.vage@scoutdi.com,m:ocvage@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9708-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EDE0752B8D


--3lqlu3v5zgu43npu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tegra: fix doubled output frequency due to divider
 truncation
MIME-Version: 1.0

Hello Ola,

On Mon, Jul 13, 2026 at 01:15:41PM +0200, Ola Chr. Vaage wrote:
> From: "Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
>=20
> The PWM_SCALE frequency divider is computed by rounding down
>=20
> 	clk_rate * period_ns / (NSEC_PER_SEC << PWM_DUTY_WIDTH)
>=20
> With dynamic clock scaling (Tegra186 and later), the driver doubles its
> clock-rate request when the provider cannot meet it. The provider then
> typically grants slightly less than the doubled request, the exact
> divider lands just below 2, and the round-down truncates it to 1: the
> output runs at double the requested frequency. On Tegra234 the BPMP
> grants PWM clock rates as 408 MHz / N, so nearly every requested period
> is affected: requesting 40000 ns produces 20078 ns, 100000 ns produces
> 50195 ns. The duty ratio is computed independently and stays correct,
> which hides the problem from duty-only consumers such as backlights;
> frequency-sensitive loads break.
>=20
> Measured on a Jetson Orin NX board with the 45334 ns fan period used in
> NVIDIA device trees:
>=20
> 	required_clk_rate =3D ceil((1e9 << 8) / 45334) =3D 5646977
> 	clk_round_rate() =3D 5589041 (408 MHz / 73) -> request doubled
> 	dev_pm_opp_set_rate(11293954) grants 11027028 (408 MHz / 37)
> 	divider =3D trunc(1.953) =3D 1 -> output period 23217 ns, 43.07 kHz
>=20
> 43 kHz is outside the 21-28 kHz band that 4-wire fan PWM inputs are
> designed for. The fan on this board cannot start below duty 110/255 and
> stalls below 88/255, so closed-loop fan control oscillates between a
> stalled fan and full speed.
>=20
> Round the divider to the closest integer instead. This bounds the
> period error to half a divider step rather than a full one, and
> restores what this configuration did before commit 8c193f4714df
> ("pwm: tegra: Optimize period calculation") switched the rounding from
> closest to down: divider round(0.99) =3D 1 on the undoubled 5589041 Hz
> grant, period 45802 ns, +1.0%. Between that commit and commit
> 5eccd0d9fabc ("pwm: tegra: Ensure the clock rate is not less than
> needed") the same request failed with -EINVAL instead. Verified on the
> Orin NX with this patch applied: PWM_SCALE reads 1 (21.54 kHz, +2.4%
> period), the fan starts at duty <=3D 50/255 and sustains 80/255, and
> closed-loop control is stable. There is no round-closest variant of
> mul_u64_u64_div_u64(), so compute twice the quotient and round up the
> halving.
>=20
> Fixes: 5eccd0d9fabc ("pwm: tegra: Ensure the clock rate is not less than =
needed")
> Signed-off-by: Ola Chr. Vaage <ola.christoffer.vage@scoutdi.com>
> ---
>  drivers/pwm/pwm-tegra.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 172063b51d4..a5adc4f3ce6 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -163,9 +163,15 @@ static int tegra_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  		pc->clk_rate =3D clk_get_rate(pc->clk);
>  	}
> =20
> -	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> -	rate =3D mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> +	/*
> +	 * Consider precision in PWM_SCALE_WIDTH rate calculation. Round to
> +	 * the closest integer: there is no round-closest variant of
> +	 * mul_u64_u64_div_u64(), so compute twice the quotient and round up
> +	 * the halving.
> +	 */
> +	rate =3D mul_u64_u64_div_u64(pc->clk_rate, 2 * (u64)period_ns,
>  				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
> +	rate =3D DIV_ROUND_UP_ULL(rate, 2);
> =20
>  	/*
>  	 * Since the actual PWM divider is the register's frequency divider

The usual behaviour for .apply() is to pick the largest possible period
not larger than the requested period (and similar for duty_cycle). The
tegra PWM driver doesn't do that and instead trys to pick a nearest
match. If you change how the configuration happens, the only acceptable
way is to migrate to the usual behaviour, still better, convert to the
waveform callbacks.

The driver also lacks a .get_state() callback and should not use
pwm_is_enabled(). Also calling tegra_pwm_config() discards bits from
state->duty_cycle and state->period if they are bigger than INT_MAX.

So there are some things to work on in that driver, but don't make the
clock selection not more complicated as it already is and as is
necessary.

Best regards
Uwe

--3lqlu3v5zgu43npu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpV/g0ACgkQj4D7WH0S
/k6WQgf7Bk37pb5NU5Yvl9/heLHuSrI+edhIGSqQlVsHuG6XbLJgC5IUbvDM6427
4B76RKd81FNuPXO9QQBO5PS/5CGH1Gtew/TAaoc61sPTAdcqpyGtyd/rQFT9WRbX
UGp3AG13ErlZftyUYJa4C3bs66RIPahC9PVfHnZ4QiQvA+IKHaBgtHaGG2wLoF2n
zdLvPpSVAsurHqPW27xRozZZaLPj3bWKs0G0XTyUWOaO1FvRrwA/hdRrFDVdlnh8
yAdhtQwXTHHv/JmysayXzVqKC86kxVepnqAa8qXx9omqNK/WVlOjSFzmgiyL95x9
xhIUkrSzWoNxqDnzWxTGmSImuebZVQ==
=6u4x
-----END PGP SIGNATURE-----

--3lqlu3v5zgu43npu--

