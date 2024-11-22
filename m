Return-Path: <linux-pwm+bounces-4119-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB23C9D626E
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 17:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCEF280EFA
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410FB1DE3BF;
	Fri, 22 Nov 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXlH+ds6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35D7E792;
	Fri, 22 Nov 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293574; cv=none; b=DC3rE9Dw5BuwWUJCGfjIr9SZu63RlfxrsPAIlZ/2zB0TRTfUNPK69t0+joTyntWbhp13FWAB0ZUCkeZg5HaKclxwi/TJYMxsrUpFicLeX0x6pFf7OjBvpQ2xs7+F1cevbrci+/DIquyRBSaiU4I2SPqMKB/ngf0KHLBtbm0TgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293574; c=relaxed/simple;
	bh=bVfmMZd++g9VWmMX2EizjlOyv67G/BQQFuNfEa0NLiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxyLvIDBWwGNTVVCmjotk45B6BevuNnRiYotr1SS3e8nMclnJYsqx0kqmKrBeHFWViuXHrdvGEiwhGPr6nTXfpMCuJ6sCil1u5SRUXAqvCu2jrM94S+9GZwWcTP//iKBmDMVe2+hp28PeZ4TFPFyG//EML41bzaaV0NK66KrFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXlH+ds6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1623C4CECE;
	Fri, 22 Nov 2024 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732293573;
	bh=bVfmMZd++g9VWmMX2EizjlOyv67G/BQQFuNfEa0NLiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXlH+ds6Bu4vcaxouVy9GHIJMQYhksn+5FEcsZbKwO1qG5QNztSK6Ejo6PzyTPdbl
	 xPzR6GS/0CyoCC+O6m9Iq0iQl/W+6OHNKSUaxTMFB4aGA6OzTukQDHqlflA0NXysPe
	 PAQI/8kjW+/XtNdbjEipZhEbBzuK3JoBGhZnOU3C+jWNHonND/cgmJunlqLeXnsaxT
	 U7+onLtWXO9aMMcX3wJkkj+AmPt5zYAO3b3b0SW9M4rvHHlBs+DsBCC8erIs3gTlTJ
	 oPI0TPO6JtfDzyFKtoMtWVESP9iQRt5PMh4J+3eHluJnyXJqyLhyAHHNQdwpwUWKWb
	 na+zzTSqnxuKA==
Date: Fri, 22 Nov 2024 17:39:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, aardelean@baylibre.com, 
	dlechner@baylibre.com, jstephan@baylibre.com, nuno.sa@analog.com, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 7/8] iio: adc: ad7606: Add iio-backend support
Message-ID: <gmv5tncy7xwgbc64na7ib42hdthojsfrusauk4hez5zmc6hh2k@4jfk74vt2gcb>
References: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
 <20241015-ad7606_add_iio_backend_support-v5-7-654faf1ae08c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g6qhxoz5xykc4ajk"
Content-Disposition: inline
In-Reply-To: <20241015-ad7606_add_iio_backend_support-v5-7-654faf1ae08c@baylibre.com>


--g6qhxoz5xykc4ajk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 7/8] iio: adc: ad7606: Add iio-backend support
MIME-Version: 1.0

On Tue, Oct 15, 2024 at 01:56:20PM +0000, Guillaume Stols wrote:
> @@ -640,6 +665,14 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val =3D st->oversampling;
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		/*
> +		 * TODO: return the real frequency intead of the requested one once
> +		 * pwm_get_state_hw comes upstream.
> +		 */
> +		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
> +		*val =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
> +		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
>  }

Being late to the party as the patch is already applied:

ad7606_set_sampling_freq() uses DIV_ROUND_UP_ULL to determine the period
=66rom freq. So I guess you should a down-rounding div here to calculate
freq from period.

Having said that, pwm_get_state_hw() is in mainline and will be included
in v6.13-rc1.

Best regards
Uwe

--g6qhxoz5xykc4ajk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdAs78ACgkQj4D7WH0S
/k5jlAgAirnhx9PpmZaNqFxVmISvdk94dasdcSLa7jDqkiXnNJ0oxpyUVc8lm0N6
NNMqQZbz66q+mmza4KXN1Oz+TPgQqZApnnp58F6ECUpurA6vgB4anXwBqiN0v8PZ
/zklo+JiCsfLuu3fkM9raKXBxRQh4xJm7PM7WTK15vzsfJCeMANwixBroV6qYtij
qj2TqzB1yhXmvt7jk4Wk6saLFPB03OHxEbY1QFFOorBXvx6vatRfTaRKTRf2HT9i
FAjJsluo4KiVaHYhHJwNebI0BiVzIeYKGcda4qTKoDabKW9Xu6Ikt/v2nOcAvuC9
z5qCVuQ/q08owpk8L41RdCHFLS5W1g==
=Cj6w
-----END PGP SIGNATURE-----

--g6qhxoz5xykc4ajk--

