Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F8F2AF9BF
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Nov 2020 21:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgKKU2m (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Nov 2020 15:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKU2l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 15:28:41 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5A9C0613D1;
        Wed, 11 Nov 2020 12:28:41 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so3753644wrc.11;
        Wed, 11 Nov 2020 12:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dq1iKAU2y96x/XQs698772mOxdQZDghPuWoC8s03/bw=;
        b=Vee6Azj3MPC+lNFGsKyyzJX6KXFIYdm6N09bdx7crsRVNDUfilZNN5wmgMv+Gkf5im
         GA8cQnzHNBLG9FdPOg/FmfG756jZrnd6UQRudC6L2/krFmDxhGOXyIo9Ngm1qZmvfsBO
         5pUjqgNa/9C4+ZuI/gBrqGhyOJwGWJvn5UxINyg+341mT00DRfPLpZ9lz+QB0gnKwwD1
         MvhqjhWfcej7XHHfGPQZluNtXycTK0BpL5r6pg5CnJphHfRyMzlanaHEH8zSzOlqJszP
         qczNOgYGlluk/YVMZB0KTm+QKuFSxkI1xHfkjGFoMBi0XIupJr5C4bltNS7tjSDUczuf
         fgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dq1iKAU2y96x/XQs698772mOxdQZDghPuWoC8s03/bw=;
        b=Srn2OQpuJDIew6ABFUFSjdAfQxdPiWDFHoIUas9oluAQfyR5Hy43Sv9taj6HFGgay3
         1/YBhMa6z5exgR/IfdTW2yW42THG/z3X4mLIaErpQZuPahQyEjfy8b7j0KKsiJ+ar5IZ
         vsNY/wYMp+A8xul7tDqsYbwgEgSXXj2TyhIOtMiTJqLfS3TeWMtgrib2q6LrNhcS9ZOx
         5ugmzop075R3tM0KeNkUqyYADDXhA2kDK2gHgfdVT247U8uLflwavnh7630hVFiGbAtp
         LM99UTipYUSi2uNzS3MGT+3+S2zs6E2Cv73To9/b2R1IjWKcTtVoB2s/PDUn2+pKLoa4
         0LaA==
X-Gm-Message-State: AOAM530qbs7n5bQyJlfNG1OrSCDH+YesRJlgMKcSs8NgQeOMvXECNKmc
        FNPgtL6DeJAGOCQ/MxJ5DDE=
X-Google-Smtp-Source: ABdhPJzZrzzs5rxl4/NxB5wuaLZ+aEAbGVJRfd52NF6xI7d+W7/8g+JKGdkLEqeHfMN2QRHRdyZnlA==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr33910986wrn.56.1605126520242;
        Wed, 11 Nov 2020 12:28:40 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id h15sm3763351wrw.15.2020.11.11.12.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:28:39 -0800 (PST)
Date:   Wed, 11 Nov 2020 21:28:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH] dt-bindings: pwm: mtk-disp: add MT8167 SoC binding
Message-ID: <20201111202837.GM6125@ulmo>
References: <20201016185015.3371433-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EE8jvUPYYQjJtG7J"
Content-Disposition: inline
In-Reply-To: <20201016185015.3371433-1-fparent@baylibre.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--EE8jvUPYYQjJtG7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 08:50:15PM +0200, Fabien Parent wrote:
> Add binding for MT8167 SoC. The IP is compatible with MT8173.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--EE8jvUPYYQjJtG7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+sSXUACgkQ3SOs138+
s6F1NBAAvrQ2J8Mkjdux185RLd+NOTmlzziiX62GKq88ZnjDlAN1G3GFuigUiz+6
eQYOQQH/eP+vBT9T7g9euUgTkZg+Ve+a4RoAMJp0NrNsjCsAgj2wRqLiKQtxCllA
8dDhgeVcehlHi0DXQvM5LEWNXN+VtBaMx5nrhSsY31xHoAeHVK43zk4ErWH2878w
47S2iWwwyrcPqELQVm7NpfoBY01y0/uA8oL5gKdI7CNGpO3Q81KHDgP5HJW9/FZG
Z+zXAWJae/ACqXSbmh9Yf6t+NrksvyQP09pSb65yl3BkCqks/+UncHzlXMXwHfZ5
d7xQei+anY9Pm5qhxk8EpK+BmiwDqAJ9gV6mGOfIiHCGmqNGRTgQJ7O8354Y4sLC
XFdQzpw+DjsR8iYO1q9tz12mrG+8bFxvdRBKo2B8A1Lb2XlK048NkdD+htGDRQP8
TcOtitlHoNY31csGzrO1Kvm3gPkhx85Fs9kCaOP5KrHu36JCBTXYkcVU3KhXEDzC
MBCasCoSQt3NhAWfXNQtU0PTCLiYJ2L5kDSrIJj45bbNWPn783ot17fscot3KMKL
Unz9peWjuoV7nHj2B6reK4QZr8+Z/6sTQge+wKE0EsIYCChezQ3Df94fL5BNHs7d
EFrd880F0IvUMag3eUJ3Yso8ZDbuQcGiKBdDH125EYGPu+Oj9dQ=
=dTlx
-----END PGP SIGNATURE-----

--EE8jvUPYYQjJtG7J--
