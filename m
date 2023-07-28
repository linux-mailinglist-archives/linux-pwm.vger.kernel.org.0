Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D231766569
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjG1HeW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjG1HeU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:34:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEEBB6
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:34:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so2303501a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690529658; x=1691134458;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+fy+YaoLR7ul5xo0ghJQVtVbNpOhYsH434WA6W4gSE=;
        b=SJa/Uu1QBFWY+A96u8TemN9ue6BprhTOG3Wa2zMsmHeerrAMONVxsiDt8RsyR7NOqS
         cm/U20rBg8HahKK4VZchNdZBNj6N9yMfOSAU4uLAEchP/qH7knhVd/8/8xJ1UOReeQxy
         rXRFmwrsUhs3zxgshfqPaE07h1f8Oc28QeIzZoC6ZCfstsobH7IRDrv+a+FGfVYDfaYy
         hkMLF/O5VuM01xF1n6dGcNnR1WrTnCrlVygiIaMPKQV1AlV3m5d3XXTgHOIDC8MCOyIg
         pAZOQHdEEEh8FEqmXqFqkOHYTSgvWu7uwUVi5pgqCs6XljX+HONOCqTtmCSgHOKv2FY7
         EMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529658; x=1691134458;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+fy+YaoLR7ul5xo0ghJQVtVbNpOhYsH434WA6W4gSE=;
        b=byH92cpQ4T7i9SZiVwDAolyO0ddO0Gkf8Pf2GPRihkF4kwL+vL1lbES8dj4JNqLJ7M
         oHaDEeyW6l/T/MbUk1Co863ZLzWwxVOjQSTMC1XGojWFoIrOPKZIvZiRunx125zYlhcY
         9+ByKja4IYmRk7sGACoV1WFTb1BlF98dipF2+kJSQnhpEBAJpYh88oc//YfMzOTD8cR4
         ofXaiUqnysflGf1XTqQ764fK5ypjj5quPYICWB67fKuF2auduUil2nWezZWSWrjzLYQR
         jPoY15zkvrh11YYTEzkIBEzTZ6p9P+pJ/N8W/m+GvOf1F3HHLsvxn7R0oT/W4+xi1n1x
         IJTQ==
X-Gm-Message-State: ABy/qLYTcOCeRC6+rR5E+8TK1aAuhkOhqLjiTCGWBLNb5yhnlaqxpri1
        fn+BsFhjq0VassGOq2A8NLY=
X-Google-Smtp-Source: APBJJlFOxmOJfAx1l6gqkjeLd1F2+SZRCH+2bKkn563nBbmYwKBczLdfi+SC3tduvZ2FcsIdEYSt5g==
X-Received: by 2002:a50:fa8d:0:b0:522:38cb:d8cb with SMTP id w13-20020a50fa8d000000b0052238cbd8cbmr954326edr.20.1690529657808;
        Fri, 28 Jul 2023 00:34:17 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id bm28-20020a0564020b1c00b005222b471dc4sm1487430edb.95.2023.07.28.00.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:34:17 -0700 (PDT)
Date:   Fri, 28 Jul 2023 09:34:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel: Simplify using devm functions
Message-ID: <ZMNvd9jroe2Le6gb@orome>
References: <20230719193213.4053199-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+orLy4bl322Tkzn3"
Content-Disposition: inline
In-Reply-To: <20230719193213.4053199-1-u.kleine-koenig@pengutronix.de>
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


--+orLy4bl322Tkzn3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 09:32:13PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> For all resources used by the driver there is a devm variant to allocate
> these. This makes it unnecessary to implement an error path or a remove
> function.
>=20
> While at it also use dev_err_probe() to compact returning an error.
>=20
> With the remove callback gone, there is no user of driver data left, so
> the call to platform_set_drvdata() can also be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-atmel.c | 38 ++++++++------------------------------
>  1 file changed, 8 insertions(+), 30 deletions(-)

Doesn't apply to the for-next branch, please rebase.

Thierry

--+orLy4bl322Tkzn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTDb3cACgkQ3SOs138+
s6HRew//fi/MT1ZrGO2yC7UIsIaYDPKZp/eZCIoHEMDHBikDhMxKnOeu28WR4Rny
sbJoXeBRqY7yiHQHIeB0MMDhJApwmm0qG3bVD2QIbNnKyMP07G3aZ3k1KV/Muc7q
M+OFmqeunTbKLz76RCvcK7jEUxZiOuu8ugppLCdbDuLfRDGB2SlW4B527RBp/97N
PMbIXsMXRITPL13EKTAK4BULGGaNmtxSgelQSLkcxa7FNgzAm01sEmaUoAeu3zaC
bciCPzGzeVET168Q+FwJS3nXYZvoC3mrCcBa/5qqWkZcZFPqp2SL/US4YncZUlxU
tsB4SJCyeU2Z8JZj3+Fmxd/W2BSirwp2yL2LeKYHk9S2hQRELDR6V/Y/OdgZYwjv
fR1aIpDNywDFsoJyCmPNdtOnFewKyrQdXlc2tFoVmzCr0lKimROLXyOQIzxNhj89
EgFLEWu+PkR7pux1l4KjdA/Nd8g1ln3l4HdNUZZl0A+TuhSCtP4prb00ZAf1QGAv
xyR+gkUBlAOoZakxUeP1Qx5X3q1yRZWeWBODSdc4VASX9jscw4iemNIkLIs1Eovm
5E9ow0FeAP8PQ/z4nKoy1NkTE7hiuPs/R/W1OiWYOh/6/ftz6UtilSmNI/F7aeR4
O+m4n8wlqzhFtq2evZdkS/1eFLWBwXNb0lLv54uFsIBGoRN/r8s=
=KkqU
-----END PGP SIGNATURE-----

--+orLy4bl322Tkzn3--
