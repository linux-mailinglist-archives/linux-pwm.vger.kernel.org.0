Return-Path: <linux-pwm+bounces-8380-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QClDOiwBxWlZ5gQAu9opvQ
	(envelope-from <linux-pwm+bounces-8380-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:49:32 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EB332A3B
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 10:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74DC0304E0F6
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 09:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2818337267C;
	Thu, 26 Mar 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPJqBx+q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D303537E9;
	Thu, 26 Mar 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518144; cv=none; b=NuL69U/+fRePXxL2YojWOWBQmHm18PtnyWiLmayvDy4XCaMQJ4PfjTsVnXDeMaE7qMEpCl9/fqU36JPBzZ68K2B1JlRKoDWzZZwR9mkgwZ6PJ8Ji1bY7MkznfTCT7lyFCSI/wP2rSNDq6b17hUSM+nTaZxhmMMGXTDQhAupebow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518144; c=relaxed/simple;
	bh=v8fJcxXD7A4CYcyfb6M+TlCJrYfDFInBVKdu3RRKLDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMSV8Fc4h/2fxrVlksjAML+3iyloNwearPp91lVDK4A64Vvmvu3BmPLWRswzHWXaFD8ZGkY7hbWx6Q4ynvVLM6FuGfGxd2jcbnsCDrChZhXQJRhNgnkE1IYCC1JriWzWihCeLSMKiRYwvA3+nG+LglCRuqF1KDG8KTtdqigb0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPJqBx+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D4DC19423;
	Thu, 26 Mar 2026 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774518143;
	bh=v8fJcxXD7A4CYcyfb6M+TlCJrYfDFInBVKdu3RRKLDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPJqBx+qMpgFBM2oZm65Fqw7xX/suStQZbF0rG+qX8p57NRa8AHfBxorqYIaX10x4
	 Rt48oKaQvNvLJ7ODPTGgmNoo+cQb+eexg3J2BC9FDSctylDa8yUNFchxUMnajjZTEW
	 VmK1YPpeUQw2KbLWXXUOS1B89VkgQsESFkBIpmn8QucKU3fQwAOspVD17JFTg5lKfH
	 RX5WmSil72/Qph9xjC0qbh4eBxDZa2d/hVyAsdx1qlf13VnldV6RhxLV24ZWVN3mx2
	 uGdVwkBJx3C5LNLTYbGKRfxxQpCDwj/5wW4HJeww3VYJSVp2AtOWxP3D3iNaBN+L33
	 Ln8kZ1mDWunyw==
Date: Thu, 26 Mar 2026 10:42:20 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v2 5/7] pwm: tegra: Parametrize duty and scale field
 widths
Message-ID: <acT_dZoWB7ZMilE0@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-5-998d885984b3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zsoq6cv7jqhpbm3x"
Content-Disposition: inline
In-Reply-To: <20260325-t264-pwm-v2-5-998d885984b3@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8380-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 5C1EB332A3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--zsoq6cv7jqhpbm3x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/7] pwm: tegra: Parametrize duty and scale field
 widths
MIME-Version: 1.0

On Wed, Mar 25, 2026 at 07:17:03PM +0900, Mikko Perttunen wrote:
> Tegra264 has wider fields for the duty and scale register fields.
> Parameterize the driver in preparation. The depth value also
> becomes disconnected from the width of the duty field, so define
> it separately.
>=20
> Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--zsoq6cv7jqhpbm3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnE/3wACgkQ3SOs138+
s6HBmA/+NzRD5+EeO+Wok2owT1hCK6IFthpMkbXXN83ywb7ajD8Fukh7VYvs6N0W
GfYxFGzUkUci9QBZPRoWzC4cmIcilu2djTheHZgsMpf94gxQ1Kq8T61Vb7woG5IK
HWR39tYtwFAg3tz1QDqDoN6d+ZhD1sEKKas+ooewjxXGOi/UjkK6uRdmxBCYcq3M
uHeL6mydrVEEd4yowWi9DJ/Dis0D8p52gGaMWI2GmDkBYncr5RZlujTYBBqO9rRz
pKWf7OIUZ2X+e1/Sy6t+TEhni/ZIQVC/x1TWhcyaJtsKdJW56stWXd7xxT4zUQ1a
wZfiG+Bi5vle2NNavX5ClSvK5TBYDeEnS8mwQ3NOYrPpdkyx0ij2pU6ZpBwOOkiw
VOcJ24b20Yp97bnOTZXreKpP7UCEYRf3CMFXLmNLOBxrcrDaaZifbmr58AZvL2su
iG9b+LRjI5bGkG/N0hg71JM0S/4nbloeKrByBf8BhMMvrBoHBkVpUNVPCDN/n5GH
NVt7FRvde13mMYYPPkuflXLc6i6W79UVyzUHdsMuK7xVVah87xMFy45NCGI+kXug
d4TKgzeg1AzwCAH8NZ3oue4HsSX29Tcog1xwoU2iZpPArC6/tPpLZDiNq8Ti31HN
2Q7PSnaYpP7Ls7lMV2qvl5U7HNuKJgety5EeitUK9Cit6Nbf4Bg=
=hGDV
-----END PGP SIGNATURE-----

--zsoq6cv7jqhpbm3x--

