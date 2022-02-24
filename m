Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF564C2C6B
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Feb 2022 14:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiBXNDD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Feb 2022 08:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiBXNCz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Feb 2022 08:02:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DC91A39CC
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 05:02:26 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s13so2925518wrb.6
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 05:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zK0UXyFfHexOltCJm7sSY9kVnD33KIb8pjqnAxvVy4w=;
        b=K/hrcBsDCpj54J6UsbxYPut971OM5T+oJ0Ky/UEYUVe4q96FnybNW3b/EnhYu5TTrC
         qk/EBvSDGRkaxPmbxSJ5ID4cDIOe+3QBbq6ogAMcfR7RhsCl6zKj0cdW/5Ou0NLysjnp
         z35AbhV/APE08WuL3S1Mx12qXHTD793rojiV2fxyAwe3k16BHYd6ZyHDHQ7+z2QcaXuu
         4lCLwKXxUV46HGU9F//ro4GAOEJy0fKfF29AqIcH9KmVfSLeWnUFFDc1F3mIqZE+cibb
         79pYL5+q1Be6n6WNBN+wAcN5ShX/YOkN7CSx5JnQEbDeWdL3CaUO0SRgSNaVF5Ote+yR
         azhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zK0UXyFfHexOltCJm7sSY9kVnD33KIb8pjqnAxvVy4w=;
        b=IlZv2xPGejKZcTe7fNAisIV8t349ng4zEhNvfJPaMHkgwCUKRcPX0WZSaItbv5Oogg
         W1EWBi/hL5+g0yThkbjAHUmbxziPGa02oeXguQPrsVnFOcEfqIj6UHB4DH+ijhpP2Tye
         u4A2GADyPtahyBVtm4pkjyvXkX5C+7EJC9KJCg2qQwhettb9Z0VCfIAWx35oxt/gHR/E
         YCiGSuRqFPLemjjGl+PQ7g4hrIExoyVf5weASmYrnPwBWBn4yTR6RWpiC12+qpN62R9q
         xVrYaWut23nFymI4y1uqQhK8f4Q1I5eGW53uYZa0qJP/zDrcv6GsLdvnVj7LuH/gvO+x
         GNMg==
X-Gm-Message-State: AOAM531ap+a7cPp5DsSuMqcrhydQaeupNUMjw5M/w79fdtbRBInciIdu
        TsaeXa75l8ZNnITZnSiYzV4=
X-Google-Smtp-Source: ABdhPJwbfIDahJDZzkP/rgj/Bcvjsr0NjcOrKDKe+A4P7WbQvBsEWnqcJJL7VcBpNrd7Ye7TXzCF6A==
X-Received: by 2002:a5d:5302:0:b0:1ed:e1d2:f0fd with SMTP id e2-20020a5d5302000000b001ede1d2f0fdmr2236814wrv.585.1645707744485;
        Thu, 24 Feb 2022 05:02:24 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j27sm2795145wrd.32.2022.02.24.05.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:02:23 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:02:11 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lionel Vitte <lionel.vitte@gmail.com>
Cc:     linux-pwm@vger.kernel.org, clemens.gruber@pqgruber.com,
        Lionel Vitte <lionel.vitte@free.fr>
Subject: Re: [PATCH] pwm: pca9685: Set ALL_LED_OFF_L to POR value
Message-ID: <YheB06s5C1emJWxP@orome>
References: <20220122065819.69150-1-lionel.vitte@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LNcSpTqYCByxNy43"
Content-Disposition: inline
In-Reply-To: <20220122065819.69150-1-lionel.vitte@free.fr>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--LNcSpTqYCByxNy43
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 22, 2022 at 07:58:19AM +0100, Lionel Vitte wrote:
> During the driver probe, registers are not set to their POR value.
>=20
> Signed-off-by: Lionel Vitte <lionel.vitte@free.fr>
> ---
>  drivers/pwm/pwm-pca9685.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied with the subject rewritten along the lines of what Clemens
suggested.

Thanks,
Thierry

--LNcSpTqYCByxNy43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXgdMACgkQ3SOs138+
s6GMOxAAuolWTkJjvhePvbBFyoO0ozLxrmLXUyl5W5d5ZY0dAo+9s3NnqEKLXcUa
KgUj4pmuanSqdK5OLR1wwnf/h9PLVakl6u7FTIp+zvwfs4ssf6jYEqjBnBVyF15y
fTi2j21OR1J5MkLqcaUKm4LJ96zXYINpll2aonc0EdWqxzJQ1K3izDvg8Uvs24Td
jhJCDEPpEu99IdR1hZvyGo2tIgSFYVka58MZ40eXTBt+B+wW/Ydc6l3ewKRYGhv0
3HRMRjiGA2ullnQUN1kD5g2rxiBb6BACyIWCZXWyk8/D6xTZkQw8SGVQU+4ZBxzD
Aqb0qnsGz2gGM8KHyc3ot9D+MTl2mMlZZOGbBOPbLRAlxH/Y83prHUqYfXi/3dzd
rj+sE5pWIE9sEKO1sziQaXLH1vPUDCbWRBQqpScVfa0KSz1D8nbZsYymr4nyMI0M
T/7eR675JpvitZ+8aV6nqZa0TgasHBnufAG1O/5p091jQxRew2ILNfCGDV+tbq9C
vDs1lmNSe1Oii7OPs+1hLcoPruHMjl+YWElWSy9nlT7sEuTOay9526wnzEzYEF/b
CLeMxt4d4hF5CZf5IAb5No/5ZmQ29t1mdBjY9Q3s3NmOzLVMeBgJrIOIxOudlpVZ
o/iHeAKGKuUSZ3+KxKPHWkYnItspFzJ8JYPDvNjZbJ+QoJ/Abes=
=UIrb
-----END PGP SIGNATURE-----

--LNcSpTqYCByxNy43--
