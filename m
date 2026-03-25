Return-Path: <linux-pwm+bounces-8369-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHUxH7jxw2lZvAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8369-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 15:31:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB053326CC7
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 15:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3015B30CFA1E
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23ED3DFC81;
	Wed, 25 Mar 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aph2us2B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63D30B509;
	Wed, 25 Mar 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448535; cv=none; b=dN55R0sYdzU76Om7/BZro4BBRidcJyo5s304kHz0+4RNtz7qQvtDweWCGwGjlJEa3R39GNdcoKFy49vldNlO1veJBpzRaX4+h9F5E+5juFhAVJoFBXVic4k2+cJwQ7BRj7Jobuygmn3JjqXy4MRPxw25g5mIWHzBHjyRVv6DRuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448535; c=relaxed/simple;
	bh=vmrj39rcfkGKh/Ia7TefUaESQzcw43p3ZywMgJ2IK3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJdYB8mTThB8e3hySYCQAbxCJs8X3oVUmQjT1HrnA18O50adUvz4PUmNHgi8IKFjtn+ndga2o0dxbGHE+MiV8RgYwLvKxQqHzngfkoRadZvwaIt5u1nhYKmZjIRDCt+dclw2kAbZtGXX1SkNm8dWjwt+HyscuNEauuHEXACpC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aph2us2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B15EC4CEF7;
	Wed, 25 Mar 2026 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774448535;
	bh=vmrj39rcfkGKh/Ia7TefUaESQzcw43p3ZywMgJ2IK3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aph2us2BflIXnVhCOfyNFd1GFIZnxAQJPccWNWn8EJPcFUsAqPoydGbOg70qjWrGy
	 CVjndUFIAVL2gqoBxL7GyX36OrUXELjMMUxzcrnk3sO3Yl0gRoCkdjpGGvzg76CvUw
	 ygqEH5FiczErRcYFujYwiIutjZSsabXVlbl2PJx164MJhBrUMuNuzGVfh5GVm0XiFa
	 7oGPa8t89PfGEkBxJyy2chyzDXgU3g5MsmYPjXRoxN/g6GdHIWoU79e1TTeuaSgbna
	 DRCDQSjwzgtuoKt3FCyy00YiG/2gqdbpRfo3saLoPIFa09pTyBrdMS1Z0lghhUhgGC
	 fjJ25aXpZ02uw==
Date: Wed, 25 Mar 2026 15:22:13 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: Document Tegra194 and Tegra264
 controllers
Message-ID: <acPuMGhPw74roB1E@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-1-998d885984b3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sznsudrqo2r736d6"
Content-Disposition: inline
In-Reply-To: <20260325-t264-pwm-v2-1-998d885984b3@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8369-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: DB053326CC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--sznsudrqo2r736d6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: Document Tegra194 and Tegra264
 controllers
MIME-Version: 1.0

On Wed, Mar 25, 2026 at 07:16:59PM +0900, Mikko Perttunen wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The PWM controller found on Tegra264 is largely compatible with the one
> on prior generations, but it comes with some extra features, hence a new
> compatible string is needed.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yam=
l b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> index 41cea4979132..15706d2a808d 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> @@ -16,6 +16,8 @@ properties:
>        - enum:
>            - nvidia,tegra20-pwm
>            - nvidia,tegra186-pwm
> +          - nvidia,tegra194-pwm
> +          - nvidia,tegra264-pwm

I think this was lost during the earlier conversation we had on the
split of these patches. Krzysztof had pointed out that tegra194-pwm is
now a duplicate entry. I don't know exactly how it ended up like this,
but I'm pretty sure what I meant was:

	- items:
	    - const: tegra264-pwm
	    - const: tegra194-pwm

This mirrors the fact that this is in fact backwards-compatible with
Tegra194 but also has additional features that we need the Tegra264
compatible string for.

Krzysztof also requested that we drop the latter part of, or reword, the
commit message because we always want the compatible string to be added,
regardless of backwards-compatibility, etc.

So I think maybe something like this would be better for the commit
message:

  The PWM controller found on Tegra264 is largely compatible with the one
  on prior generations, but it comes with some extra features. The new
  Tegra264-specific compatible string can be used to distinguish between
  the feature sets.

Thierry

--sznsudrqo2r736d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnD75EACgkQ3SOs138+
s6G5NQ/+LBYFLyiwHVj8hNS7M7cP6oPBAOX2MBsAWE9dUDKBjs4L/Ez/hVd5rhyU
7qNedPNvkYS1K9BoCjEwXiazWiVytz8r0V+X7nn4zXl74s7T8wuVCuNXzANUMYpm
n1LlIx2pSuHqT0M9vw+g8q+xtUGhepkv9gtypkMlD3kgoMmzesqz5/mtOfsqL+GQ
jVzxCnsyMzpZvjYnQg9P5l7gHZbaFBiuE3ssz/uwjfMe5Yj7a2FS8hTqvAXPEWbP
DO0xgF96kdb2dj8S7LYkqRxy++DrFlB9doALGgyET0jNv/xLajkwZn2fcmkHw0e1
rlhR+Z+KZ+RUI4Fc1FFe6oVrHGWZCb3zLk/Ak1VzC1gEHBfHNaeDv7/V0BR1+isX
9vMsXJbbi92lypvBoQGfnI/Xy5kiKJO0q4V3nrxlQat44henR2RvvvRrFFvl7yeR
u+dcs+omSwNeZe5FmGNSTba5XGQvgCFoJR1mxAjvdabwiPxGuwEcvo4WiBRaorI1
HZNd48jpDDAguA8Y96dd5SP4UUzQ3xJfDcGza1GpyaD/KkDaIGfcdYxYDITYVzOL
hru8gXsym4c0iJexKYqZqMmhehrx/YacIyIecEp+x1fs4TYpem3/g7KbpStL8vpw
pSSheEqc/B8+q2jItzeze85J5yyOwP91tLC/xIHqY6tDwrMozxY=
=l5QA
-----END PGP SIGNATURE-----

--sznsudrqo2r736d6--

