Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF43018CDE
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 17:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEIPWS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 May 2019 11:22:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53418 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEIPWS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 May 2019 11:22:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so3765146wme.3
        for <linux-pwm@vger.kernel.org>; Thu, 09 May 2019 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fd4AnKv4ACJRibaKuoxpXu6DBbtSwWBDFS8omIEIfMo=;
        b=KQjsqzwqViv7loN7ALJiKlOIcwIvHGlMzDo1BT/dPcQq05CQdI6VA40FM3cR+s24Xj
         fuY1jegYxcJd4LnyPk5Vhce/ql3nt93jP9wKXdrcvyOF8LiPjOCgRdCvZcjPZ8fNzjec
         a3CMpbO+evNM+j01Y3oM7WCP+u2zaKhtX90Y4a7FBh26AzZgWm3xI23/AGIxXLtO96LK
         S9XFFxGrro8K6CPWI1ODPVlWqTlWFo9c/vUuFfI08+dFBBSy3CwHVI2Y5pEkq+FAuIXW
         1k+YYfvj8h3UE+LE6coIFEhSRxdBN1PiyzTPydpn4geSQahqxMy66E6ZrHMmplaJemHg
         fHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fd4AnKv4ACJRibaKuoxpXu6DBbtSwWBDFS8omIEIfMo=;
        b=TqYiwOQM/MffhkVsc4UVwjvdhy30B1lJoDTZRL8Oron2D1B4rOsGUkEbIqWBtYvbeL
         wM0M5GJLyRpwvuUiAopLDqRsxSlOA1QcN3z4QSrVsZoDc/+hKfKmF3M6OcVbmK/JX6z5
         oufjAqWcI0DedvsAr3IYFdvbO06I48NGDLq1b1Bja0kJeSAfBuqGg8JjLuwcDn4sUvPx
         t4f87o13JHR99uhO1mNnME8Eq9ja0K3WGNBz33tRbt4B5hqvEaPhB4ti53mtEoJKRrxo
         Cx35IrW5uGP49vdiVVysfRsIGXpcm36sTwvm+0dYSlNQmAg1HEc2BNh4+RnuqResEl2m
         S7xw==
X-Gm-Message-State: APjAAAUynr2uFle6pPJMyrmZAPhKjbCuOhwhPg1OlYyPYYtluw2sGtDl
        ww09bZf5BdoJG/NGkU+Jm+NXxTN3Muo=
X-Google-Smtp-Source: APXvYqzMEJBYxwey5jhJTdDIKSrb2F2bhVXBPGL937AQ8K+rz/yCfrSG9u0TwALRcLyNjDQUk6Lf7Q==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr3561598wmi.6.1557415336671;
        Thu, 09 May 2019 08:22:16 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id q7sm1700486wmc.11.2019.05.09.08.22.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 08:22:15 -0700 (PDT)
Date:   Thu, 9 May 2019 17:22:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: samsung: don't uses devm-functions in .request
Message-ID: <20190509152214.GF8907@ulmo>
References: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
 <20190325094934.10221-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xkJEvbTYpfqRozZ0"
Content-Disposition: inline
In-Reply-To: <20190325094934.10221-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xkJEvbTYpfqRozZ0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 10:49:34AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> A call to .request() is always paired by a call to .free() before a given
> device is disposed. So the simplification that usually is possible when
> using devm-functions cannot be used here. So use plain kzalloc() and
> kfree() for improved runtime behaviour and reduced memory footprint.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-samsung.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, and dropped the chip->dev parameter while at it to make this
actually build.

Thanks,
Thierry

--xkJEvbTYpfqRozZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzURaYACgkQ3SOs138+
s6HjBBAAtZemmlMmdjKFa/PdYdYRAqmlWRtuwUgsmS4VWc5pCQNJWulVIQseFMiF
WSZGKgI6j2b6WDjmZRQuCgd9nV78dXOuL7RQM3RYT2tozDQHSbEkbd/t0Ye+J7yF
fcpcpgX0Xy29enS7CuAIhAZ0kZryhi3zvHnQO+jdEhU2oaZkTqj7r/dddtS7kT0C
Z9Uzo4M396PHLRmGcvFiS3xswcRlJfkHANYpnTuTuui9nHVAuWP6zbj18+xGf4XE
nSvs5GbjdCSL1oFSJ3WUrI5nf1mF1Ct7oNGH9TUPXoT294RaThoNFzBI39OFTRAj
yUwXPqRrvbp2COCEnetz6D4KZn9vAhLqry+2f6NGmQgLaWfbz2b4OlcN42vWVPvy
XknnXH5pPW+RW5/BAhv5n1xfJUjQfC7MSXQlX3FQio8l45W6rV39EzHuOEJaJiYP
xDbzDvzrPAlJaQS+ze8/tB9Ydsys4GsmMAyZB/D9GVGp71+oY7oQmdDVHGSXZGle
2RYCLnazAkhYa11hFSQ8VjKb8y71hsDVxmvNVOUmlcoMBy7Igo91wId1zQCJySx5
4+X02jmfFdyjHJHLMCV3nrG8gsfkAT/DldhUisQl8DHJ4QGFSSVLtTLGOQllhz5V
81T7DCsDQ73NUHx7XqsOLcNrisWC+LqfPzv3TNR/xxR9pC+H/4s=
=XtqK
-----END PGP SIGNATURE-----

--xkJEvbTYpfqRozZ0--
