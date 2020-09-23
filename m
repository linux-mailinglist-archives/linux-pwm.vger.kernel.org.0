Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0B2757A0
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 13:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIWL7g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgIWL7f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 07:59:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E21C0613CE;
        Wed, 23 Sep 2020 04:59:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v12so4999399wmh.3;
        Wed, 23 Sep 2020 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y2NQ1AYl2U+eenm019Mygt4DQape7KVEjWmPGv5J+hQ=;
        b=ARrwxp/EvpFennextbTuyMmrgy6/BDoYbHgCbm3CkP8fV7xPHQgTuJTu9TZTRHaECN
         kSDgXf/jUFTn2Ebe/lGUs5+/JP0HQbIYrQxO9d/+qVFf2nijVDg8A+xo1jKUsDa2IdXo
         ql8S3RVvqqSx+2RUc7lWhxnRB92CCT1qJU4UZS1VxCJ+ayBbLTeWi8jiU/D3mjJEnoYo
         vYH4q4eUURxyt1nyWUMMlKmXlC4Uo/3dngH5/dWiFjjP1UnDUzqWaXjiZWCMoElNgTFL
         rXl82HYN4WN/ebQD0uHrfVLzmeHF3mEW0LvjUqZ01v5twW1I46FGpdHe3klHCREu5tLt
         vhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y2NQ1AYl2U+eenm019Mygt4DQape7KVEjWmPGv5J+hQ=;
        b=VSpl1JO93jJbhImOQYy+VRv/h04dlsgAdfCw0V2mH4mdDIG/lrSEMvUAIabIX6UqZP
         t3ntMdEYPg6UyPtRBF0fZgnvBjmSNNhcJKPQvbJfgnZ20GbeqRZBFuAHbBv5KVaUrQM+
         svvZclYxnbsEJlNX36kR8iBuDPJbfor5HfJqint7bhEtDj69SkOih9TghKAPYzGMHIXG
         V+HN26vB88263jG2ezeOYkUSkFoYRNOZscjKhm8YabBJnh8z1UPk7OrAP/9I7ZhKfHf/
         OiVSfXfbDnD/z8Zj7m4y9D9s81xlGmkMxZan17U620zZGh042RFEoANEiPIv7IHEZp8L
         36cg==
X-Gm-Message-State: AOAM533DjGXC/aY1E3cR3OTHdO6n/1GQxdHrOKFLSUXukqsg2MqFmLBT
        2npqtKNEBaqyEqKsw+rzbH5UhTybUiI=
X-Google-Smtp-Source: ABdhPJyayR/8k8J9eshWCConpaQjDUFneXPjQXKfZvImZ69fZG8Su03anQQnX7xjqPwhWVNwxg94OA==
X-Received: by 2002:a05:600c:24d:: with SMTP id 13mr6306216wmj.86.1600862374266;
        Wed, 23 Sep 2020 04:59:34 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id g14sm30908929wrv.25.2020.09.23.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 04:59:32 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:59:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/6] pwm: bcm2835: Simplify with dev_err_probe()
Message-ID: <20200923115931.GF1846003@ulmo>
References: <20200826144747.9436-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
In-Reply-To: <20200826144747.9436-1-krzk@kernel.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 04:47:42PM +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pwm/pwm-bcm2835.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9rOKMACgkQ3SOs138+
s6GgPg/7BTuN809cHB+fehAxKkk9YqrzQXNml4ColBa9N0pyvNfBUayKPgG2s7bW
CeDsCXXtXRTH/3lGghEeZt+I+yOfdyWxYoSv9d7HMjCyhSOhHMaMwQxqbBoKHmbP
7kq1TQxkBQxWCwlZhV8rbN1/sBy7CEBGdCL1/4qRlK7fJjiE0Ni6wwZVl8SIJf8r
PJyg3lbJ5C6kho5d8WpxJTQMtw7mZg/U6DN4OgjeG1g5IvUfuHKefahZL57gMDYC
JAGHCN2nrkZMup/LZCbxJLeQgu/bpHJN4IGOi0brfHn2bcRIaHmtdf+FAOkKoMsC
DYv48i1s1IxSpLspq/btXps+N2cCaeImLU/Dj5dI0m2hqZiAG5m9BEkffdgsVFdm
GRAZqQBuDL3mXrAMXH7EA96WplUO9EXDmacK/g7S6p2j3J5JjFT5vz4DP0HYotL5
Q3+yPhN6Xu/eW0toYfTFwjBBXSH1R6HDWpLqXfAw+knB3mEhnml0t+6UzT+ve75e
GyQ2vKwowHXdwTKD97sOM6qojc4BSO8N/OMv5+Uwv+EHjExc21RHiRw3tcX2O5XS
JrDVfZnJXWZ4NuzpTqh9vQ+0D+gdGEFotWZEkCGtMMYFKSEuNg1KM0dhctnhwz2h
laaj5jZFqI4+L0V338bCt44pjr3uWAcNgP3cGSJAzsK3MXmzlSw=
=eTBT
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
