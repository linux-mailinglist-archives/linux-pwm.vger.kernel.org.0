Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3CA2AF94E
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 20:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgKKTwJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 14:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKKTwI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 14:52:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD9EC0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:52:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so3703796wrl.7
        for <linux-pwm@vger.kernel.org>; Wed, 11 Nov 2020 11:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0CEVbgcEb6znin8PKQ3gxGA5e2fPuHQ7vASdAikahrU=;
        b=BbGZD0dzqu7w5DeX8/yF1QUWEfb1uDBIq6rrrNW2tyrYbPCxkTCaCnPlgp82FfW5pS
         aQhsXMbM2b9n44Ui5s5keSGulBLfHaxIU2YlSqRt2WieGYfd4zX4d7i9iFtlmBqT/lUS
         FzzIM7fJz5G2SMHKwrFMmZ/tfpnOIddd+la5jM7TKPZxMAusNRxTjxZQ1N3jy+JBGSgf
         n3iFm0N0y868lYHz8e7JaQc3k/IbjD3xlivJU1eu2wz/H7oqaNyKXX9ZD3twP5ooPu8f
         yMLfNNtb8wVNoJ2/9qjv+1xS7VnNDe3CVL3aHqmsnylGEInKHAhl71ewirHnU+YQ4yzN
         TGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0CEVbgcEb6znin8PKQ3gxGA5e2fPuHQ7vASdAikahrU=;
        b=f1JK159Gi6zGC8rxJKB+HNn4X7KHh/5/PV5IhzFCcbNDe5OvABrc98aTpSi7onGakr
         GZf1EOnaK7g15m6ffQo/dAQJedObjrAWgDMFn98ZI+5VmiqRDZuGcW8D6QJjDOpSJ//z
         TW+YZJIb+ihwXxz5OhpfjTGQBJplo0apc5Fsm19b0W5JW0R1FKIrVk45ICzHbVPp4SK9
         fsbecY10DSt1uot095HBuO78yibSXdo3h+pCfVSjUzvgnhwavO5NB+W/CKIUDkGSC0AA
         G+TKXxf4vGq4tE4Anf37RXB77iEIuWCONZRryKR8lnolUdvjye6phRQ7Hyi/w1tqR8ia
         whKg==
X-Gm-Message-State: AOAM5322ZZoIN1Fe/RqsJXvGSuCpWUySp3nAXoZfH7vzE7tnddEoaXU/
        EpU1vivad/4TBuSvc+sdVQI=
X-Google-Smtp-Source: ABdhPJzPBgfcwFVciePgvw/UBA2kHfVjbiELP5C8L3Wfgw3NsA5w8ZRz6fpBrxtoXDfe6aFhBKQljw==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr30703719wre.282.1605124327272;
        Wed, 11 Nov 2020 11:52:07 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id h81sm3759019wmf.44.2020.11.11.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:52:05 -0800 (PST)
Date:   Wed, 11 Nov 2020 20:52:04 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sti: fix error handling
Message-ID: <20201111195204.GE6125@ulmo>
References: <20201013081531.661528-1-uwe@kleine-koenig.org>
 <20201106082914.GX4488@dell>
 <20201106093435.4mlr6ujivvkzkd5z@pengutronix.de>
 <20201106102908.GC2063125@dell>
 <20201111192823.GD6125@ulmo>
 <0d9adfa9-9015-c8c5-c21a-f4ad9b1ef7a9@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline
In-Reply-To: <0d9adfa9-9015-c8c5-c21a-f4ad9b1ef7a9@kleine-koenig.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 08:43:18PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On 11/11/20 8:28 PM, Thierry Reding wrote:
> > I agree with Lee on this one, so I've applied the patch and touched up
> > the label names while at it.
>=20
> Have you tried to follow my reasoning?

Yes I did, and I happen to disagree.

>                                        I consider it irritating that you
> overrule the preference I justified in such detail by applying a patch wi=
th
> me as author and the error handling variant I opposed to.

Well, it was either this or have you respin the patch. I didn't think
you'd mind, so I did that work myself but still wanted to credit you for
fixing this in the first place (the names of the labels really don't
mean much for authorship in my opinion).

If you prefer I can just remove the patch and you can do this yourself.

Thierry

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sQOEACgkQ3SOs138+
s6GjXBAAiIPfg89FZrnBbAC7pps3+aN73Skmdp8SSLKHGto7Jc7SnqQ9m6mpvJvK
uS04cftHPSW2VXIWkyzrzl1O7+r8PdMY/WoPK4nmTzRYypLtDAUHH2oY2fdR2pYa
nivCfaEE1i+tCtqrGkA6WVImzV9emkgxoIVlqkNTwZ6v4azYpQMQgOQB57j388Fe
4rU29o818UwqDkGTOWr4NYTjS6TrWSLxytn9QTyP/k/V2873fBvI3v/tGNEX+xnt
lQ/xOZfp0r5zLD1MqFmkY3qHPlR7+ydOMNqM9pGLAzSbt5wpax2IHWnMiPQJFkCT
Gck6MivNKoKFVPh8stSQRV21ptjfxbqLUq2k8qeU73DUo/HaiWKxP8sCQFJM3asQ
BATpXfblKK+Od4KgOI1vI8WQd+uoW285PBCuQCu2xr9aA5/SX6uo9/6qRM1PN28m
gi5C2OABeDs9lQ67zg46z33jyC6ep18jhj0T/6YUeIXoa/8UxI5pLi8OxIAc4I+C
T45O6h+qOp/e4kZZHKt0mw191snKULNucnzJjvdV495+N/QVoGrW7Ltc9Z8Vem80
bHKJRJCcotV3hbw+Uj6IQxIHLwmuOYbsIGcROPm/baksArD7Daqkm1OVe5gIm7o8
5Ete3PFteACD3EDr8lxOuOYYt97o115a1e5IT2owOvwX2cbWTkg=
=L1R8
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
