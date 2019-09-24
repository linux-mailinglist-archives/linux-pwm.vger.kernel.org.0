Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD8BC5E6
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440731AbfIXKx7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 06:53:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39999 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438772AbfIXKx6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Sep 2019 06:53:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so1403925wru.7;
        Tue, 24 Sep 2019 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1+EqrCiTrKmAw8pToU7Xi1QmQXGYCJ1mSEa20bO7ELE=;
        b=H870yVUYr4Zt3m9GjpSUUlJ9EZ0JqKl1z2SIJbaQNSkgKoQ4zSF4b0+k7gSnpdHZQZ
         KbdHXJWUyEzHTg6S8C8YTaEQrT8WLKNK3BzaY/SJmZFmCJ9+lJuAs0uYuqO9kkwlyEZS
         rE5JaFZVM6W7FCaK6Wlh8Ort1x7ptMjrlcPKYuYEe9cfRkuyIM2jZyOODY0Cy+aiyd5T
         5B16XpEevpDrYuGxMDsx+CDgTWovf3B4j9tNlTtsfJ6mS3lQMAbLTviINnmDfWyQp379
         9YZFjl8vJr784oObcboVQL41hA1WAcI9eRrAzeIna80Gmh3No1olecuTJ2WqaDMOCQiE
         uNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1+EqrCiTrKmAw8pToU7Xi1QmQXGYCJ1mSEa20bO7ELE=;
        b=UyYTtV4GOg/O1HiuPZbMWsD+3IJ058Z8R739BlEeFCyucO754h3FyZhyx525iNJmwo
         5HpJbFXD81wOpdoODrZvJJi1J8hxgjpiNR2vzN+AqfDsd4PhcIRCebJNA1Z5Ewe+f2Uw
         Wiw3IJ5+syZVA3+dqXd0mMLphrS/7t/RMW1qlJy8doyisVMKvZpVrycDNPNEN+Du27F3
         BDoMXPI8cQ2Gdt5VjZ8G2oA1orNomdcyrRRfmdbjxaTUiFL/I5RtRRmgjKvAXy3kL5Kz
         RlxxFIUTei1z69CcuXap41DVsk6fiRh2m1tmv0xr+0n+ChhSIsa6xsoChbju0fWHoyoS
         1ZjA==
X-Gm-Message-State: APjAAAWi7WLxqN6Mrr94hyUcCYrSxfFXzPMUKwLdjIquWNrmjy5rWLZK
        FsM8HFb7VqV3mZ4t5dZnulV60ydB
X-Google-Smtp-Source: APXvYqwyRBmVYqBKfUPWCMI19pROSaXLJfExo7KtwkswM60Jw52Pk3rvvueLxvuR7lP1c5q/05a9BQ==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr1810687wrq.78.1569322436235;
        Tue, 24 Sep 2019 03:53:56 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id s10sm2871320wmf.48.2019.09.24.03.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 03:53:54 -0700 (PDT)
Date:   Tue, 24 Sep 2019 12:53:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 2/2] pwm: pwm-mxs: Use 'dev' instead of dereferencing it
 repeatedly
Message-ID: <20190924105353.GE14924@ulmo>
References: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
 <1569318169-12327-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <1569318169-12327-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 05:42:49PM +0800, Anson Huang wrote:
> Add helper variable dev =3D &pdev->dev to simply the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/pwm/pwm-mxs.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Again, lots of churn, no gain.

Thierry

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J9cEACgkQ3SOs138+
s6HR/A/9EUNTBnpBHITA0Kq/pZ+Bcn6+e4ivi2Lm7ml4+7UKBAFfUBkk8NR8ojWK
lg6nL1r2WlJBAzDa4uP+f5zrXZzoNIelQel6ORgDtziZbGEFeKGtb37ng+C+pKWD
AvSfhBnikiAYWHAZ4J8soZTeyQvN4obwpWDGpBYxI5OlO5oVep49N0r+4qF8DDeV
kbcFZ/5lL0KIOi//ykRD373y2f4N4mnhExY/0fKbDLe14fUGfGUf74XVn0kqwKKT
FlVLWYQU7J4pSyDMElfHZqeaEcHa7qva+gokf608yXhv7OREseYi8zXeZw7xq0Z7
35PDelZGh9tPepS2WJGjqQxZufouuBkkB6ULGaHFWEAl3C8HRC9phgw9Ws7zXGYQ
1HLKNAwNC53oovl5V942aunlWAYWLAvqCRugb2nGN4kCuiEEsyrc2w/hI836UdFt
XIHbpyR/nvVkZ/SVilLP4ZsWuuAnjhxQdPJixp+MPOl++MkjO/enrSglr90kClYv
shw78UZdLUnJ5eJ/q3kSwCmEn6pBSXLAxzbPyVu1nbB7jivmSO/vleoqNKu2eqOr
odUFJB0wcmg7jAsM8S7ZNFEiQEJr6gfO3oOcuIfIrBdZAnMxoQ7/cEeGsKWsxpFm
6tHrJvdNFw8r//AKR0l6lIY4tYFNCLP8a7sHdMUmDV0Pg1QEDgI=
=UomL
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
