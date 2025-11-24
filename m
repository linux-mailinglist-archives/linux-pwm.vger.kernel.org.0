Return-Path: <linux-pwm+bounces-7687-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3170FC817F3
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 17:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732113ACD3A
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Nov 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7B314D12;
	Mon, 24 Nov 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tnWmWrRQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2887313E37
	for <linux-pwm@vger.kernel.org>; Mon, 24 Nov 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000657; cv=none; b=LzMd5/4k9fZLfP9Gr52ywoLVYVvYUsDdkjCMpRNX0FL2WQhc+Wh+S8Yr2iIYuNKPFYfznfjI7Xo80oIp11wlzpO2DHNhs9S1IvpLHmBUjon1/54F7hQvDSYhGQqQRhgBC3eJhl7UibpvuVbrGcc6E7ZfPg5amWz/doc5BBMyvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000657; c=relaxed/simple;
	bh=57eglluhUM2nZlJclDwE0caSnfRd7PY6EbxwsIKzZW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=felmCtQWjcdLD4YXpm6QygRjra4TtzdZQWr9+qLzTvuSoexOY977tTLsbj/614HMUu6MKUo+hnDYgCklSQQ4QNaSYxg77XGeKwegE05zpxJ41ZMiPtDiNuR3WVwBflSizIXn+ZcSstkhnTd/eHWWO8jEBKDHpjQj4JneHVzI2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tnWmWrRQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b713c7096f9so690676466b.3
        for <linux-pwm@vger.kernel.org>; Mon, 24 Nov 2025 08:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764000652; x=1764605452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNJKw8p/bVC9DDihKlO6wvtRyoc2CqJVoOEDDkEFruo=;
        b=tnWmWrRQNWeVC//eu2/fIIaE+0OE36czXlPaZPKymZj8MN9ZvhrssnK5+n7nYGAqDD
         ztQD8EYGkmKX/cot5R5oC+BgoqknKsDkNrZhcglYj/aX2XK32dBjAQa5Mr4yNrS/qE4J
         sUq53wFdwnnYQFgsuty2tlnnWckUK+XyAk76ZAg3K4MX5LAri2pa+2nVSy+UJWU8uclJ
         tAGnwiKdAThtyopLc4GZMtCHNLD7JyoGUBpQ6hUU+SqIRuI7+y+IiaQcL1iPTHngor8G
         iJGtWwj1Ya+Rd3uLs3K6yP/cKpag+i8292ScySxacQC8C6ZEWdDPN+TrymaMtjmKXQHl
         dfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764000652; x=1764605452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNJKw8p/bVC9DDihKlO6wvtRyoc2CqJVoOEDDkEFruo=;
        b=pRm6fH822ZMV01eNW5W7f/gUEWUvoHRO+YXcweB+TqQrhyII+kYoIk0E7D76aZ1/C7
         f+W3No7v/s+88IhPIaPMtjpvbN1Ql2vNX2nlHw0myWgTkQ5cW9YZY8Np3bVEVfcndvc3
         StaEUparzZMWF23nOTlnMlSE4lFuJVDOsP5Xm1PYTVfQQlMAqpMWs2bSmJ9QT0GEcl9f
         /rGP6icTq85erHZvb+mcFYTEIqUt82bkZaCTrtCCnGvygxMx6vPvVmnPRGobdyvO7V3c
         ncfy4a5fdeLG6x+dvFaqzl5jrcZLvNiP8AFtnQKuYhaJhF92QCdczx3/QdojJnruomJ6
         gVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+dKISVnQKTEHngOQFk3UoFuuXvm4AEHydSy7+Ri7avx5EGc1RPZkWEP3SCitjR5+8gcJq1b0xcAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjT56VLiwjnDNBBddFy07kfnEv6LyMbvrDoTEiyx10VjeoExqB
	BOJEaH/il0i++RAN46Ku5LOmimtHOACaSIqgFqeVub4lTinPC1fim7o4jUnpR5FwL1g=
