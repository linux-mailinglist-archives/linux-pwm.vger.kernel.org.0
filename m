Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32AC273EA1
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Sep 2020 11:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIVJhc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Sep 2020 05:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIVJhb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 22 Sep 2020 05:37:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A79F320C09;
        Tue, 22 Sep 2020 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600767451;
        bh=fHtEteBsD0utS+5Z4pAiitprR0KWEh/ch/SvniGloaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSAYlWDaOIl/yKeumXTxuJFUA578UlndAMW7YZFdRBlg2TcN1VLRMkkxHu5B8UBZh
         vG8i+3zaJleLgaqR9y3jEothnNvma2k8YnZgj2cEgkrH2TUsPHWRjXCiX/eSydzVW9
         S1xBIUc319XXKE/pRx5GZuyEpoz1eZHVwsk66+ro=
Date:   Tue, 22 Sep 2020 10:36:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Jonathan Cameron <jic23@kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: move Milo Kim to credits
Message-ID: <20200922093637.GK4792@sirena.org.uk>
References: <20200921210233.21449-1-krzk@kernel.org>
 <20200921210610.GA5338@amd>
 <CAJKOXPdwQc86H-S=C4v_1VCbd7RhC2Soepj_2LqG1e_E_bgAug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fLj60tP2PZ34xyqD"
Content-Disposition: inline
In-Reply-To: <CAJKOXPdwQc86H-S=C4v_1VCbd7RhC2Soepj_2LqG1e_E_bgAug@mail.gmail.com>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fLj60tP2PZ34xyqD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 09:08:37AM +0200, Krzysztof Kozlowski wrote:
> On Mon, 21 Sep 2020 at 23:06, Pavel Machek <pavel@ucw.cz> wrote:

> > I believe normal way would be to mark the entries "orphaned", not to
> > drop them altogether. Plus, I believe someone from TI is likely to
> > step up.

> These are entries for specific drivers so they are covered by the
> subsystem maintainers. You believe someone will step up, I believe if
> these were important for TI, they would find the person some time ago,
> so the emails won't bounce... This was similar with BQ chargers where

It's fairly common for mobile parts to get dropped relatively quickly as
the technology moves fairly quickly in that market, I think a lot of teh
parts that Milo was working on were mobile ones.

--fLj60tP2PZ34xyqD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9pxaUACgkQJNaLcl1U
h9A8jgf/XwLmQCXqZi5d6aBUz5PAPdLGA5vnKQNpz0j7xmPhp7r6AFolVSpZjpv+
OR988o11WmSsyfe5qZyZpyF+XpudRx6dEJn20LSVy6ljt79fiofT8KiEnsUVFOMQ
YnHce9WMKartib/dSshAafpmpEMqdE32At6GsymdPjMaolh1ziq/tek/q3i8vbP0
+4t1TFHElfhwvY0p97fBY0PGrlYaFXX8N2vLciXSPP1gqGPXi6MXP9RKgEx0Ctd7
OpLmehc0nogMoHz0zx5Jz15eoG1hgGKhsBX/igQzrGkDBW3qX1/kRpwBUcjhx8xv
WiSF/GE4ac5w5JnVvhAdamxUJDVtKQ==
=Gqfl
-----END PGP SIGNATURE-----

--fLj60tP2PZ34xyqD--
