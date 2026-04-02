Return-Path: <linux-pwm+bounces-8458-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHJVD3x1zmk6nwYAu9opvQ
	(envelope-from <linux-pwm+bounces-8458-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Apr 2026 15:56:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1C38A189
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Apr 2026 15:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D4E03078C2C
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2026 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBF3806D4;
	Thu,  2 Apr 2026 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8AJOyWB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE1B2ECE9B;
	Thu,  2 Apr 2026 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137608; cv=none; b=bmkcC3f5KZbecN0ErnpDnrBK8X9E54uLzowwZKPN+gIA1Foqcr0I6EBV7YWflJyWtkYHaLtL5IiLx1l5dyFnO5QioVK+T4hJP2Qyj8o/+CNtsJzFM3VYWuwyLEyRjjfcj/R2Qu44Cty9me2BkPvn3lKafhM/0eJ81/ezwkLxV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137608; c=relaxed/simple;
	bh=ZEjmKDIfow7ENxk7DM4IKrLgjdy9XKybDTE/ogWtzH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCGDRPl/DB3LUFyXBwJXk62BXEUe/K6z/Ce8GDcmKWS99TVcjYBg0tpUYNudzcTc5JL9OIJ8PWC6qFjTTemuUa0KDN7AUZVdrAUluu4bW7eMP8bkjsZM1JnhjKkmEoBiylWqghlGtsyFI2JngJr4seTH2iCTJY/Cp6oH1Bekhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8AJOyWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4ECC19424;
	Thu,  2 Apr 2026 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775137607;
	bh=ZEjmKDIfow7ENxk7DM4IKrLgjdy9XKybDTE/ogWtzH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8AJOyWBZ5A7mYDE9tlOIxKrcA9BY8QKtFOhLGeVU+CTmqiwbWIAPrg0DZA4DSWyI
	 ioGCHACNmkjxlC52EzZQ2piNTAhyGBBuhjHecyCvHQIyVFUQLxGmMUqclkzvUdOreM
	 77y0MIKAD68/1Fdt7VEiqrTlCl9T0Etd5W0GvMK73ukVESL9Pu17ztnp5kexEKECc9
	 6UOGO5b1Crd2uwQeWVgza3z8oWaTr0iMNGalGBILbOsWgwnFKaKca2RvDprWjYEDvT
	 LW8JGqC4BQFt9wiZvAApVE17hYh0NyHSLJBHyj5b/0inTBUT0tMyv7ZLpvRgWeSbvu
	 FWX1zgaMmR/Iw==
Date: Thu, 2 Apr 2026 15:46:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Matthew Maurer <mmaurer@google.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Satya Durga Srinivasu Prabhala <satyap@quicinc.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Trilok Soni <tsoni@quicinc.com>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for equality
Message-ID: <ac5y636Wt7bqPUck@monoceros>
References: <20260203-qcom-socinfo-v2-0-d6719db85637@google.com>
 <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hamqz4ifmyrgsoal"
Content-Disposition: inline
In-Reply-To: <20260203-qcom-socinfo-v2-3-d6719db85637@google.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-8458-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,quicinc.com,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,linuxfoundation.org,ffwll.ch,samsung.com,intel.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8AD1C38A189
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--hamqz4ifmyrgsoal
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/6] rust: device: Support testing devices for equality
MIME-Version: 1.0

On Tue, Feb 03, 2026 at 03:46:32PM +0000, Matthew Maurer wrote:
> This allows device drivers to check if, for example, an auxiliary
> devices is one of its children by comparing the parent field, or
> checking if a device parameter is its own device.
>=20
> Also convert existing `.as_raw() !=3D .as_raw()` to  use this new
> implementation.
>=20
> Signed-off-by: Matthew Maurer <mmaurer@google.com>

I don't understand the implications of this patch, but it's fine for me
to be merged via the rust tree.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>


--hamqz4ifmyrgsoal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnOc0IACgkQj4D7WH0S
/k6ASwf/fRIIL3jHKKOYTcASOtVM7fzGJ0OLkDC6JblRbcNMrKJ6RmIJDyX96eYV
Zt2RmQN+twy0K15YwYiBdSWLU6yWsyomYriZo96Rd3PpM8K6Cyg2RadXLwLFvHZE
3BjQs3rgGwoaE0rdYr3Rkje5ReKIMFZF68FLh7x9xgtFVR67uDPbMnapeTQagaVX
G4l0cekgdlXUfo1xlFkYjnVPk7xkrVAzg/dT2TjYBIq76T5O6MIY9WrzXy5ifXxD
Hbie7nG7EVpLIzwaf4d1d1Jkbxny+qEhQmdIZbYht0l+EZux8H5skWnZBeLozeNK
UzKak8KjOsTAQJLy0DJvfczUV/gupA==
=cFJW
-----END PGP SIGNATURE-----

--hamqz4ifmyrgsoal--

