Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC4134338
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2020 14:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgAHNA4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jan 2020 08:00:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39253 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAHNA4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jan 2020 08:00:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so3283644wrt.6;
        Wed, 08 Jan 2020 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8s6MBY17dmKuqB1spd1Y2svCKY1mGBybzjzWrguhdKw=;
        b=gE1Ze7d22HE5Q5vnTBA9TJ3sklMoxYoqc4qi5fHipRECxI0AbbTe7yOGYletjJPSmG
         +ni93Xnu1tzfiZFnXRrNN7/9U4sSHQNRhWB3u0H5/5LgIBx8y6JZ2dvG6K9UzFfeIs+t
         ucmWMwc34F1bCjWif80BBpDX+NigheLltnGLMjReolPZ5SDW/DH4dUm+wUq5r/jUmJ7s
         e2m0AP/4myXBS3YYO7G6r3U33CARN3WLrhMxJEK0ZB3mfe/XXCblny9ZEPEACVa0kLmj
         3U+hwLGgcCpRcrE4b/ohDwhGIOeoYtr9t3UJp9qpLX3nPDKIaslKdYClYnIKHOhib/Rq
         UFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8s6MBY17dmKuqB1spd1Y2svCKY1mGBybzjzWrguhdKw=;
        b=WLRDx7XdT8aISbMtxkGJiGKOLQzF5MLWtzeGKcl0LB0TePAZpkDVsbmQ0Ggm9uiw9i
         QmRAheHtCZYATd1+48okNROIuuPDrts7uad/AR4/JUWzg1VoGKmI/qyE0uQsRi5qnPGG
         6MBst1df5+qg6sJOQzYC0bvDAn5WVLmUA4TvCbjulvGzwE78XZHkjJRGue07r089GQTP
         h9EI7krNuV3XZwlYXkAdK5N8kZlj/WshjYj/XSHJ+fJcJWC/3Mlv0CzjBKa2KCa/WyQ/
         sK9VmxQWG1C3lDkFJOjeJzHA9Hn8fDPUfppXi2RPDlL4gA17WF73vtrGqZPubDfJFohx
         50Og==
X-Gm-Message-State: APjAAAUmgnelRaGlVdwrhxjPtS9t0crHGwc5pU8m7tM3WeenmmvRSpQt
        ObPKcIRGhXdwC7AK69MwIb3zJcd6
X-Google-Smtp-Source: APXvYqyiUk9DjLJLQC9p0jB9yqPCOOzRwx8SecHw6EXXSg6lP6Y/JDhW00O/AZmFm6lHLnBCa9UkDg==
X-Received: by 2002:a05:6000:cf:: with SMTP id q15mr4321652wrx.393.1578488454567;
        Wed, 08 Jan 2020 05:00:54 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id x7sm3931711wrq.41.2020.01.08.05.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 05:00:53 -0800 (PST)
Date:   Wed, 8 Jan 2020 14:00:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: Fix minor Kconfig whitespace issues
Message-ID: <20200108130052.GF1993114@ulmo>
References: <20191230172113.17222-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <20191230172113.17222-1-krzk@kernel.org>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 06:21:12PM +0100, Krzysztof Kozlowski wrote:
> Remove double whitespace after "config" keyword.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pwm/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4V0oQACgkQ3SOs138+
s6GW+RAAqt7l9DVUT1XZy2TgE7UeLRkeCbnVtYRqr1q4kqqjW1uRyRc2gbd6Q15a
Orl53tUGiuE+Fr/t+UpQSLOmsc93zRIqkhbyMdfyTXJRGhzU5UCx2BuBDkelvmZ/
ZcTgvi8IkXRVh7SJx6E2i956iFXifCQQKd/pbS3oPZbUCeRPJuhCTgmfD7NAKvCR
YsaDo4MWHuuulx05CCLeZ+g915YEGXCV5nKr5RdY9/uf1ifS1waeUZK8+C+uwAy6
17J7Ee4+27mydyVzsutgTLAWfnNf3wcwDzbYaR61G4dKZXHWZBlzjq1hAlyfLrfI
Ue9fAv71KPfLULXpotqvoVkzKeTzW5SSnbtsi22wLJfmu5RI2ZCS2gXdRN0Z5f8y
9M59CBmSSOvoQ7b/nBbOCxxlUqZTXGjnlJCXqrqGmomCMQvKZIJBNBILlFoQDDtZ
wCVV+XXEHq3j4qvgsjgkAHLGyxkjmryg6fOFe9mqCGwk1huV5NYbI4aP1xiSCmTt
00wLZMd67PnKuPv1GAgvRW+BLif97N1U7g2OP5ewhYXPj7cd1DVQHsgwbKnKkz1H
UWG3gn+7n3KcstFfKsgS3X8fhKQ2+HalnX9hBfeORhPef5cCtIURILtOU/sS/pvZ
f30UWoLal+Aylqbsc01nUJmxg27i/m0q4+v7waQmAJlE0L+1c6o=
=p5N4
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
