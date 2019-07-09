Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA45638D6
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2019 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGIPqv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jul 2019 11:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfGIPqv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 9 Jul 2019 11:46:51 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9CD21707;
        Tue,  9 Jul 2019 15:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562687210;
        bh=4f3MOO8zcd+5CtA6PP6zPt3BLYAEsqlHl7hOpTexx+I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nu/W7DL+FL92KLTyNHww2Nb1KodWLchrMgI7cuVRB4QWi+/Uhhg4t8tzDx/Ifitsv
         gnYak4Ph65a5Z0KFTMtOJvcHHQYCHe2sfvLFYEeIIXrtTNBdTfmDicDsfBjhUzzXcr
         TfNjRvgu0nsTE8b0Ko/P7Rskv1ehTYAw1zRqkpmU=
Received: by mail-qt1-f180.google.com with SMTP id d17so20677431qtj.8;
        Tue, 09 Jul 2019 08:46:50 -0700 (PDT)
X-Gm-Message-State: APjAAAXI++Q+XHWFpelfswKXSQJTX+4t7ZpFQhWDSm75xdWyz79aIhtI
        iqJ7AuK8M0AiN2OVl8qt5JcBaIlF56FV5Yc/RQ==
X-Google-Smtp-Source: APXvYqydRCRswf88vjxavUG/qgoU+4yXgYQVD+q2t75PqwMNmeOfzwJzAfkQW1pTkrQVapqMI74TYwhjY2kifHq7aDs=
X-Received: by 2002:aed:3f10:: with SMTP id p16mr19409167qtf.110.1562687209443;
 Tue, 09 Jul 2019 08:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190607154410.10633-1-paul@crapouillou.net> <20190607154410.10633-2-paul@crapouillou.net>
 <20190709020425.GA7984@bogus> <1562642299.1834.0@crapouillou.net>
In-Reply-To: <1562642299.1834.0@crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Jul 2019 09:46:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKqhnt1a7vhF+4RA53dSNUaB==8Tmcida3z63nDSZGKA@mail.gmail.com>
Message-ID: <CAL_JsqJKqhnt1a7vhF+4RA53dSNUaB==8Tmcida3z63nDSZGKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: Remove unused compatible strings
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 8, 2019 at 9:18 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>
> Le lun. 8 juil. 2019 =C3=A0 22:04, Rob Herring <robh@kernel.org> a =C3=A9=
crit :
> > On Fri, Jun 07, 2019 at 05:44:05PM +0200, Paul Cercueil wrote:
> >>  Right now none of the Ingenic-based boards probe this driver from
> >>  devicetree. This driver defined three compatible strings for the
> >> exact
> >>  same behaviour. Before these strings are used, we can remove two of
> >>  them.
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>
> >>  Notes:
> >>      v2: Rebase on v5.2-rc3
> >>
> >>   Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt | 5
> >> +----
> >>   1 file changed, 1 insertion(+), 4 deletions(-)
> >>
> >>  diff --git
> >> a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> >> b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> >>  index 7d9d3f90641b..493bec80d59b 100644
> >>  --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> >>  +++ b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> >>  @@ -2,10 +2,7 @@ Ingenic JZ47xx PWM Controller
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>
> >>   Required properties:
> >>  -- compatible: One of:
> >>  -  * "ingenic,jz4740-pwm"
> >>  -  * "ingenic,jz4770-pwm"
> >>  -  * "ingenic,jz4780-pwm"
> >>  +- compatible: Should be "ingenic,jz4740-pwm"
> >
> > Are you sure all 3 chips are exactly the same features and bugs?
>
> The hardware on these chips have tiny differences, but the current
> driver code works on all the SoCs.
>
>
> > The correct thing to do here generally is the 4770 and 4780 would also
> > have ingenic,jz4740-pwm as a fallback compatible. Then the driver can
> > match on that until you find some difference and can use the more
> > specific compatible.
>
> Why not just update the devicetree with the new compatible string when
> a difference is found?

Because dtb's should be part of the firmware/bootloader and can be
updated independently. Maybe you don't care on your platform, but
that's the preferred model for DT and what we follow. DTs live in the
kernel tree for convenience, but are independent from the kernel.

Rob
