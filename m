Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5562757B0
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 14:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIWMIE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 08:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgIWMID (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 08:08:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BDCC0613CE
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2020 05:08:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so6912983wme.0
        for <linux-pwm@vger.kernel.org>; Wed, 23 Sep 2020 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXF8/TRX8AzJd09lrb0ScAnjPKwtmOIDw+ufXXFf9X8=;
        b=m9OENKNlaV12tgpN53fgnQUTyOfWxfgtT7tWUbnDNXESkoT2MXnHONUvjIw2FqX4Zf
         tWZ3VkSIFBRjPxvLcmoD1c41IGAS4OxsuvbUuRmDorzrdZs6zp5xaKZr9bFMuSQBggZT
         0IZIUZrWjrXwJDN82u/reo+G25YBK+PttC1TBWTT/X5b04dY5jOvsEkwDsUHa8/aIQlV
         dV/chTd3XjslMoykLoexj3wcJ5JHJEB+A8UwgAkYzkoSNhaI14VYifgqcgc1H8cIy4eE
         x0rQPPAcQJh8VRElZQhB6wd2F9ZWYpEPoOofhiB5zq6aUnJC8NXsY1+x1rM6++ryNGxB
         Lf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXF8/TRX8AzJd09lrb0ScAnjPKwtmOIDw+ufXXFf9X8=;
        b=LEqPiLlgYLF84P+ZHlAjdxRLf4y6eZTWL+wE6Fjn29zdFufrsAoPCOW/A8vL+yU24M
         ixyxuBT3CxOXaeoRYR5Sj1+Pzak6AW0zawZB9chEgDcx/G44ez/r3Q9nzet+9RK6Oqcz
         7v1iNYfDT/4b1bevlBcJVtkaVaE7ne14hIGf4g6aqAEih08NlkNhC7i7mgfcL6bt86BD
         1OG4jg1julgn+5OLv1zLFh/Ysm/+FUctt52GsxzJEensrW+R9w7YUG129PaKWdnN/s2X
         2ilsu3xMGxUuJsBFX0hdAGF7+OqOVaVMq8XeyXTUnp0mXi1qypwm0ccGKQ40lZuDIV3T
         rEHQ==
X-Gm-Message-State: AOAM532l3t7b9uvPmmiC5K+kIbgt1un+Ct9dfKoswqVFD5jYuv5OFktM
        arCjTSgZKMWs8s0hzbrf1xhRghfWARQ=
X-Google-Smtp-Source: ABdhPJyFyNwymYKFz8HsgQ6cevd2Nx/jUIhfJ3+46UjpdWP/bvTXrqlRSPo1o8iAFFkd1uzZwxBFAQ==
X-Received: by 2002:a05:600c:2312:: with SMTP id 18mr6043399wmo.141.1600862881597;
        Wed, 23 Sep 2020 05:08:01 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id q186sm8157968wma.45.2020.09.23.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 05:08:00 -0700 (PDT)
Date:   Wed, 23 Sep 2020 14:07:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     David Jander <david@protonic.nl>
Cc:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 0/3] pwm: pwm-pca9685 Disable unused alternative
 addresses
Message-ID: <20200923120758.GA1848911@ulmo>
References: <20200828121415.1292388-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20200828121415.1292388-1-david@protonic.nl>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2020 at 02:14:12PM +0200, David Jander wrote:
> changes since v2:
> - Extra patch: Make comments more consisent
> - Extra patch: Use BIT() macro instead of shift
> - Fix typo in commit message
>=20
> David Jander (3):
>   drivers: pwm: pwm-pcs9685.c: Make comments more consistent
>   drivers: pwm: pwm-pca9685.c: Use BIT() macro instead of shift
>   drivers: pwm: pwm-pca9685.c: Disable unused alternative addresses
>=20
>  drivers/pwm/pwm-pca9685.c | 45 +++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 18 deletions(-)

I know that you and Uwe disagreed on some aspects of this, but I don't
care much either way and the net result here is positive, so I've
applied these.

Thanks,
Thierry

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rOp4ACgkQ3SOs138+
s6HxWBAAgCkJvLUasga9LpTWZcSa6IoYw1jCUxWqze/mj/6UGQHY77l3HyStsKvt
WZlSBUNax5dNqDMthakMatYk179YdEcxPiVLIa5wQL6ZfjQrNz51no0Rga0+PJZg
3KP82a+s5aKUVRF46M5oVF0Dv7z0ajBFpebz98Xfzm/ugoiSYNulFeW5lhX4QNNi
i7rTPyGbrBM/AvQOBxSVTou7L6aSOcO8pYqztFSkSPQ4thhgDK0kB3AXrCBbZ5H8
WBf+Gcc/Pe/jSvgfACE6XSCa+MxHaIWUtJSVBfPiOC5U80+wGnmVMlnPpn4ivVmx
q+12a3EENXJcwmYhrOKwycHxzsijWe7aNUOPxwNv/h4sGC8CSDrnTnc6OXqnvU2K
9JZt48gr6ZjgjT9arIKOTLANCt/c59JdtU3dIRVsTIoLqe23AMvOFUOObVd2uVz1
VruZw/JkNjwi7xPjv4sa1iqEgl+GnmLVrpyqNTeIfJawZNkMu3hb1XVBJHVBzCXC
vpkIqV5UMcG7SWhU/z1kgFepZZUgovzXkIHLtmmtDhsbDfB4KHQrJV5mKJrSJjXp
llXMqYClWHwxjXCrd8w9XOxp7Q96ADmjVPSVmST14t+CLDSLiU2IDu4hMdovn1ZQ
w0QlfPoYTotXlY2bTYPOhnkMHV3xUsQfwEkmRmvfOlLWhyYr2tE=
=0IXW
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
