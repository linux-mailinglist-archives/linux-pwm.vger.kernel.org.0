Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE76F6295BB
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 11:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKOKZS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 05:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKOKZR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 05:25:17 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F03DA45C;
        Tue, 15 Nov 2022 02:25:17 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id f18so1880926ejz.5;
        Tue, 15 Nov 2022 02:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiqDyHGlZxMgswEWLlx/5IXGHN/+M/e2E7njA25+Yas=;
        b=nSLC1oGWbgO/cUDwfYorZF4i+uopgFAb166iZkJdbP4FIu2c/gRZElFgNztoBf4Zvl
         bfMwNwbJZKaK9LiTDBowB7ol/RySr914LI1rNxN26l76ClM085DcS9XC4UD3O8gpl2+s
         Y5UW6Z06aPPlfc4ACFO0LcgdO5wWGNUsONYqvnePEoSzkHqNO9TIqKSvYv+RBVOLMAZA
         xib6+cmtoSJ8Ww0ve8XN+6Xam2IQr3vxtjoaMW3M8SSCVlvfJBkY2R2juNo02/8y8FpU
         bCeqkA0XgbIZtDNt8sqLKHDfxMTb4nhmlC1qMyrAoDcZW2yFKdwtQoYxroAhliYobdi9
         MBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiqDyHGlZxMgswEWLlx/5IXGHN/+M/e2E7njA25+Yas=;
        b=th7o6zqnHzonwLWxKlyg+of9VTQRtLrngvQQBShFxDPp/D6udi61Y989FEj1zqLnte
         BHCwgCMlGwsVgHB+0U0WPNN8oe7vbS4VBdMY/l4qIY2RvGB/ftjFw1RvOATlYU3n2KzO
         vOrh79jmAJe3GGDaZxlzOGK5O4m9GdcSDRGrcjFVXqJd5Pud9zQKEfWurCFP8kv7Qj20
         PdJbyatxT5X5+Wbyn4HVKQN0BGA9pHnfe6Ce0MztMv6m8GrWoaOnJQKdhiLLZ1Urxxnz
         ch//OO8rVFnLk382FMOsYeQtAIlDlRGBkZnoRjtARdK86DdP36mLj8NI6A2xLfeCbpVq
         3j5w==
X-Gm-Message-State: ANoB5pnT2vVmqbaj20QlICD9EpOeo0l25oGmfnVtldrwUm5NG3nQP0t0
        5Z8aZxh6ijdSY+uh3R7rYxQ=
X-Google-Smtp-Source: AA0mqf50zVuqI5KShUbY34Dl4BKiF9UQwD4gT2JX4AAmDlDxB1BLXgMYtJbnQ9aNnqrBC2du8M5s2A==
X-Received: by 2002:a17:907:a78b:b0:7ae:37a9:b8f2 with SMTP id vx11-20020a170907a78b00b007ae37a9b8f2mr13002097ejc.398.1668507915304;
        Tue, 15 Nov 2022 02:25:15 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y14-20020aa7ccce000000b0045b4b67156fsm6001694edt.45.2022.11.15.02.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:25:14 -0800 (PST)
Date:   Tue, 15 Nov 2022 11:25:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 02/10] ARM: dts: suniv: f1c100s: add PWM node
Message-ID: <Y3NpCKONx/0/COAv@orome>
References: <20221107005433.11079-1-andre.przywara@arm.com>
 <20221107005433.11079-3-andre.przywara@arm.com>
 <20221115101926.dldj6ralahdzhj7k@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l6W4QUPthCHqA1lj"
Content-Disposition: inline
In-Reply-To: <20221115101926.dldj6ralahdzhj7k@pengutronix.de>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--l6W4QUPthCHqA1lj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 15, 2022 at 11:19:26AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Nov 07, 2022 at 12:54:25AM +0000, Andre Przywara wrote:
> > The Allwinner F1C100s family of SoCs contain a PWM controller compatible
> > to the one used in the A20 chip.
> > Add the DT node so that any users can simply enable it in their board
> > DT.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>=20
> I checked "by hand" that this matches the modified binding in patch
> 01/10.=20
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> I assume the whole series will go in via a tree different from the PWM
> tree? While this is Thierry's area of maintenance, I'd be surprised if
> he had concerns about that.

Yeah, it's probably best for the Allwinner maintainers to pick this up
into their tree so that the bindings changes go along with the DT
changes.

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--l6W4QUPthCHqA1lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNzaQgACgkQ3SOs138+
s6Fn9RAAt+XRPFAS9efnEeAg7yzhd5KACfgZ5iOHVCTYLLgA67VmqUZ/LS/fjb/t
0pbACyLypmoGflQL5YjV5jwg1smW6ubWWCw9BJq8VlZ0eISjx3QkRxZSaK1P5Kil
N/GyeLV53ezyV8gBE0vMBDKPn7XSH0KpJbs8ompGb36jWBAwT4r7E8Ze+MBDTUtP
HcQZbrVNCReYBIo38G6Nav+2lZnYHyb2rey2WMuGoWl38WR+68/V/Fo+2kRB14hV
FpRNE/QCRNa7e1W7JgbjUTrDTt/NrOPV2tnMDUofpecSUeRMGMG3vF87pQLMm92Y
Hw6lYMRBTR3cab0waBUSXJCBOIefdPsEgOxkQ8ap3phdsvrsgLLy/DxWtyR6GNyE
s0SjbCnutGVmVXfLUMUH8Z3MPPr5TKw8cjsRIzKgCxBkNcpyu9Me2SD6Npmf379/
4gyGw9g/3eS3UtQc9HmiBgpyuhsNljCEVvoG6+TMbSMtBKttiKKiwpvJuMz81caF
g0QmqGGWNitbZJspwhqGFLFckFDQ+xkmX20vFA3NPE6eMtkOivfaslYZVdJRGmZM
HDYAFfTbXGEIawHftmIrrm8VNZfs/CToSxayQecZGjVPlyMEBxyZXbxJC3S5ZTuc
dcMif7pTYY2Jk/OEikFG8G38H2IeQGHEee1+YRXv46oSx1pyh+I=
=TpgC
-----END PGP SIGNATURE-----

--l6W4QUPthCHqA1lj--
