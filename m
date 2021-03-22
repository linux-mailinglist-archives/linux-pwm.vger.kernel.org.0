Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEB3343E5F
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 11:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhCVKt7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhCVKts (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 06:49:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A975EC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:49:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d8-20020a1c1d080000b029010f15546281so8793095wmd.4
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 03:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z8BUJlTaijGF4tsrPaRZ+TA7Cswcqvl/d5E/uC+GEeU=;
        b=V5dQsvSeujFz4vpcm8+2FRDRiIgttTFkeKn2u5JbenaTXBEHkJyq6StjClhcEImsW3
         wxkr3QJNwTEta3yw6PqjRViE5xSYrGkbOe1OVYOlaI0itRP04SeVSt2M2jQAb4onFl7w
         vapFXHTNdGqrAiUz/ILMdvB9GynwJac2hpsarjhmtojnU75wO/egQvDqaK/SRoPKxeYK
         hbn1TZOJXnKW3ppX0LRZTSSwDzOx+mumkk69mqty0uwropuUhNmGTdxyN7Zd5LilpEMX
         SYkJKXQap5JG2N7YiQLcGihqEDoXRHtRc4Kj4YpzpXe1rEOTvOrYOyNY5dEeyJyLTjWp
         X/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z8BUJlTaijGF4tsrPaRZ+TA7Cswcqvl/d5E/uC+GEeU=;
        b=oRH9NpOXo85YkFQtTGp3enqPlF6HrpEJlmoAHFICJod1Mdmz4jetOcDJExjyPYL3Xn
         r7GpSHzeDGLh70PAfJGQBsEhi69zWUhzeHLKWk5d4d5KbP+paM4nyx0klZR5SllOLRx4
         sumJ43oioMdWaRJpkCAAuxAMYFl0nD0sAV3mIeA4sT6FEyTtX9VYr/zDN+vFo89PK0cv
         LDEkOI4mHp+70tERweK1zOS7YKQjPGR8QJl1L4i2X94E3t3FClsMKEM1a5kiF8gR0SH0
         XJmlxYfBfumNbQJR46BlodhBe6j9ih3/FwP32AN3/3JiHl6YUmMXoL+zd2EBIOM4/Q0W
         iAUQ==
X-Gm-Message-State: AOAM530sVSIKBZ2jSwGW4mM9rXaxAiEM6vKVk6A0KJU7pKEJQr2asXK+
        uZu7StY+AL/IN+tYu1DSI/k=
X-Google-Smtp-Source: ABdhPJzdJZoet8YrveJZMZLKOMbwqZq3fBvLQfMtUR5sfO2eaynxc4W5vBYBmoQ/oCWVMKq8HBUHgw==
X-Received: by 2002:a1c:9d51:: with SMTP id g78mr15932198wme.5.1616410186477;
        Mon, 22 Mar 2021 03:49:46 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id o11sm19116627wrq.74.2021.03.22.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:49:43 -0700 (PDT)
Date:   Mon, 22 Mar 2021 11:50:01 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: imx-tpm: Use a single line for error message
Message-ID: <YFh2WUixZQceHtew@orome.fritz.box>
References: <20210304024242.2363294-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eU/2tv9nGGjlGHFW"
Content-Disposition: inline
In-Reply-To: <20210304024242.2363294-1-festevam@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--eU/2tv9nGGjlGHFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 03, 2021 at 11:42:42PM -0300, Fabio Estevam wrote:
> There is no need to split the dev_err() call in three lines.
>=20
> Use a single line to improve readability.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/pwm/pwm-imx-tpm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry

--eU/2tv9nGGjlGHFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYdlgACgkQ3SOs138+
s6ESag//Rnwh2pnquszEmN8MX7lTDpvGzL9A3tCnOW8oppw1gyfmcjxAPGIggWZj
uMxT8jmmSObgxUMC4omv8LQuJSB4GXcTDGAGlfJt6rG5JONizV4OwLVB/FoO4FAh
r585AujxRL0w8w9suQHfd+7/SyH8JWTg4QYABPaqbaAI/vBhtSzBWx8bY4iQ4BPX
J3L7pM19SfZza+qK/LBZECumeFE1hhIqEYytcdZOv9N5ziD1Ii+1I0iiyH4hkUYY
CgbEsMrL9A89yKP5gw5OavwwAAABz1/pUiI+J9dYqcJ3kF1aozH3zdfebWTbn6U2
FI84sqYWpIQJ3S7f+3MrMIuVGSSBFQf2YGfo7i1MsvUWEGJlQK2BxADwXtddLA5D
xhoTcWP1WEmUYreJ+LcZlDy9YGGWqeaf6topAyBzcnfKxC51tZ0G8dx2T+DxU4f6
ZpFcRqKU3PhNpWVXrQ1n1429K8pcbcWfdUjU3/BLngf2lbKOrBD39oYg8AY6yXQu
FeEjVIPBvCbHAQi+RYomStTjV5lZ2sL7vSHu4gBjy4cYbba2DJZm2cJeMQURB26t
fB2MHOd+YYk/TnfUGnnxcEiiwfHYg4UCLdBJTbuyU/biONEmqSVhQ/VlcGdYoCvD
VXHNCWLyFIjpN5wQW1+SfggX75x7JgwktHed+LsTgzALVsZ74o8=
=IHBM
-----END PGP SIGNATURE-----

--eU/2tv9nGGjlGHFW--
