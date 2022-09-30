Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94245F165D
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 00:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiI3W5p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Sep 2022 18:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiI3W5o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Sep 2022 18:57:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCBC13C840;
        Fri, 30 Sep 2022 15:57:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28AD4B82AA2;
        Fri, 30 Sep 2022 22:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAA6C433D6;
        Fri, 30 Sep 2022 22:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664578660;
        bh=lmKL7buOIcBCLg9QEZp/Zv0D0aOHO0tS1dI9NAZLDKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEdnmL6pt+ncwenmBMM11NkZs6RnX5tnZJ6ZU574DjGrVdAd7xlQuXXOcweEgs/03
         Ycp3D1UBLca4WnW0Gc7nh5A3CRI088KX/rcfsM+AnEl+AoSQKk+XrFPMyD0qzUi+83
         JxXtCfZkWwJkjUIFxACIJb0ymWdOGXBjW1D3N1QYZUmcoYsWKz9gDAr1j2+AWgklNS
         6B2pI9AgeZYzdUoy0UB1MutjkyiR7DAvJbgVCYuNZP7REFI+0kb5Dw+OBqggwXbVk9
         EgdGDOc59B7w8OU3BZe1kwkbPjykctZhxl+o3LP1AqLWhhuQ9YSyLqnfhPRRLiAWHv
         wD5i6SBN7myFw==
Date:   Fri, 30 Sep 2022 18:57:36 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Message-ID: <Yzd0YAWG/W9RNLQA@ishi>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MpzE21/J3ughFNeW"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--MpzE21/J3ughFNeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 06:14:57AM +0000, Biju Das wrote:
> Hi William Breathitt Gray,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
> >=20
> > On Mon, Sep 26, 2022 at 02:21:06PM +0100, Biju Das wrote:
> > > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> > > the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> > > channels and one 32-bit timer channel. It supports the following
> > > functions
> > >  - Counter
> > >  - Timer
> > >  - PWM
> > >
> > > This patch series aim to add MFD and counter driver for MTU3a.
> > > Subsequent patch seies will add TImer and PWM driver support also
> > > enhancements to counter driver.
> >=20
> > Hello Biju,
> >=20
> > I see this device consists of several channels, but only one Count is
> > defined in the counter patch ("Channel 1 Count"). Do all channels
> > support counting, or is it limited to just one channel?
>=20
> It is like this
> MTU1 channel :- 1 16-bit phase counter
> MTU2-Channel :- 1 16-bit phase counter
> MTU1 + MTU2 channel combined:- 1 32-bit phase counter
> Other channels are not supporting phase counting.
>=20
> Each counter device will have 1 channel. Currently it supports
> 16-bit phase counting.
>=20
> Please see my test program. Am I missing something here?
>=20
> My test program:-
>=20
> echo 1 > /sys/bus/counter/devices/counter0/count0/enable
> echo 50 > /sys/bus/counter/devices/counter0/count0/ceiling
> devmem2 0x10001391 b 0x00 # Enable phase clock selection A for MTU2.
> echo 1 > /sys/bus/counter/devices/counter1/count0/enable
> echo 50 > /sys/bus/counter/devices/counter1/count0/ceiling
>=20
> for i in {1..5};
> do cat /sys/bus/counter/devices/counter0/count0/count ;
> cat /sys/bus/counter/devices/counter0/count0/direction;
> cat /sys/bus/counter/devices/counter1/count0/count;
> cat /sys/bus/counter/devices/counter1/count0/direction;
> done
>=20
> Cheers,
> Biju

I'm not familiar with this hardware, but it looks like MTU1 and MTU2 are
on the same device. I think a more natural way to expose this
functionality in the Counter subsystem would be to define a Count for
each count value you can support; so something like this (all under
/sys/bus/counter/devices/counter0):

* count0 :- MTU1
* count1 :- MTU2
* count3 :- MTU1 + MTU2

You can then control the phase selection using a top-level Counter
device extension (e.g. /sys/bus/counter/devices/counter0/phase) that
configures whether you're in 16-bit phase or 32-phase counting mode.

William Breathitt Gray

--MpzE21/J3ughFNeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYzd0YAAKCRC1SFbKvhIj
K1NmAP0T9ebAjj5jOdsLtJEGgcdaNQkv7lQ/geskbeNovsFycAD/d6QOE0LVfQU3
bRDGLHemU/QsmfDjnd6eHuRDpAA2ZwQ=
=61Rh
-----END PGP SIGNATURE-----

--MpzE21/J3ughFNeW--
