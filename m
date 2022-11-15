Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0815362A45B
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 22:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbiKOVlW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 16:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238858AbiKOVkw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 16:40:52 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62823303C5;
        Tue, 15 Nov 2022 13:40:45 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id i10so30809756ejg.6;
        Tue, 15 Nov 2022 13:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN9fNzRPynZshOvz1sD/ekra6/Y60pLuVwbdRfSMmpY=;
        b=AoTcG+nryjYFo/HbwfQFUiJOx+15cUyilJQXqytwKEHJWeBZxJwrM5AZPu0Baq6IpV
         2ognOIa39AcdG8uRG8kyzv4XuFgsqa/ODt5i4O3FgjjrmqNguDDWu/tssEVMIU0mzGGG
         l4VK3XWP1clx6o8B7yuHxkfa4aNgXaFBUx/ekapGUGzmu65Vj9tmLqVZ9uE5/50ygavn
         BivPC7YkH/NNV805A3bf72LSZdqN4iIzB83iJtSBoREHhtjMzieQ5Uwcf25+ZYIpmpDN
         kPCwcbw8Y0bnT9xrEiPUoRjG/d8cSGSSqiJMvV+nmdx/LlEDofbSfzOsZHTDRcAB0eYg
         N9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN9fNzRPynZshOvz1sD/ekra6/Y60pLuVwbdRfSMmpY=;
        b=DyIV/x4FD5fGDVW5RdS6SxQqe79Rs332PRe1W46lHiP2ghbkrZf/WIGtEUyEHpsv6G
         aVj6wxorfhWkW+QWBTzH7YxZTYpy5TKUFW1M5OGwjnA1yCrOTpS3ezrZWSNKK3z+TE9d
         5DPB9I6gxQDM7T4WWBR1KFWUXGpiLbPHIOTvFJz6IGI8+JhGTjUlMpnTl4diWLvf+ZRq
         6xsBKLe3sO+u/oMBzg/UI2bi+g/j9/vhsRZR3f6v6Rgu7mNl/ArHuLJwD2YcCdkUVOTJ
         o6Dke1+hsSL2SiDO97n4I2wX8zYGq29G0f2+1qc9MggARX94hZt9PBmT1kV8T0Yxqcmy
         9h1Q==
X-Gm-Message-State: ANoB5pmK0WVwg7QLzJam/jjIRJDNYJ60UtisX0BqbXbdHPWIVbSWHA6k
        5iyPoNQV5gM241G9GwYzQrU=
X-Google-Smtp-Source: AA0mqf5OJQW6ihS4SMk+yXRV3FrfzvFIX29Ff9k1lefBMoiTwIoglHQEOV9MXsYoGW0Vf5MAwvwakA==
X-Received: by 2002:a17:906:a1d9:b0:78d:b371:16e5 with SMTP id bx25-20020a170906a1d900b0078db37116e5mr14993448ejb.456.1668548443979;
        Tue, 15 Nov 2022 13:40:43 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id kx7-20020a170907774700b00787f91a6b16sm6025823ejc.26.2022.11.15.13.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 13:40:43 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 02/10] ARM: dts: suniv: f1c100s: add PWM node
Date:   Tue, 15 Nov 2022 22:40:42 +0100
Message-ID: <7449883.EvYhyI6sBW@jernej-laptop>
In-Reply-To: <Y3NpCKONx/0/COAv@orome>
References: <20221107005433.11079-1-andre.przywara@arm.com> <20221115101926.dldj6ralahdzhj7k@pengutronix.de> <Y3NpCKONx/0/COAv@orome>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne torek, 15. november 2022 ob 11:25:12 CET je Thierry Reding napisal(a):
> On Tue, Nov 15, 2022 at 11:19:26AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Nov 07, 2022 at 12:54:25AM +0000, Andre Przywara wrote:
> > > The Allwinner F1C100s family of SoCs contain a PWM controller compati=
ble
> > > to the one used in the A20 chip.
> > > Add the DT node so that any users can simply enable it in their board
> > > DT.
> > >=20
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >=20
> > I checked "by hand" that this matches the modified binding in patch
> > 01/10.
> >=20
> > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > I assume the whole series will go in via a tree different from the PWM
> > tree? While this is Thierry's area of maintenance, I'd be surprised if
> > he had concerns about that.
>=20
> Yeah, it's probably best for the Allwinner maintainers to pick this up
> into their tree so that the bindings changes go along with the DT
> changes.

Yeah, that's the plan. I'll merge it in following days.

Best regards,
Jernej

>=20
> Acked-by: Thierry Reding <thierry.reding@gmail.com>




