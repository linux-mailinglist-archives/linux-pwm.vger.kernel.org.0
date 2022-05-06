Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1F51D377
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 10:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390196AbiEFIjQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 04:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390206AbiEFIjO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 04:39:14 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545EAE60;
        Fri,  6 May 2022 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1651826130; x=1683362130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ezNXxatfDHado1WYdiq8B8HsOFgBVwnLMYSDIoso/Xs=;
  b=W8hFoaSaM7CU4k3cdti4seMqnhs+iUMSAoXDte9cpkN4ZveoVIvnZi4L
   fJGqGSJ34H1qt/OS8loG7ymkbgelzMpuG9PxMfXsONl6ENa+BdV2bqVfc
   voH2tyZkXhYzLNGtf2OtDvrief9nHw6C6KrOcsY7udomvDhWBLMerVQHx
   9I9aVYHYbT/a5WgpQe32iyfNnsgh3TSJGIv0xarp3YkVR+x/1uDO1yK1V
   f45eySf39s+b4XcRNec03N6lRRkdSnLIwXjt1s5s7bFUXIfG88YctXfSH
   tnrA0m7aqTUXsNjoeGMVV5akQ+GSZiZDscN0wIMZjXI0vzTAjH6/toCXW
   g==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="23714677"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 May 2022 10:35:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 06 May 2022 10:35:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 06 May 2022 10:35:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1651826124; x=1683362124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ezNXxatfDHado1WYdiq8B8HsOFgBVwnLMYSDIoso/Xs=;
  b=X/yF1qKRxPq5umqV9DTTnD97HTq8pH6k6NsLOmVrEjlNA91Qgi9MCG8t
   nQkKD0jdMS0VNHp7sbYNT6T3/tswmza5ah+j7yrmPjgbypEoHr4pzH9EA
   L7xQvHNVjZSdGMG/qMw1b0FLEG7UIMRxtgH5keJMbtw4m7V07KJ9/BrHX
   eKIpZOmypdf56iUOzwk1mavgzWflOTC2mf2I3xuPG/1HjT+L808SOTDUj
   RMwaT7KBr8NLP5kkjhnnSaYKVH2tAmeNFmYEovpes1FhxZG/wDrnie0/J
   OZCKSUIIrdVYngqjIKMJnsq2a8IaaIxXQ2E/zsUotDAK/eJNpxiEch+WQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="23714676"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 May 2022 10:35:23 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B60A3280070;
        Fri,  6 May 2022 10:35:23 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: (EXT) Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan: dynamically switch regulator
Date:   Fri, 06 May 2022 10:35:21 +0200
Message-ID: <2371611.jE0xQCEvom@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220506082001.hybxzaic5wza7irh@pengutronix.de>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com> <2112012.Mh6RI2rZIc@steina-w> <20220506082001.hybxzaic5wza7irh@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am Freitag, 6. Mai 2022, 10:20:01 CEST schrieb Uwe Kleine-K=F6nig:
> * PGP Signed by an unknown key
>=20
> Hello,
>=20
> On Fri, May 06, 2022 at 09:15:55AM +0200, Alexander Stein wrote:
> > Am Freitag, 6. Mai 2022, 00:00:37 CEST schrieb Guenter Roeck:
> > > On Wed, May 04, 2022 at 02:45:51PM +0200, Alexander Stein wrote:
> > > > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > > >=20
> > > > A pwm value equal to zero is meant to switch off the pwm
> > > > hence also switching off the fan. Currently the optional
> > > > regulator is always on. When using this driver on boards
> > > > with an inverted pwm signal polarity this can cause running
> > > > the fan at maximum speed when setting pwm to zero.
> > >=20
> > > The appropriate solution in this case would be to tell the
> > > software that the pwm is inverted. Turning off the regulator
> > > in that situation is a bad idea since setting the pwm value to
> > > 1 would set it to almost full speed. That does not really make
> > > sense.
> >=20
> > The pwm-fan driver is already configured for inverted PWM (ommited some
> > properties for shortness):
> > fan0: pwm-fan {
> >=20
> > 	compatible =3D "pwm-fan";
> > 	fan-supply =3D <&reg_pwm_fan>;
> > 	pwms =3D <&pwm3 0 40000 PWM_POLARITY_INVERTED>;
> > 	cooling-levels =3D <0 32 64 128 196 240>;
> >=20
> > [...]
> > };
> >=20
> > The problem here is that the pwm-fan driver currently enables the
> > regulator
> > unconditionally, but the PWM only when the fan is enabled, refer to
> > __set_pwm(). This results in a fan at full speed when pwm-fan is idle, =
as
> > pwm state is not enabled.
>=20
> Which PWM driver are you using?

It's pwm-imx27 on a imx8mp based board.

> There is an implicit assumption in some PWM consumers that a disabled
> PWM emits the inactive level. However not all PWMs do this. Is this such
> a case?

Oh, I was not aware of that assumption. As far I can tell, this assumption=
=20
might actually be violated in pwm-imx27.
If state->enabled=3D=3Dfalse then the EN Bit in PWMCR is not set which most=
=20
probably renders the output polarity in POUTC as inactive.

Best regards,
Alexander



