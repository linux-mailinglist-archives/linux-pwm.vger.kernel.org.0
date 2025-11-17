Return-Path: <linux-pwm+bounces-7635-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2BFC62D35
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Nov 2025 09:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACA3036279E
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Nov 2025 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF031A7F3;
	Mon, 17 Nov 2025 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISl2jWWF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8230E0C2;
	Mon, 17 Nov 2025 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763366384; cv=none; b=kAQ03j582AfoLMv6OXOdhwTf9Qk6Rk7q/gT3ZBecqJxGQ408c+dOuY0ii9EecQpPivrf79beQpe57e5slqw9TORt7QUnpDhftE926zabIyLsIshudMYUEh7cDVcfCPZqOgZkuifdgRFeIuFW7Wmt9X9ECbl+WyMfEY/ON/QEux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763366384; c=relaxed/simple;
	bh=2GJODLDU9q/DrAw2v42I0tcNWvPDyLFQEM8TC1A8YdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhg/yZSTSsdttAzM7cu6YtdreNvzJ3tnpKtrnBC9EctFFO411aH0ieaMBTrqnzm5X97d5ca8ejfmipKCIMIuCGzjsMGXxMgiPpvTk/k1ov42hMw2d4EeLo2bnVYQbt2hFZA+JImGbxFN/PfmoV0f5dwc+C3pglWcwynyq3x6be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISl2jWWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D353C4CEFB;
	Mon, 17 Nov 2025 07:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763366383;
	bh=2GJODLDU9q/DrAw2v42I0tcNWvPDyLFQEM8TC1A8YdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISl2jWWFx/FOUV/JUXKCNbW2I7ACG7tmwSf9MY5BB+O8+jcRAlDPzDG2/I5K67G7z
	 KQIFVPCM4tT3wvv3HTBRxNklYBWyiTsCe5V8f9E82FQO1aT540mjoeZEusBjyN5dB2
	 fK9zyGQe908yxuhKntKi5HBhvnmYWaOFpNq+jPmXKVdopVdIiOxrScWl2Tn9zEEocg
	 sqYWIIT2/rjfoqQB2ASjLJaiRwAexs6NOoujMsvV96mqRg6GTz+7osPett9ED2v5d4
	 lpgOy6vp2rhBbVOs+XfHd0Do+mEkSzX/Q81kE0BfYjYeKTbJEhSvNRgUPoUtcqD2uR
	 r2dGfP4KYt0VA==
Date: Mon, 17 Nov 2025 08:59:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
Message-ID: <ppqewbxcvsqcpp7met6vupmvxaftfjwiefej2c25jw4hoe3c23@lyh7saabrhkd>
References: <20251114145606.200948-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="isn4hegpwjtwjdsi"
Content-Disposition: inline
In-Reply-To: <20251114145606.200948-1-biju.das.jz@bp.renesas.com>


--isn4hegpwjtwjdsi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
MIME-Version: 1.0

Hello Biju,

On Fri, Nov 14, 2025 at 02:56:01PM +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The rzg2l_gpt_config() test the rzg2l_gpt->period_tick variable. This
> check is not valid, if enabling of a channel happens after disabling all
> the channels as it test against the cached value. Therefore, reinitialize
> the variable rzg2l_gpt->period_tick to 0 in rzg2l_gpt_disable(), when
> all the logical channels of a hardware channel is disabled.
>=20
> Cc: stable@kernel.org
> Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Split the patch as separate from [1] for easy merging.
>  * Updated commit description
>  * Added comments about the fix in rzg2l_gpt_disable()
> v3:
>  * New patch
>=20
> [1] https://lore.kernel.org/all/20250915163637.3572-1-biju.das.jz@bp.rene=
sas.com/#t
> ---
>  drivers/pwm/pwm-rzg2l-gpt.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> index 360c8bf3b190..ab91bfd7da48 100644
> --- a/drivers/pwm/pwm-rzg2l-gpt.c
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -190,8 +190,17 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip =
*rzg2l_gpt,
>  	/* Stop count, Output low on GTIOCx pin when counting stops */
>  	rzg2l_gpt->channel_enable_count[ch]--;
> =20
> -	if (!rzg2l_gpt->channel_enable_count[ch])
> +	if (!rzg2l_gpt->channel_enable_count[ch]) {
>  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> +		/*
> +		 * The rzg2l_gpt_config() test the rzg2l_gpt->period_tick
> +		 * variable. This check is not valid, if enabling of a channel
> +		 * happens after disabling all the channels as it test against
> +		 * the cached value. Therefore, reinitialize the variable
> +		 * rzg2l_gpt->period_tick to 0.
> +		 */
> +		rzg2l_gpt->period_ticks[ch] =3D 0;
> +	}

I think this is wrong. rzg2l_gpt_config() has:

        if (rzg2l_gpt->channel_request_count[ch] > 1) {
                if (period_ticks < rzg2l_gpt->period_ticks[ch])
                        return -EBUSY;
                else
                        period_ticks =3D rzg2l_gpt->period_ticks[ch];
        }

So if both PWMs of channel `ch` are requested but disabled,
rzg2l_gpt->period_ticks[ch] is 0 so you assign

	period_ticks =3D rzg2l_gpt->period_ticks[ch];

=2E In that case however you don't want to change period_ticks, right?

Best regards
Uwe

--isn4hegpwjtwjdsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmka1eoACgkQj4D7WH0S
/k6Exwf/cdGVEF4ILYiMKTtMZdJVeKTxVgJjmTpCdRjS5fVsuHXRcpP7cB1R8drP
1XFtIfujgNrLe96KDWzNn2lCN1/6N51d2m3+0CYqhQQ7yWdUCIeADYxIftZe42th
gmqKh3juCBIEnhRUc3S01Y2cAbNEYaFMzyLvsWI0fgjQTbmQGuyzTmZimDTPDeaD
907JfsdjSE1h+QJoOfQz4TH5wpZN5MjRk1o1Qe9tz1WK5OTmMZb1Wq3A7hoEtQzq
FgRUpae97xkiGi31GxttJZJr6RJAfwo+zm1YqOjOsXmY9DHtb/jD/weptkWTkZkH
ynIpcRk/7lxWm2L24yr0pB/wPNdjlQ==
=xVlT
-----END PGP SIGNATURE-----

--isn4hegpwjtwjdsi--

