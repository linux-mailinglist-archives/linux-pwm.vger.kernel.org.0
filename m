Return-Path: <linux-pwm+bounces-8379-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JFsFqACxWlZ5gQAu9opvQ
	(envelope-from <linux-pwm+bounces-8379-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:55:44 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7419B332BD2
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D8B3308E8A6
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEFE350A1B;
	Thu, 26 Mar 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9hlyzDX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42634E74E;
	Thu, 26 Mar 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518073; cv=none; b=WkuccSOhXNaGvIoW9DYcMk4TdYRWgJbHvgDxmMTDRiHtwZ2umJ+nLadqvJXSAsSuUxad/2owvukn2YGdqAoG/MeMy4YIHrsrCEnT0p3oilVHcZ9TF+6HqTFcEsP+GiII2Idb5vHEUxcpW53OMsToONkRQJQ927bD/aj6HqDyICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518073; c=relaxed/simple;
	bh=LXO/ZoYhdP1lO0jJP7coqJaFwOOcEUtUqp5npVXiXQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVlM7ZqBVCfofO7SDg13mh/SXOrYX9TaQBv5mF5xvf378H5NEHB3RovRNkegDWmx43Ntr4lyB59oG4H889Wc/Qsr0ekHbavlbacB7oYyiFpd294U5xq2jThpe992lJ45VhUkVHYNduTsGwcI8q3R51bC+B/sMCaKNP1Cpvx5rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9hlyzDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8861DC19423;
	Thu, 26 Mar 2026 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774518073;
	bh=LXO/ZoYhdP1lO0jJP7coqJaFwOOcEUtUqp5npVXiXQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9hlyzDXp3wnmy9xYHQbT9QGCRmu95NGrbfr3s+7He3+VdhpglwVODn6T/Rcobyul
	 AOHSK73O57rRSVOEWej4Ojpc0qKS/T9ONemcDS5KnUxR7NWgqfy0POv02PjSVuep0E
	 XdtsEbgB85BCmxaMUX7abRDEO/YHCPV2YXoZzPdo/sM7wvvcVc+7W4tyTzGP7YOmgl
	 EenGO0KzdraWugeQjQIyB0HP8FE5/qAzodwoctP56dRiDDBxeWVTjLSGfnLvkw24bm
	 h1BZnt2WROl55myL+mK0hFb5A/meDX7sBCG1M8gvyNvBP/YIGkypkyeFA/RHJ6DoOU
	 Gj1ekTzbIgO2w==
Date: Thu, 26 Mar 2026 10:41:10 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: Document Tegra194 and Tegra264
 controllers
Message-ID: <acT8Bc7x-Pf6e5w5@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-1-998d885984b3@nvidia.com>
 <acPuMGhPw74roB1E@orome>
 <177448605080.767719.1955302882683123394.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2nsh7bm5ntdspgqa"
Content-Disposition: inline
In-Reply-To: <177448605080.767719.1955302882683123394.b4-reply@b4>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8379-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 7419B332BD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--2nsh7bm5ntdspgqa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: Document Tegra194 and Tegra264
 controllers
MIME-Version: 1.0

On Thu, Mar 26, 2026 at 09:47:30AM +0900, Mikko Perttunen wrote:
> On 2026-03-25 15:22 +0100, Thierry Reding wrote:
> > On Wed, Mar 25, 2026 at 07:16:59PM +0900, Mikko Perttunen wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > The PWM controller found on Tegra264 is largely compatible with the o=
ne
> > > on prior generations, but it comes with some extra features, hence a =
new
> > > compatible string is needed.
> > >=20
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > ---
> > >  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm=
=2Eyaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > > index 41cea4979132..15706d2a808d 100644
> > > --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > > +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > > @@ -16,6 +16,8 @@ properties:
> > >        - enum:
> > >            - nvidia,tegra20-pwm
> > >            - nvidia,tegra186-pwm
> > > +          - nvidia,tegra194-pwm
> > > +          - nvidia,tegra264-pwm
> >=20
> > I think this was lost during the earlier conversation we had on the
> > split of these patches. Krzysztof had pointed out that tegra194-pwm is
> > now a duplicate entry. I don't know exactly how it ended up like this,
> > but I'm pretty sure what I meant was:
> >=20
> > 	- items:
> > 	    - const: tegra264-pwm
> > 	    - const: tegra194-pwm
>=20
> Ah, I see now.
>=20
> >=20
> > This mirrors the fact that this is in fact backwards-compatible with
> > Tegra194 but also has additional features that we need the Tegra264
> > compatible string for.
>=20
> The Tegra264 PWM controller is in fact not backwards compatible with
> Tegra194. It is close but not quite. I will drop the duplicate tegra194
> compatible string and update the commit message accordingly.

Ah... I remembered this wrongly. Yes, since the enable bit was moved to
a different register, we cannot claim backwards-compatibility.

Thierry

--2nsh7bm5ntdspgqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnE/zYACgkQ3SOs138+
s6GgZhAAkilSF0PC3GCBDjfMq3BMHyWyd2FX5PLkbXwsje7KecjRZ4TQ4dqTTfPL
4UTxcZK7DkGojkJp8bMVrFvuiugyvVw7W7eqQOk9cwnRkB+/t8wC1xYb0PcPYzpO
yvPUyVrfY4M9G2VL2RmYkMMq+RniNYKDFOyNDmovBrHLEUExnJDMT6BCUMRH2/yk
2boMzqlmwVnh+xkX0MSCSSFY3FMbstVVeKjt9/NjMTWAe5o1BR6jVsKtIvQBjlzy
hykryPJ6mKWnzYm8n8X5MHEAH76IImaxsOJcTAFNlb5dG0szseSWbsBnrRbWtU3h
woECW/i6aN0VtivGVj8haDR9KsVN35GvkhVYVF5wO/J0fey9Q/fCKlhEIzWjVfiF
ArvnsiPazYaZT8Kxrvu7dYXBiiyHYjtaQpwuqU0MHKmzBi4OYi4sGKvlZJos8reL
BP9cO61VDOlPn6ZzJ1XRk+o7Jpq3HRAwCoYhMYmPBoSrE2w3mV1dU36rDBXOJBsQ
8heKClMNEdFFIz7q3ypEcQqGG7rNaWWYi0OcMoUr0tNBlaa92550fCwriPsEjdtO
gjD/wpbVTGPJGIpwNl9CTM4rhcAJcck6cAnkCQaKYhGiFa+ZjlJKIRbT4pFL7CEg
he3xacq1YBXKk2/vBtUhPE6NbIQdMqGKvC89wXlKCILjcMspA2A=
=MURh
-----END PGP SIGNATURE-----

--2nsh7bm5ntdspgqa--

