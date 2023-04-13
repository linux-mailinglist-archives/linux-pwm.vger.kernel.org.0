Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5A36E0A4B
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDMJcM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMJcL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 05:32:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC349FE
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:32:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z9so8813111ejx.11
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681378329; x=1683970329;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21evVuhyy1RqGHUkda4MPxtFLawJeUZIbx48yqrU5ic=;
        b=b5YQrsKiilUxOBVWz8nCr9oQD+cw99I7pMfUu60IyIUmgGwynj3fNdyGmSI5qKkS3b
         JJRpyCoKGBcwgmTzgOw5Qg/XJBXcDiUb3wS66/DZ4odKOti+vBLdxU1pVFr+7jVlR9JN
         4mQm9+5JX+qxNi/wcvQi81hTDyxp2xunHgo03TvxeEgvEYLGR3BuR3g08XCJ+2SHgsS3
         CoXrlEDvi+vrctZclEzDR7WJkOpPwRMKkkW8L/pcsoFE4Lc6cUpzgJJX9vg2DXrCWo+G
         wPqIzDlzMxUZDmUyTzceHAOXzY2H+9HelU3BC2q2oIGbiNYYxHkENqnz1Oi7rkbVLbKB
         EU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681378329; x=1683970329;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21evVuhyy1RqGHUkda4MPxtFLawJeUZIbx48yqrU5ic=;
        b=WsliuS8E3uTyRLrvjd9HewcBm7HPTRAv2spkmwbbqFEE1JQSMYlGmqZ7Uy5XTrQyMH
         bQRBBu2q7nic9iv1LtPgUHqpmUOvxpG5b/M/tlQZp1TnunpyUWijh3jwDVSwFICCCG2A
         tbhtKt3rTu3zkgfzhCOzh1U1eRQSDHA+AX8OdJNq4ELjiAAyqkXUB+N23Py6BB9rIFBG
         f38mu5KWFz4uTDwiUaAIAHc8Plh+1U+4brWHkKQoLoC4OoXp15LpCNjEn+XAI3VXEa0L
         Iv/8v3Um+ISoRCnkL0hrFEf+ifC6luoyICyU9QJZ0KqXU4Wp0JK3FssOkjO0hFF/grVl
         aKjA==
X-Gm-Message-State: AAQBX9edMWp77k9z7yvUs5K9D7mvTdlXGlF92kCW2aBZ+H7u3uOFhoEx
        m0t+g79lUp8hLQR2Yfx/DiUGpBO7r5E=
X-Google-Smtp-Source: AKy350ZnXgjpRa+umLhleYktpaQDFvc7ydkMapkaiuzozMND2mokSFf1+0kngYG2X4B1HEgxDWBL0A==
X-Received: by 2002:a17:906:69cd:b0:94a:a29e:b71b with SMTP id g13-20020a17090669cd00b0094aa29eb71bmr2182691ejs.12.1681378328991;
        Thu, 13 Apr 2023 02:32:08 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906c18800b0094e877ec197sm702872ejz.148.2023.04.13.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:32:08 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:32:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Delete deprecated functions pwm_request() and
 pwm_free()
Message-ID: <ZDfMF3wAfbd-1y-Z@orome>
References: <20230412115636.3533366-1-u.kleine-koenig@pengutronix.de>
 <ZDfLyP5bP0PdBS1J@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4ZJ1a49jNboAXpJ"
Content-Disposition: inline
In-Reply-To: <ZDfLyP5bP0PdBS1J@orome>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--T4ZJ1a49jNboAXpJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 11:30:48AM +0200, Thierry Reding wrote:
> On Wed, Apr 12, 2023 at 01:56:36PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Since commit 5a7fbe452ad9 ("backlight: pwm_bl: Drop support for legacy =
PWM
> > probing") the last user of pwm_request() and pwm_free() is gone. So rem=
ove
> > these functions that were deprecated over 10 years ago in commit
> > 8138d2ddbcca ("pwm: Add table-based lookup for static mappings").
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  Documentation/driver-api/pwm.rst | 13 ++++-----
> >  drivers/pwm/core.c               | 49 --------------------------------
> >  include/linux/pwm.h              | 13 ---------
> >  3 files changed, 5 insertions(+), 70 deletions(-)
>=20
> There seem to be two more occurrences of pwm_free() in
> drivers/pwm/core.c, but I think they can trivially be replaced by
> pwm_put(). I can do that while applying, but let me know if you don't
> agree.

I also get warnings about pwm_to_device() now being unused, so I'll
remove that one along with these.

Thierry

--T4ZJ1a49jNboAXpJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ3zBcACgkQ3SOs138+
s6H7Fw//dX7t8PppuJ+6qwMrTVvMdw4j2pPmq2cOnLK+Y924TPRt85hu1REJDQs+
3fQg18kel8kHmVlYkFy+jv7AWCB0Tl+4EnvsD6iwAodr6DYGaoZrj6/0qpDO6ok7
JgoT4Gi8qVHAkP3UZK7pVYF78WdvYARuEAW4geCcfqkUO1CTVtkgS8xXRihJca4Y
a8D07Kna+hTJsleqSqVDAfT5X5Bjg+4/hGlH7H2MRXoe19toULOgwwfm9FGcb+lZ
XqhS2NluL14XYwU35MJx7Nv3U4u8a6f9gewwTmQofX3bOmWwa2lSSjpmIkdhMmFr
Rs9JC+2YYX2tdj4trkpcvyMIqze7tj5zR1kOMJY2hkF/kN/AKKjeLampjDTSgRA/
yZnP/e0GsxsByqbdF1XKbUA/dBdzTrdN2xiMJPcJj1N+KL/OK3n+QVHarahJ83X9
KbLfZWRu+GIcE/qWUepftFZiQpDAx/OHSpsuw6CFdTKAbDN0pH99Ben+A1TCxzGW
WvN0/R94C5d3RE+2UFptaMXkNSUmYD9OabxHVJX1aYLunHZOUJ8QhdfXk9WHNlOa
VychLonyEOfkii9son/IvMrZyBkj7K5bzSpru964q4HIo7BHU495qh8xPsmmr3uw
e2oZPQkQgKryKir6E51jhgJQwWEtDluTJcBydKtFEkRfhEGogj0=
=ieR0
-----END PGP SIGNATURE-----

--T4ZJ1a49jNboAXpJ--
