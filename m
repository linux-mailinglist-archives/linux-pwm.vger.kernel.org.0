Return-Path: <linux-pwm+bounces-8441-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I5mCMd4y2k3HwYAu9opvQ
	(envelope-from <linux-pwm+bounces-8441-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:33:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE551365425
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F433304AA98
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 07:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8473C13EF;
	Tue, 31 Mar 2026 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLpjq19P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428A3BE632;
	Tue, 31 Mar 2026 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942038; cv=none; b=SjY2wRn/DMv0MM0X8d1KG4giC1ro0Qiun4AzzrOYQTr5Y3TFIgsUk1di0b2VLSx9j1liCl1Voyzgzf8SAteGcuk/EiMpxHn7GmOTUy8sLyRkB9ChhvSPvT+4E7NvSHE3XRl79oK/NP0qsfirAZrD0lLBLa7bT7BTeqXSr1SBhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942038; c=relaxed/simple;
	bh=X3yeokNyZn70wlzcDKDkqaW2bU/NrHBKm0YhEEm8C3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM9m3ODD+VTMoC8kz95CShpDFlgpdKhcnLtwup+yR4jWZj55xmZhnn7EEZbwWiamjOFpXOPwzMejoMTlN4NI5cE14TeYpjA36dyeRo4iMN4nALMV3hPeaiaw/xn4y2sWMGIUyDwX38BgX+rXPO9kAbF5RfnYehXE5owL2bdJAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLpjq19P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859FFC19423;
	Tue, 31 Mar 2026 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774942037;
	bh=X3yeokNyZn70wlzcDKDkqaW2bU/NrHBKm0YhEEm8C3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLpjq19PE1SvYAIgikedhFgItbR1nnEWD5PfIOYkpgq1UhPPvheKQ6vZtsFZCaCBq
	 u6T8jCDGkZi8NHC8rIRG4A8h9p9/x7bFjYWOixLN02gtHe6EwClLJ83jKSIOWAJtUN
	 Dl0WvfrJ6kZL7V6xrGCaIXk2yw1OF1mwZAlNa6HcJ1egtOfv1JfKCoNOuFB8qxrl2j
	 cG81rVGfxEbq1beD6Znz8Ja2INBnqa5RbQolxmANaiteZaTPfP9s5fKHZkv+a7uwNi
	 rXNLXkxumleCcNn5vZC1Z7h6TSN7AUCmsrkEO3iC3oc9Jj26CEtXQ1wmn5upb2IKey
	 YtJgUUgCLmmLQ==
Date: Tue, 31 Mar 2026 09:27:15 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v2 4/7] pwm: tegra: Parametrize enable register offset
Message-ID: <act27bArVQd_oGdA@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-4-998d885984b3@nvidia.com>
 <acT_nz0TRM4yXwkb@orome>
 <177483744958.916245.860145469758840098.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="czd7pk4dwbs6pmxq"
Content-Disposition: inline
In-Reply-To: <177483744958.916245.860145469758840098.b4-reply@b4>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8441-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: BE551365425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--czd7pk4dwbs6pmxq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/7] pwm: tegra: Parametrize enable register offset
MIME-Version: 1.0

On Mon, Mar 30, 2026 at 11:24:09AM +0900, Mikko Perttunen wrote:
> On 2026-03-26 10:47 +0100, Thierry Reding wrote:
> > On Wed, Mar 25, 2026 at 07:17:02PM +0900, Mikko Perttunen wrote:
> > > On Tegra264, the PWM enablement bit is not located at the base address
> > > of the PWM controller. Hence, introduce an enablement offset field in
> > > the tegra_pwm_soc structure to describe the offset of the register.
> > >=20
> > > Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
> > > Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > >  drivers/pwm/pwm-tegra.c | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > > index cf54f75d92a5..22d709986e8c 100644
> > > --- a/drivers/pwm/pwm-tegra.c
> > > +++ b/drivers/pwm/pwm-tegra.c
> > > @@ -61,6 +61,7 @@
> > > =20
> > >  struct tegra_pwm_soc {
> > >  	unsigned int num_channels;
> > > +	unsigned int enable_reg;
> > >  };
> > > =20
> > >  struct tegra_pwm_chip {
> > > @@ -197,8 +198,9 @@ static int tegra_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > >  		err =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> > >  		if (err)
> > >  			return err;
> > > -	} else
> > > +	} else if (pc->soc->enable_reg =3D=3D PWM_CSR_0) {
> > >  		val |=3D PWM_ENABLE;
> > > +	}
> >=20
> > This looks incomplete for the Tegra264 case where
> >=20
> > 	pc->soc->enable_reg =3D=3D PWM_CSR_1
> >=20
> > > =20
> > >  	pwm_writel(pwm, PWM_CSR_0, val);
> >=20
> > I think we need another write for PWM_CSR_1 here to properly toggle the
> > PWM_ENABLE bit on Tegra264.
> >=20
> > Or am I missing something?
>=20
> This check is here just so we don't change the value of PWM_ENABLE when
> writing the CSR_0 register. The function doesn't write to CSR_1 so
> nothing needs to be done on Tegra264.
>=20
> I agree it's not the clearest, but it'll get cleaned up when adding
> support for configurable depth, as at that point we will need to write
> both registers on Tegra264.

Ah... nevermind. I realize now that we're not touching PWM_CSR_1 at all
in tegra_pwm_config(), so there's no need to explicitly set PWM_ENABLE.

If moving to the new APIs, that would need to change, but for the legacy
PWM callbacks this is probably fine.

Thierry

--czd7pk4dwbs6pmxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnLd1MACgkQ3SOs138+
s6GsYw//VxcTYb77wx69oDShM9AFwm8+heEJo+JTzEory+DPhiFE6DBYApk1K2M1
u/4LmGRYcu4D7sivvrEa+5LT2I513zXDVqmJ/AYRi5Ml099VmcGEmTpcQsynh/iY
v4mCfaMA8S8WLx/iQvIysN3xgudLmbDwhmw7HwS6bMo8vU7cXvdpweIpqd3uOh3/
FNqtGBWsbUuZFEaFg+OWo5Cc7qwuNIZnzKtf8wn/SQDIx3V+QbGKgBUJNuhjO22c
r7r8I3Us9gi0QzwKoByarAEhMmNQ56VKCOl/RK2Z4Wu/s4hL4dR6OjZXvhI1Dna7
BhFgOC+6QyfSP8G2FKy10bbyZYbsxMkTKF9aLJLkvr7IerWjjeEXSqVQw8noJmVB
HE4+0UjSqaV0PaoRtL85OiuXsmK6F4qWCWqNz2Jp4ncJo16yNFIwN8aKzm9vZlSp
pS/7hER3jsJmCrTPJgS8ANeOO/E42k5ChS4H79ojDPMXDEuOkh6Nc/zy7aLEiumy
JfUH2hE1vwfPTICYSdCb6jAsr2+byZVQ+NrtpDpyiDEQtH7Gy6vsyTIK9pf2ZvDo
HpV9eVA/kY4JrF+ln9ir9m2GfOPQRcq+dlAeq3liHtP9yXQhoUWktBPZP6u+h8gr
dqj52beQpyqaCkRbMCfCkxxq4e9mN7yJf5nU7mgiRIin5ifp3qo=
=NM+U
-----END PGP SIGNATURE-----

--czd7pk4dwbs6pmxq--

