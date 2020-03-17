Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B328188C4A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 18:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgCQRkt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 13:40:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35236 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCQRkt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 13:40:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so6227557wru.2;
        Tue, 17 Mar 2020 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rc0VhOzC+cfi+lRAZOsev4h8V+6Va+aJEr9E8LvZgKM=;
        b=YEGcuymmdA1koXtAzKhxXyAqsGbSjuSF9Gf/r5/tFJpfpAJtl554f4SPyWu4D9aPdV
         U1eo6YunSh38qtdiE2pmwVXCk7x/6E+LUHBUXpj/6NzaBoI3mk9tVxADAX71vbvYYtX7
         66RIYKj036o3dm0SH6DosZE7PZ/n2S2Y8m0QKysF21GALcCvi0vOh0Pf2hIoWCfXWwTb
         2Pik0pZnRjaB8asBt5THZVPIeBbuefcq/q9BC7MrSE4pI7jjJirG6cV4mUfz0eAXK2zr
         PLD9ZOrib1yfSqRJly+eqUh6JGh4Jo7XpIUo0HDdZNjOuWqMXbIYxkDmssiKhtFNCm9E
         dPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rc0VhOzC+cfi+lRAZOsev4h8V+6Va+aJEr9E8LvZgKM=;
        b=BoxjY3N0BLFnavaN1YTRxI+CeEhsvjrLwczr8Ac1bMPb31ztaWedE1G/YU1YP2v9Xo
         5bM4Er6Gp0y0H2Cq3BYlQztgWyw3wind+IF7ZbVtucFmhjjpL0EAHshzu8dyH8OW8Vit
         7jvUsY3NRNdajOoOyZcOL+k5HWXCOQj6Rkc3Kkhq7lM3QaDf8oz3mP1SDwy85Zfao3Eu
         Duomjioze/DouXk0U/YrM4cUYuevo/IaLF44jcqd1sjKTff9ggMicJn6sJQsxt5xG2LT
         k1nyQVXoykTUgHetRhZroe21HspwxQ+bWVHC8jBKj2jRizZncdxnKB4DjyTUq6HtaU1J
         cccQ==
X-Gm-Message-State: ANhLgQ0Up5wmCOAd/lor72ytx4j468Nt3dIUntKDmFwhhwJsSbn2nR66
        h6G56xlggBrSlywscWI+P9KDCeUn
X-Google-Smtp-Source: ADFU+vvJMLEildc7nNypq9mzxdWXUau/bFgKNV+o6iv6Bg9xgKaVE/V2kZVdo5OKLUcxi2q+rfgi8g==
X-Received: by 2002:a5d:69cc:: with SMTP id s12mr161953wrw.20.1584466845960;
        Tue, 17 Mar 2020 10:40:45 -0700 (PDT)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id o4sm5467990wrp.84.2020.03.17.10.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:40:44 -0700 (PDT)
Date:   Tue, 17 Mar 2020 18:40:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <mripard@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ray Jui <rjui@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tony Prisk <linux@prisktech.co.nz>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Message-ID: <20200317174043.GA1464607@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> Rename it to PWM_POLARITY_INVERTED.

It isn't misspelled. "inversed" is a synonym for "inverted". Both
spellings are correct.

And as you noted in the cover letter, there's a conflict between the
macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
in the wrong order you'll get a compile error.

The enum was named this way on purpose to make it separate from the
definition for the DT bindings. Note that DT bindings are an ABI and can
never change, whereas the enum pwm_polarity is part of a Linux internal
API and doesn't have the same restrictions as an ABI.

As far as I'm concerned this is completely unnecessary churn that's
potentially going to come back and bite us, so I see no reason to accept
this.

Thierry

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5xC5cACgkQ3SOs138+
s6Fzrg//W6eAtrfA02CGekiB6CchW1v901SEIXd0i/BUbGhUbBXgNAk0CdFr1oZF
oWh3FArEd2Ugq3qvpgf4UqWlO/2IptBucOUVSwQ5Imuc+eS/JKxC3lriUcpyI519
b5+MI+QPztSa8Nae3cVvDVd1zs+s5QE1J9TOJTINsayE0yxs2QDk7px+T2hP6S5y
fZmxD7DxmhzzTjY9pUb7B8Km/c+g3iLZ2dOrjizHPQ0D6gjni2sAljxJXKBkExBG
nSSO7pOuxA1Koi0/lKAQGtxKl1QbfH5aerdiSj8wi74C4DXTG/yHIU0x4YKpbu1d
C0nSwCafh3P/dIz0ja7iv+8y02HB43gdu9tyA6dlVzIs7UAS/upZfwtLCI49zdOL
Qq28oqgpytPujRWyFSdT7EisrlmqA4TlG6jvndwdhKiurjM98oNob5FiUYz/QebP
cX0mZQFNM8UJjzhu51wkfu3NwtdIBXMWv+EhD8Kh7Ash60aI7LE2HltEC5Y/KqiW
uprdNVNa09YyyZLgE0W1rDU4rsdPw+yxp/XR/vzPWR4eivXlrbPtkBxcZcZfHAmj
Yg13OeYRbxUgR1Jx4vGYyRgV2wSNSyDcwqZ0vU0Z8C4C3qLFNqQPllTPonTSdcnX
gQU9NZOlpo00W4TwrlO7I+3Ww9qNIvnHhMwcaOQGIca6+ZVYyfQ=
=EuQk
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
