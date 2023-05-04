Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209E76F6809
	for <lists+linux-pwm@lfdr.de>; Thu,  4 May 2023 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEDJLn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 May 2023 05:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjEDJLm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 May 2023 05:11:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2188D7
        for <linux-pwm@vger.kernel.org>; Thu,  4 May 2023 02:11:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94a34a14a54so39404366b.1
        for <linux-pwm@vger.kernel.org>; Thu, 04 May 2023 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683191499; x=1685783499;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzY+tEhZTT1946YbGAXGkkoFsY6pCsBdww1YxT+InPI=;
        b=SFex635smGfJWoSDqX2jS5ghlN0boedLXIU6oa4b6FSvXzMena8InathuY1v91YUuq
         5IDTHo1aSb4l9cn62TFT5yFHWWq+OPQ8jh5KszWzQe7OLjDU8NMnBoZjTHD5EfuxO64f
         g2GoeD5PYw0LJ+JgNQyJlpfhbJAJ8VUK4n3vetRPr8hl+DagfVzTpc2tA/JhptDs6D4l
         eFoHWuDGxmvmM84CtBbebnYBLdo01fwBw9QvVUcgnKDiljJhDnORqQLavHE7m/4f2qBY
         GYYPaGe5UmFdODaZvfppbB6fixnNIvoUX8ASf9bmGiPG7vu/PA8TiacYOeD0LHgJgsmd
         7xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683191499; x=1685783499;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzY+tEhZTT1946YbGAXGkkoFsY6pCsBdww1YxT+InPI=;
        b=k3YMgun3r2Jktywtp/dYk9iwi+WxZVgo6eepb9YvUmlz5uOFQS/kdItILXrqL9b0E2
         tvjfHQia2qAU9OTZKp+Aj849cxWaXsfcvepFpmFDQP3OoQb2ZDUQkodXTdnVOQpOjrQM
         mtn/WqTXjludLuawua3as9KneAytm3V7YcFx4VsrPDqDdpY3hYOVGOuQ98ofB8fc7nsv
         rwJSxoCd/yalaPR4nH3rUiHAdeSwXJ8GaTkqss+gRFayKmhfA1bQBsKa7b4O3FGVOakM
         LZ7BNTJSl9iy/dPkLDoPmlz8hdVsvK1t+9mZHHuxisM0u56Jc4UUkosh3/k7Hg09GIvo
         mY9Q==
X-Gm-Message-State: AC+VfDw+j7CLPQZOEJPTZRFFY0L94bwlfl8qIFZ3hvKPe/5EdIN3/5rf
        3BpW5LmAyE24PEEKkjcWvqQ=
X-Google-Smtp-Source: ACHHUZ4EYf52utQ9ujR/C63xdJtoEjL6kKLlava2uDu5f53mm/QWNI0HoHG0tvVIAuNlo1Gcbb3uQw==
X-Received: by 2002:a17:907:a0d:b0:94f:2c22:a7a2 with SMTP id bb13-20020a1709070a0d00b0094f2c22a7a2mr5185265ejc.68.1683191498951;
        Thu, 04 May 2023 02:11:38 -0700 (PDT)
Received: from orome (p200300e41f053a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f05:3a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z22-20020aa7c656000000b004fc01b0aa55sm1662771edr.4.2023.05.04.02.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 02:11:38 -0700 (PDT)
Date:   Thu, 4 May 2023 11:11:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: pwm-meson: remove not needed check in meson_pwm_calc
Message-ID: <ZFN2yNr5GwVwwcHI@orome>
References: <d2aa9fa6-4513-c3e8-493a-3a34d5a1143b@gmail.com>
 <20230504064730.gaguyecx4q7duatk@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g4JdbYF11KDodS+q"
Content-Disposition: inline
In-Reply-To: <20230504064730.gaguyecx4q7duatk@pengutronix.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--g4JdbYF11KDodS+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 08:47:30AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Heiner,
>=20
> On Thu, May 04, 2023 at 07:35:55AM +0200, Heiner Kallweit wrote:
> > duty <=3D period implies that duty_cnt <=3D cnt. We verified before
> > that cnt <=3D 0xffff, therefore we can omit the check here.
> >=20
> > Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> > ---
> > Note: Applies only after "pwm: pwm-meson: fix handling of period/duty i=
f greater than UINT_MAX"
>=20
> Do you know there is git magic to express this that (at least some of)
> the build bots understand? Look at git format-patch's --base option.

I think --base is really only applicable if the base patch is applied to
a well-known tree, otherwise the commit is unknown.

For things like this it's easier to just send them out as a series,
which implies the dependency. Obviously sometimes you get situations
where you send out a patch and only then realize there's cleanup you
can do, so mentioning this is usually enough. Most bots will end up
building this after I apply as well, so we'll get the coverage either
way.

Thierry

--g4JdbYF11KDodS+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmRTdsYACgkQ3SOs138+
s6F2UQ/+OxLFFtZnD6HiEusClT0vy5XRuUAM2Bv3GhE9mtGUCVouAl/k+J9tLHYl
89URmIhbV8ig+S3eL7Vtc3oq/vQjnS7Ln4NrjsvGQKkhKbv5QfZJ+tD7gqhOAIGZ
MTfL1BTCFc5scKDSSN0i/20TNRM8wfYwNO05cgCYmPTdNxxbKe0/iYk2tXsGoeko
BDdxtpJxE5ZdNfXlccZ8Qit/UKKOxDj8ma8zOkflji4oeL80xxP5OPNjajyC7cMH
HAQu8WCzGdUepQ662UQEzSDLldQYOTz4Lalie30Upo5TWrUb+soRCX+qBclNRxxv
ZMWhN4nDieOgb9ADRzkbkzewqXG0QqCfAmaaACocASxMIJm4W+CAjPBCm/lyKC/0
coHdfDZ5tizsISK5txQaUcEUoNdt5nfKVZs5aWM4xnz2Qn0JFrySDCx9wk/Qv+O0
SXG01pMxp5cugQiNzdfJhCY8LAtmWnhp8iZZh8murvye1sZj22nQRlQxqt6Enznr
3Vbv35oCqu/KEqlEnbZWK26GTclNa61Uv1Vd6ixAdvLzH0IsM9HBNGJ5hwkb7sUy
/yR68ED2NU8ncoeEy3BH6ztT7gOPFt21otDfl/YoJ32LClC8FPpRuDHMf+HDJ4ih
wKmACqnxuu5kH7tiSWSPVisZSv/7KRK07SKnTbPHcmZEgeYF+us=
=kpWO
-----END PGP SIGNATURE-----

--g4JdbYF11KDodS+q--
