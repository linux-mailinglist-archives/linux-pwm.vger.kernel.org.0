Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9852AF7B4
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 19:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgKKSHg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 13:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgKKSHf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 13:07:35 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E968C0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 10:07:35 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so3173042wme.3
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 10:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pg9PNaovo24Rh8fP+CDhG35u8Ky03i4DlIeRtl+Iuyc=;
        b=vJnjreOo5s5RlfwQVuHcgXCEor79epeHBx1xfIJUU/hqiu1UJu5SyHBd1s37BWudcp
         SSjfY/Yja/0L+OjKmWRg+c8wK5EfZwWCV/yv2qlXqALjb71ss5OrzUDLI9+l/Q/hqz0h
         fef3+SHefsBAL+OWKVwvvbsTj7M4hD0pYrAZ2+Xu89XQyQTcEBdvwX8GhCPcgloNyHVA
         +A4GuZ7bzyyGZDlS/jX8u2f3fEYHhWjoB10E36QdE3Ce7ZktIPs8sp2XLCxFeXY/todT
         eIVBRwG7x+fVyPe9m7fsR9OoxhwNBVNAg7XCcVOlr/7dLTPMXqXuOMmY3RxUjlq51btv
         Orlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pg9PNaovo24Rh8fP+CDhG35u8Ky03i4DlIeRtl+Iuyc=;
        b=mLQeR+Alm2IMaIBsLjy5yT9KeDRaXY+IPPve3u/ebB2GOA4c10sPHGyCCniXH/0nDM
         uvPUgFnfCKoXyPE050XsIkKV21mOookO8S3WS6w+BRDNfn0+bdKgPuvx+oYYFhMAuCd7
         MHpfGMOh9C4iP7eGTg2d4ANR8Cafl1mtZYExb7SPQ7C1JNOAO7d9KmAI8iTMYndkZge4
         LuEDBEIVr0WwUrPMtHEByJUkecmz7rMPaz90AaqbodeIkznd+llGfYBmuFUMvnk5MZDB
         mj7xQZavEby4vAAjT4pdnjAmSk5pKlNonBOPDMlX4XRp6B3w0EabvUCUL9EBjXtkISiY
         /KOw==
X-Gm-Message-State: AOAM531oCrQEUfzSPI9LIhHHOcEurJPlJc7fx9o/ugMR+rXRTRg/xGnM
        AS5YSZt5V/qd9r509DQ+z+4=
X-Google-Smtp-Source: ABdhPJwOQw1EH5IS0OKvZkFXGJrcP4SMkIFuEvgE84Hwmfu/p8gVadN/QUrffG+CUxfwBx+4L1FZHg==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr5500792wmd.70.1605118054036;
        Wed, 11 Nov 2020 10:07:34 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id h15sm3374895wrw.15.2020.11.11.10.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:07:32 -0800 (PST)
Date:   Wed, 11 Nov 2020 19:07:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: ab8500: Add error message if pwmchip_add() fails
Message-ID: <20201111180731.GB6125@ulmo>
References: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2020 at 09:52:14AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> pwmchip_add() doesn't emit an error message, so add one in the driver.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-ab8500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sKGMACgkQ3SOs138+
s6Fgjw/+IFFZaByYX/h1GpDZMLNeawSGQWGf8/LhtysGdXnBsAIrZU009dWES8O0
UelUJYYckdj8gY+ptJ3tPl5SpBKTEcxwIfKjz7dM8UvnGJWDO8zNPkk5FLLhf8Aq
mC9SeZQo+RS4F0GjdPIF8rudmKXfJKc6Fs35UA182DN25/nZ6HgozSUnJM9P0zzj
2soy332xZqNPkHjRhtPOFEIZBb9SDq95soaxe/Kg2/cuMRB2+2H7Y5kT0H5m/mu7
IzgALPXqJ6ksaz8xYJMD3OYXqZYaQLWptigey0zGRry5btpeED1OCE5WRxHqY3Dr
yvHi7u3uDVItHh7ix5LRMqyNd6psLmpFfHKgCgFIv6lXuD0k+wJeFfjZsTMqQD70
e2tM8DHWgljQ6aGprlBpmqKVO0AQErFsRgSQstodF+ILcXbXoH3XCvIiKQ+Og9cb
ln/Ex/zOA6x0Z2HrUFJefaB0wC7pc0p2YM78xzgP1FetNe/n50VUzsdqOklu6hJY
G7DQiBFPIcru1rZV36fRtuM8u5hnngybAm8DbF5vMn0asYQlSdHkZ0JC5ZpPucis
JEMQQ/QJ3JhYVnTmMhF2PbpcDp8oFn9jn4yurtW4nhW9g7XM6C+2MSihKWjzsxTW
9UmbEhQ6VGsL/trvOCYUw43T183TuAiNjeWknz6AchPFto8o5Lc=
=pBAG
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