X-Gm-Gg: ASbGnctXV2lBTwzdW2nJ43GnZJi/9kgEqae92UVa1GNQebi2sLkmfjf87gEjtjTCzHD
	GFlND+m2TxpBoI9RZLDoB4XOLBkUxmB87jCti0yy7J037vLaXcMrC3GzRpBztkKLhY9d7M78F3J
	pQrL4UAUPM1dULpLeNE3tRKEik0hW+F7o/dBQHewO9JvmPpXrXL2Cs1N9QKOfUVd+nD+RmIs9w3
	J54bOyZlOsqg2aXeen//xhVgXuKgdhZSzKX68HmUJXZvPiWkzi3PsiMoZDaRd9hSN2NWuZ1i4wt
	eEVm/x4AJkiElqNETXahfzmq5H4fcxZzZA6MhNsRIFsug+D04OXlni1FkT0C6xyPCGOxbg9vW0a
	TfipJnjkupF7DCBCXpmnesBPaYgBe2JpIO7hDgoNlpuLI+5rBAQervtKLY8hAMgmQwPnaBCk2Bn
	Kir96OV/vbvmZZ+ff6TNbKItwvy27cdUXEwK4DgeuYXMWWmors7om6rnOU19/NQyMSRvKQaLRU+
	YO80dvkHZqn
X-Google-Smtp-Source: AGHT+IGXZ9dwCsIFtfklKslD3fowlXA1qqiWl8NPh9/JTYvgg+1dn1ZwzOk8abK9I8dlvbUb861r3Q==
X-Received: by 2002:a17:906:b52:b0:b76:b76e:112a with SMTP id a640c23a62f3a-b76b76e11d8mr159583366b.11.1764000651916;
        Mon, 24 Nov 2025 08:10:51 -0800 (PST)
Received: from localhost (p200300f65f0267087d3c06a64089a115.dip0.t-ipconnect.de. [2003:f6:5f02:6708:7d3c:6a6:4089:a115])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b766d386665sm1040566666b.53.2025.11.24.08.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:10:51 -0800 (PST)
Date: Mon, 24 Nov 2025 17:10:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Alexandre Courbot <acourbot@nvidia.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 06/10] rust: kernel: Update ARef and AlwaysRefCounted
 imports to use sync::aref
Message-ID: <44gv3fhqppn4fyg5fnxkhhanlbbxr2slqq7k3kr3owx7frpnxw@idgwxlcv4otn>
References: <20251123092438.182251-1-shankari.ak0208@gmail.com>
 <20251123092438.182251-7-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="neqw6trvue47vu5n"
Content-Disposition: inline
In-Reply-To: <20251123092438.182251-7-shankari.ak0208@gmail.com>


--neqw6trvue47vu5n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 06/10] rust: kernel: Update ARef and AlwaysRefCounted
 imports to use sync::aref
MIME-Version: 1.0

Hello,

I suggest $Subject ~=3D s/kernel/pwm/.

On Sun, Nov 23, 2025 at 02:54:34PM +0530, Shankari Anand wrote:
> Update call sites in `pwm.rs` to import `ARef`
> and `AlwaysRefCounted` from `sync::aref`
> instead of `types`.
>=20
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>=20
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
>  rust/kernel/pwm.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index cb00f8a8765c..1605d13d5d64 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -13,7 +13,8 @@
>      devres,
>      error::{self, to_result},
>      prelude::*,
> -    types::{ARef, AlwaysRefCounted, Opaque}, //
> +    sync::aref::{ARef, AlwaysRefCounted},
> +    types::Opaque, //
>  };
>  use core::{marker::PhantomData, ptr::NonNull};

having no clue about Rust:

Can this patch be applied independent of the others via the pwm tree? If
I understand correctly it's only patch #10 that depends on the previous
patches, right?

Is there already a merge plan for this series?

Best regards
Uwe

--neqw6trvue47vu5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkkg4gACgkQj4D7WH0S
/k4ZxggAnWhK6xpYiLeXmCfK1Sb7HgBa2AsbKye0MnHsSah6DHwnqx7klhUaZs6e
21hOZ4ecYKPAdKbbwZUE4xMwMLKlAEMhJbkWsmUow5Q9+c+jvw0hfGAhiscylqP/
yKADT4IOvjkjPQ0ty4go/b0bd0qvcWDcxJXhvKi5Z+AQokSHyF4QDqRLz3Jq+mE8
T20JB7XDuIOEG7dN8qebw7XS5c4FCeCpSrCm7jeCHdfPuJj2iXz+L1IOedk3+a32
6PdlPCZxmch7aH4fUMWHtsO81LM5JVhulRuGu1ItMrklyXvDV18T7HpvvOaWJaQY
KYI/KdOn48adECwq4ltKA6NkZMhc4Q==
=9ZGw
-----END PGP SIGNATURE-----

--neqw6trvue47vu5n--

