Return-Path: <linux-pwm+bounces-7093-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C77B2B91E
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 08:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F93583307
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC3262FD2;
	Tue, 19 Aug 2025 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsVMJGQI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5824887E;
	Tue, 19 Aug 2025 06:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583769; cv=none; b=E0WxfUoY73pCVKYkvluuzTjtT7sPTfLNe4ALdYw4zHBmQBPwuZW8OIu+f1eYjdFOWS9l0aamR9jrXRd5+VDAlhB90RDTrmglAbDifZ8UjJnrJ8E8wdv2SaH0b+1/YVEENByr5mHrMhc2IQ5hfgVSIoQWXksutcF5y06zDT2g7oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583769; c=relaxed/simple;
	bh=o8gg4esKzhrXW5xRLa4YA+2LIArey07uhNGPYg+o6r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK1iTeRF+9c72oyZa3lqES2wthWPL1kXj0EShZvFfgz7IJqMHP8qlJ2N4XExxfhSThOX3DqoHFzX7wV+5Xj08WjXZScRbQUQT2e6hasajabulfdYwkJooShgt9UQfYpzo3hJxRCfY6VnJpsnMaYxLZrShBYSlYxy1iRiEP4bmuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsVMJGQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA340C4CEF4;
	Tue, 19 Aug 2025 06:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755583768;
	bh=o8gg4esKzhrXW5xRLa4YA+2LIArey07uhNGPYg+o6r0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsVMJGQITGW1H27xkdEzFhnhVzzVZHSJJ+sYfdI3vue67s81lO3PyhAa8qvVe2XwC
	 aRPqZxecPuS6ERc4/+eGYccsRxMsvMqmmOjYDIiI7JCqcbuXSeO0oA6xWp3wGFiizi
	 d7bNqC0g5x2R/MvLKZf+70O8/MGlluUeeIZmhWUdz3UyeVCc4Qg/WBeTe175KVmDTa
	 gNDGthWz7LdEBQxc1smD7WOT9fI3VD9nYjrm8BbRPFLt143DwAV+GpEL1QGJ1xwih9
	 XG9PGCyW+MUBN4XsvDA51dmpazmjEx55VkNg1w10eyQ/Mjm+4HT0ReFd41OMRj3MUT
	 cNX8i5by7Z4dw==
Date: Tue, 19 Aug 2025 08:09:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com, 
	dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, lgirdwood@gmail.com, 
	tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org, broonie@kernel.org, 
	gregkh@linuxfoundation.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	shuah@kernel.org
Subject: Re: [PATCH 0/8] dt-bindings: Convert TWL4030/6040 family binding to
 DT schema
Message-ID: <564lqfhskoiivxziptyhrkajpblrrnk7nmfe73fzsd6ov2vwlh@n6ydqbrxh2my>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wx3t3mqnpi5eirrc"
Content-Disposition: inline
In-Reply-To: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>


--wx3t3mqnpi5eirrc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/8] dt-bindings: Convert TWL4030/6040 family binding to
 DT schema
MIME-Version: 1.0

Hello,

On Tue, Aug 12, 2025 at 12:47:31AM +0200, Jihed Chaibi wrote:
> This series modernizes the Device Tree bindings for the Texas
> Instruments TWL4030/TWL6040 family by converting all remaining
> legacy TXT bindings to the structured YAML DT schema format.
>=20
> This improves the bindings by adding formal type checking, clear property
> definitions, and machine-readable examples, which allows for automated
> validation and better documentation for developers.
>=20
> The following eight patches are included in this series, covering the
> audio, keypad, power, PWM, and USB sub-modules.

Thanks for doing that.

I think the patches are all orthogonal and can/should be applied by the
respective subsystem maintainers once they are considered ready?

Best regards
Uwe

--wx3t3mqnpi5eirrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmikFRMACgkQj4D7WH0S
/k7K4Qf+NXaiDwh8VZ3/FPuqYKi8JDG6yZev/d9gfb9whZz7mnjc5HNUoniMaaIX
WPmzU2zk9W7nV/JaCamjURYPHvQI+4K6CbOmBU2AmO3CAgfbejOoUjtsQmNa+bei
XSrmaRgy9awVDnE30dT6AsV5cgCAgq6pjhJYXrftH5827tFkeHdHd1KEsZj07TdD
iglm1Pfcb0RKy0L6A/Wab7O10bFbkeuNWphUnfN0ikJ/cTSS3fGuiAuH2dT+olfA
LULNsZWSim7+vfXhiS75zbSIEovn4HmvgxMDmsNKYLnhZXj7AR/7fRMtwmx2LUxS
iaeLl8en8XlDqUMqoyVdNHyRkHmCdw==
=k0sm
-----END PGP SIGNATURE-----

--wx3t3mqnpi5eirrc--

