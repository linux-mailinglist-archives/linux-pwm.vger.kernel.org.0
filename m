Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ADD7E1EDC
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Nov 2023 11:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFKtZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Nov 2023 05:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjKFKtX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Nov 2023 05:49:23 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269FEC6;
        Mon,  6 Nov 2023 02:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1699267759; x=1730803759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ClLqCe2MPe30BlSuDnNn0P7ZITlkrf+aHuvKtDI/Mc=;
  b=q2fXyPiFOqPkVKudnmf3sZDMb7RRMuvJb271IRJCvoaJEH9OSWAnQ9NH
   WQMWVgGv9ShwZ/RcCzJCBocCpntV6tBg0zl4gMiB55zFQ7GL2biYs+pml
   EK84BlQvjssGiRuKnmvUNFhNoPfMntu65kRNUkxg5Cr03iV6PI9uKOalz
   fni9h6x0hnKLMFv9fVLqC3mWaV4HD5/1SPqVxau32rqOrMVAlnZ49UEi0
   NMNXgfe++OKlkMbvfS2niXmuHyg9lsZvwoPJ3UrCqG4B5oIxb69HDH7Bg
   maIaNeu1hQuMHhzXYil7l0Z/9giJrVGxKergx8bdTWACnd7XWHlmRqMtF
   w==;
X-IronPort-AV: E=Sophos;i="6.03,281,1694728800"; 
   d="scan'208";a="33824773"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 Nov 2023 11:49:17 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9727928007F;
        Mon,  6 Nov 2023 11:49:16 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm: imx-pwm: Add constraints for #pwm-cells
Date:   Mon, 06 Nov 2023 11:49:19 +0100
Message-ID: <8300676.T7Z3S40VBb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231106103621.2fh6fkpdafpz4toa@pengutronix.de>
References: <20231106095205.231210-1-alexander.stein@ew.tq-group.com> <20231106095205.231210-2-alexander.stein@ew.tq-group.com> <20231106103621.2fh6fkpdafpz4toa@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

Am Montag, 6. November 2023, 11:36:21 CET schrieb Uwe Kleine-K=F6nig:
> Hello,
>=20
> [dropped Philippe Schenker from Cc as his email bounced in the past]
>=20
> On Mon, Nov 06, 2023 at 10:52:03AM +0100, Alexander Stein wrote:
> > Only fsl,imx1-pwm comptabile devices use #pwm-cells =3D <2>. Newer SoCs
> > supportinverted PWM output, thus #pwm-cells needs to be set to 3.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >=20
> >  .../devicetree/bindings/pwm/imx-pwm.yaml      | 20 ++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml index
> > c01dff3b7f843..59a981c0f39ab 100644
> > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > @@ -9,9 +9,6 @@ title: Freescale i.MX PWM controller
> >=20
> >  maintainers:
> >    - Philipp Zabel <p.zabel@pengutronix.de>
> >=20
> > -allOf:
> > -  - $ref: pwm.yaml#
> > -
> >=20
> >  properties:
> >    "#pwm-cells":
> >      description: |
> >=20
> > @@ -74,6 +71,23 @@ required:
> >  additionalProperties: false
> >=20
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx1-pwm
> > +    then:
> > +      properties:
> > +        "#pwm-cells":
> > +          enum: [2]
>=20
> Given that arch/arm/boot/dts/nxp/imx/imx1.dtsi has:
>=20
> 	pwm: pwm@208000 {
> 		#pwm-cells =3D <3>;
> 		compatible =3D "fsl,imx1-pwm";
> 		...
>=20
> this looks wrong.

Indeed, something i doesn't match. Checking with [1] section 22.4.1 there a=
re=20
no bits regarding output inversion. Also pwm_imx1_apply returns -EINVAL if=
=20
state->polarity !=3D PWM_POLARITY_NORMAL.
So IMO "#pwm-cells =3D <3>" is wrong for imx1. If fixed to 2, this also mat=
ches=20
the description for the value of #pwm-cells in imx-pwm.yaml.

Best regards,
Alexander

[1] https://www.nxp.com/docs/en/reference-manual/MC9328MX1RM.pdf

>=20
> Best regards
> Uwe


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


