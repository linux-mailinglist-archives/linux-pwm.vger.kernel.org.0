Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A93B19DEA7
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Apr 2020 21:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgDCToA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Apr 2020 15:44:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37171 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgDCToA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 15:44:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so9951159wrm.4;
        Fri, 03 Apr 2020 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VhUPoyVgqk+qZ+YSwj2U46k0fdPCJ/w50hKlV2MbuGw=;
        b=hhCWiye00MTANqJ6nW6EucLK2InoA2Rw9jqmk6Eomp3msE5cBzOiPJKNPNgkakOWcO
         Z6f/R3hrlu1FnKAFAWctSyIbwGP/3UY2S49ylYYbhpawrvKdhWo7A5MKz5NSDJw7S7qx
         CvPcHUyXe5CGhNL6Klqth1Tvr/rSCXvxtdP7V8gs18cWzJUKxRqFZgsTcvUrGa101MiX
         Wh/UZWF6d/nAp2SOQSZZiXMcOVCQyJpPeDD61ciT/5NG19tOnB3ON2F9gMaPDbK2SPfj
         r06WUI39IRPKPVu8DC2ulgBfZK+ZYwNVO48k0dwWfxg30DTmdiGgO7reYnaTf/8iCo5g
         AwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VhUPoyVgqk+qZ+YSwj2U46k0fdPCJ/w50hKlV2MbuGw=;
        b=n2d5PhflCTksauG6UPC6/b907XfEypSCwq5bBM19oiuj0SYNsnBfft7Bk1OKAy3NYP
         AKt8zjpmaPaWDAcaM9MPcNxBJF8IZLMAoHtaTqDIjW+JDkFfmDGTmLmLqay1FKsNmeFs
         TUr8v5ra3+fxLjZsuRxNpP0m8tRG4x/JkM6gneeveLhX6aggNtOkGLj8xmHqC08bqeZl
         vV53bo/OURJHpMGfIccG/4Y3YWFD+DmiX2UbN+xA7oWuMD67aK2iXlVvNMIFwaWW91h7
         SjVFwqGRE0qiNXQYETvXIqXm1hFPz1n4RyTReocYlXSNk7gnbRe6CKMHOmVga4FAH2AP
         4NKQ==
X-Gm-Message-State: AGi0PuaLWJmPoa2tyogIYecn65zSdO/yiMgI9IZp/hb+XDa2UbIPTN9k
        oAtOy+y2PJ6zC3Wbo5NxDYU=
X-Google-Smtp-Source: APiQypKVRLjP5+xoPXsNXQUo2denoGstY9cptKeS0GbRKSrXlZZWW7kTNIWA3fDVCRT683g5iO2nZg==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr10231570wrr.377.1585943037972;
        Fri, 03 Apr 2020 12:43:57 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id a13sm13077687wrh.80.2020.04.03.12.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 12:43:56 -0700 (PDT)
Date:   Fri, 3 Apr 2020 21:43:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: meson: remove redundant assignment to variable
 fin_freq
Message-ID: <20200403194355.GB201060@ulmo>
References: <20200402110857.509844-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20200402110857.509844-1-colin.king@canonical.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 12:08:57PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable fin_freq is being initialized with a value that is never
> read and it is being updated later with a new value. The initialization
> is redundant and can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pwm/pwm-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6HkfsACgkQ3SOs138+
s6HHhg//ZVsyNF1NKEv48QDcFr5adCAieVaCKk7J+kqjK7w2X2fnDrjuWXbmtlpb
drMho5uh8b597B5cDcFoprjQSeHl0D56JKiLgBYsBuBxeRsFcVUVS5zXxt8mlvFc
AIGKEPSSZsg+LFqlR5Msxf58M4YGYvG3lbFFQUOEN0I5K6W3wvfRY0+xGUvL0TC+
1kOy5HmhM8lFPv5h/zgs0biiFg32D5ghmaLduZN9VjUJLgPmnlR3nESaWbjiFdZv
XjGDkXPwx9+tJML2TzROxMWcBFFx7zBDfxHBvRfovv272QzMtpb7eT73Fh/cZSKQ
hMCslpZy5Vj/2HcHkRY/w1MN/NZAdX/mNhQaIw1gz2P30mJxvUUDOoOaAGk3k8p6
K2fUxY6YMthq7T731bAhROz1gxt4Ra0IMVksfAUSjBvHduIvOjikBJqTu+5TKIe3
FnXfzaOODWL9+DQwHZtYJIRv4z21DfPFJunzohcsHKptPf1AqMW1BJX+4XX5rIbn
dl0WS2h5BZ3lf/OU4FqXE6c9rKEj8NIZAYoYHTX1yDdQSI2G5GtFO811eGsN7h2C
uVtwi5Jj2Js8rSxFQDj4d/jIKpxppzOvTGEXl1/Xz5XzMwD4TBl7ILKFryCnYCN5
L6Y59GbxDRXjBGJuVj3HhV1bFnBcVqSFz5swfsnvXCMTNKp0wlk=
=9i9z
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
