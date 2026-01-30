Return-Path: <linux-pwm+bounces-8025-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFj0ESs4fWlMQwIAu9opvQ
	(envelope-from <linux-pwm+bounces-8025-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Jan 2026 00:00:59 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E2BF490
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Jan 2026 00:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB18D3011590
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 23:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783EF35CBB6;
	Fri, 30 Jan 2026 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyXhbl4V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352C35CB64;
	Fri, 30 Jan 2026 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769814005; cv=none; b=ndMD6aZkUdUVcuu6ODUXvOzwzLtdelCZkJhPjmbDwrt4FFvGbVCs92JtmfU7S8+EzsHbevYL2qfxdMLRnTDXbBs/0hOTqFBi9PVpyS9wNoDToGXl0lEV8L8YM5Dtc8AO8fPQ/rbSb4K8yKJLc0s4DVSYnVz5dEcjfNldgjVEaYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769814005; c=relaxed/simple;
	bh=GBzpXsnsK2Cyxpu5Z14dtX7F4paagl1xkilH19uLH+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbv/ByFYzztCUgE6pY0u+tUd6F6yYp2oAFxVwnpEnXkAidR2DGTC6RJXpXIg+WX58d5h3cBzsHJHPBo7UaTgxxaMk7anNg64Vwy6qVfCvLG33e262eTEUStkQR+nVWYWPcWxoHmZu+ViVRr6ufh4+jDTAF5xqYnq2+fmUF2VXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyXhbl4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7EBC4CEF7;
	Fri, 30 Jan 2026 23:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769814005;
	bh=GBzpXsnsK2Cyxpu5Z14dtX7F4paagl1xkilH19uLH+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nyXhbl4VXI1lm1QPv0+uz/7kz0F7sLvf7W5tMuWj/CH/lcUlXBOoGgoiKI/aV3vbw
	 rRwtbiud1B17Rg5m7GwSHMqBCPAmm7GPl6iL2QFt+qarYysv0ktSXfIbXC1mimMdhu
	 NuuhgHVfUNAYpxjU3VqkyYQmBWqchZIJAk5RXefKDjjPEsX63Uw8ITRZbdrUvecXJ7
	 8pmjBROil7CQtTIrhOEd6LxF9eOlDBjVcMaHQxLgZZ7GNnr5unNIAVpE+fyulFkrvU
	 u4dwz6HexOHK/SmRIvlQKL48sa8YKl//9jnjE8Rt9mzLDcqMMeWIxvxAi+E0VrRCU4
	 UDkyrvMKiuhYg==
Date: Sat, 31 Jan 2026 00:00:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc: Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx-tpm: keep channel state instead of counting
Message-ID: <sqpcohdky6m2kz5o7izoclr7k4wi2s72mi4ojrdhr2kbogtfbt@v6y5raizg2n5>
References: <20260130143720.778514-1-viorel.suman@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7xvp3kdixsnpt4an"
Content-Disposition: inline
In-Reply-To: <20260130143720.778514-1-viorel.suman@oss.nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-8025-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B7E2BF490
X-Rspamd-Action: no action


--7xvp3kdixsnpt4an
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: imx-tpm: keep channel state instead of counting
MIME-Version: 1.0

Hello,

On Fri, Jan 30, 2026 at 04:37:20PM +0200, Viorel Suman (OSS) wrote:
> diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
> index 5b399de16d60..0f8643f4a70b 100644
> --- a/drivers/pwm/pwm-imx-tpm.c
> +++ b/drivers/pwm/pwm-imx-tpm.c
> @@ -62,7 +62,7 @@ struct imx_tpm_pwm_chip {
>  	void __iomem *base;
>  	struct mutex lock;
>  	u32 user_count;
> -	u32 enable_count;
> +	u32 enabled_channels;
>  	u32 real_period;
>  };
> =20
> @@ -166,6 +166,10 @@ static int pwm_imx_tpm_get_state(struct pwm_chip *ch=
ip,
> =20
>  	/* get channel status */
>  	state->enabled =3D FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true : false;
> +	if (state->enabled)
> +		tpm->enabled_channels |=3D BIT(pwm->hwpwm);
> +	else
> +		tpm->enabled_channels &=3D ~BIT(pwm->hwpwm);

I'm not sure about this being the right approach, feels like the driver
sells the pwm core down the river resulting in something the might work
now but isn't robust.

If I understand it right, keeping the enable count balanced depends on
=2Eget_state() being called.

The usual and robust approach is that .probe() checks the device state
and initializes enable counts and the like accordingly.
=20
>  	return 0;
>  }
> @@ -282,15 +286,19 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *ch=
ip,
>  	}
>  	writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
> =20
> -	/* control the counter status */
> +	/* control the channel state */
>  	if (state->enabled !=3D c.enabled) {
>  		val =3D readl(tpm->base + PWM_IMX_TPM_SC);
>  		if (state->enabled) {
> -			if (++tpm->enable_count =3D=3D 1)
> +			if (tpm->enabled_channels =3D=3D 0) {
>  				val |=3D PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
> +			}

No { } for one line blocks please.

> +			tpm->enabled_channels |=3D BIT(pwm->hwpwm);
>  		} else {
> -			if (--tpm->enable_count =3D=3D 0)
> +			tpm->enabled_channels &=3D ~BIT(pwm->hwpwm);
> +			if (tpm->enabled_channels =3D=3D 0) {
>  				val &=3D ~PWM_IMX_TPM_SC_CMOD;
> +			}
>  		}
>  		writel(val, tpm->base + PWM_IMX_TPM_SC);
>  	}

Best regards
Uwe

--7xvp3kdixsnpt4an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAml9N+8ACgkQj4D7WH0S
/k76nAgAn8xLKTNmCc/Rl13FIw2HubBJdNbWuOQ7ASbK49bL/CHl69Q6rhlTDiHH
7XQD0ngk8c4+NRVnTx7uetLD71ZmWh8daSGg1n80MlRjlQxU1oR/II01FwMGj9tt
P1tobD+As9HklTNatNg0cKyLKFsCEpB30Lew/KcsBcyu1nchbxUnGJJ9Gp5hP659
wH4icYh4Y828hfuw8ckuoAXZkGe3wYiS8WFel0xEKmEhIex/EuJAyQuzIAJez+Qe
LtIL2XTiCQd+DhctVGqo5/aRi+Rd9X0xXEymrh0RwTPIn9CMbbFoxhthLC30/8Er
OOpYm6Vo+WNti3tgEx3Xx5VuwFNUUQ==
=eAkP
-----END PGP SIGNATURE-----

--7xvp3kdixsnpt4an--

