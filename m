Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B50F917C6E9
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 21:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCFURQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 15:17:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36442 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCFURP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Mar 2020 15:17:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id s17so2909543wrs.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Mar 2020 12:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=W5vuMAQlP/pswYB/GXVE3Zl4riEFKEE7ie+SKRmal+A=;
        b=TnbXAUNOymXAg4E5ylEB78BCKLRoqRyjo7HHwCE5mF5chf989aKRi7x9lEHcEms0ru
         EfAUDSuI+9iWOgBkapOAhY4MS6CAQKN3EMIKBDMggPya+en8EhD8SEWRFDlVb4pX6Mc1
         cUw0WwjMN0r3oFcSQlmXFbNl08L9CutLo8Yjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=W5vuMAQlP/pswYB/GXVE3Zl4riEFKEE7ie+SKRmal+A=;
        b=NVbvii/YJrjf2W0AyfKpJIknXNMLKYZRW8umup8QTMHV8VBxh3tCZpiUKqXe5fUFIa
         UK3y9VYOaNtNAR1f+0ol3wTytXKECj2llZ0Gf+MQr4Vm6UY7BQsjoREKYYVlJx8napki
         SBFK5zwGlE2kH4G1IZ/6yH+ienBIe+3TkOqARc/rBdv7vYQBX4WXqoF2TjzGGxqcRtco
         Q1uYXifczEGwZBWDA6WEhMlTboGzYMh5dFQwCswXs8kJNsRa18q8cb58CfB0FblZD4rV
         ExVIX3IG9SUPI5ACtBhuekATOIBkkrCE/wlKSnPZvXaWjcroHcigeWy2C8OTJjFOuzdc
         F19Q==
X-Gm-Message-State: ANhLgQ1P2Db9qi/T7KIvMqQcoN132Ww0ziu0Xcig1qwD8VEPybHBMg1p
        dwVFF/px7gQRoWnoSYde9rEGCA==
X-Google-Smtp-Source: ADFU+vvqY4qKDIwiATZaIBtsRMHroux6pd0ex8+HlwjC7e401argo9O7tDWbHCc0DheRr1aJ7k6v5A==
X-Received: by 2002:a5d:5682:: with SMTP id f2mr5332496wrv.327.1583525833437;
        Fri, 06 Mar 2020 12:17:13 -0800 (PST)
Received: from ub1910 ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id w1sm14361781wmc.11.2020.03.06.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 12:17:13 -0800 (PST)
Date:   Fri, 6 Mar 2020 20:17:08 +0000
From:   Paul Barker <pbarker@konsulko.com>
To:     Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: Inverted PWM output on iMX6
Message-ID: <20200306201708.0b94a5ac@ub1910>
In-Reply-To: <619c279c-5dd7-8d81-3527-dc37f8827104@ysoft.com>
References: <20200305132232.1aced378@ub1910>
        <20200305133649.bx7r7d4ntwi75qqb@pengutronix.de>
        <619c279c-5dd7-8d81-3527-dc37f8827104@ysoft.com>
Organization: Konsulko Group
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 6 Mar 2020 08:43:45 +0100
Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com> wrote:

> On 05. 03. 20 14:36, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >=20
> > On Thu, Mar 05, 2020 at 01:22:32PM +0000, Paul Barker wrote: =20
> >> I recently ran into an issue using the pwm-fan driver with an inverted
> >> PWM output on iMX6.
> >>
> >> The fan is defined in the device tree as follows:
> >>
> >> 	fan0: pwm-fan {
> >> 		compatible =3D "pwm-fan";
> >> 		pwms =3D <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
> >> 		...
> >> 	}
> >>
> >> In pwm_imx27_probe() the support for a third `flags` argument in a pwm
> >> reference is enabled:
> >>
> >> 	imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
> >> 	imx->chip.of_pwm_n_cells =3D 3;
> >>
> >> However, the flag is ignored and the output is not inverted.
> >>
> >> By adding some prints I saw that when of_pwm_xlate_with_flags() is
> >> called, args->args_count is 2 instead of 3.
> >>
> >> Looking at the definition of the pwm device itself in imx6qdl.dtsi I
> >> can see that the number of cells in a pwm reference is set to 2 not 3:
> >>
> >> 	pwm2: pwm@2084000 {
> >> 		#pwm-cells =3D <2>;
> >> 		...
> >> 	};
> >>
> >> That seems to be preventing a third argument from being passed.
> >>
> >> I can change `#pwm-cells` to <3> and then everything works for my
> >> device but I'm not sure that is the correct solution for everyone. That
> >> would require all pwm references on iMX6 devices to use 3 cells. The
> >> code in of_pwm_xlate_with_flags() seems to be built to handle either 2
> >> or 3 argument cells but I can't see any way to allow this choice in the
> >> device tree.
> >>
> >> If the solution is to set `#pwm-cells` to <3> I'm happy to send a patch
> >> which does this and updates all pwm references in device trees which
> >> include `imx6dql.dtsi`. Before I do that I'd like to know that it's the
> >> correct approach though.
> >>
> >> For context I've confirmed this is the case in Linux 5.4 and that the
> >> relevant files haven't changed between that release and 5.6.0-rc4. =20
> >=20
> > I think changing that is fine. However you'd have to care that all
> > in-tree users that rely on #pwm-cells =3D <2> are fixed accordingly.
> >=20
> > I'd do: add #pwm-cells =3D <3> in the cpu.dtsi and then adapt all
> > machine.dts to add #pwm-cells =3D <2> until there are no more changes to
> > the generated files compared to the current state. =20
>=20
> I solved that in the past on our board the same way as other imx6 boards
> did. Just override the #pwm-cells property in your board specific devicet=
ree
> and you are fine:
>=20
>    linux-src$ git grep pwm-cells -- arch/arm/boot/dts/imx6*-*
>    arch/arm/boot/dts/imx6dl-yapp4-common.dtsi:     #pwm-cells =3D <3>;
>    arch/arm/boot/dts/imx6q-display5.dtsi:  #pwm-cells =3D <3>;
>    arch/arm/boot/dts/imx6q-mccmon6.dts:    #pwm-cells =3D <3>;
>    arch/arm/boot/dts/imx6qdl-tx6.dtsi:     #pwm-cells =3D <3>;
>    arch/arm/boot/dts/imx6qdl-tx6.dtsi:     #pwm-cells =3D <3>;
>    arch/arm/boot/dts/imx6ul-tx6ul.dtsi:    #pwm-cells =3D <3>;
>    arch/arm/boot/dts/imx6ull-colibri.dtsi: #pwm-cells =3D <3>;
>    arch/arm/boot/dts/imx6ull-colibri.dtsi: #pwm-cells =3D <3>;
>    arch/arm/boot/dts/imx6ull-colibri.dtsi: #pwm-cells =3D <3>;
>    arch/arm/boot/dts/imx6ull-colibri.dtsi: #pwm-cells =3D <3>;

Michal,

That approach would be good enough for my limited use case but it doesn't
prevent others from hitting the same confusion in the future. I'd rather
fix the base imx6 dtsi files to have #pwm-cells =3D <3> if the driver suppo=
rts
the third cell containing flags.

I'll send a patch once I've done a bit more investigation.

Thanks,

--=20
Paul Barker
Konsulko Group
