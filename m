Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4C8C5AB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 03:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfHNBvq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Aug 2019 21:51:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40514 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfHNBvq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Aug 2019 21:51:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id c34so38743679otb.7
        for <linux-pwm@vger.kernel.org>; Tue, 13 Aug 2019 18:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bENj68yNPvoXsCnAgd0SA0efIreQ33qie/1p2j9abDg=;
        b=rTYPz9aiyiidUY/wAQbPCUip4SOPtdrK9Ku+oOnr9N9FsdTW6VdYimGXnVisYjzVer
         9cQiEiFf14ohMexdIV+HWyVrpp37h0lxU3Bttwng4fhiFLlUHYlAf0EWXgJdGzcOd+2t
         KB3FmbtCIOawjudrbos/m/GpBE87qI7cjyKhEIwbMjnQPhmj02Ga2WkXnbY0/6G5Hiab
         lg6yKfu7gFpaid7vb5rwXO2sC2VpyanqNlKNNYC8jpGiuHM8mS7uDH572n6RcL6fHY8L
         n1jl5rhgcXFhRoqpt+Twpxlsq0zHMJTMNEXZZB7e7m8w3noD5QXvWAdPgVrmgBnVhdpW
         KopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bENj68yNPvoXsCnAgd0SA0efIreQ33qie/1p2j9abDg=;
        b=U6rZ5LGduAMQUYCOV1Tca1dUUSurS6UFKqx7Jo+RV1TBdqJvquKGeIXwiAxxdna6L1
         PXwDi4fJ7lRZRNo+E32SwWEjlAqWbxqcQkSb6SrIPp1QxtyV8NAgD4b9+b8i0x5myMdE
         5riaSS4+S8ysro8nT4ZNvrvOmIqaizpi8vuEKoirhdnpkc/xEto7scsH1cP6MtUIgiaJ
         50LWW8pyf+bPZepvd4mhBDax6PT4aFGJDU5keXyejn3/Zpr0+ZZCtVSNrJ2JJJS0LxKK
         +BbgSsZ+/FKpercNZgFi/W3hMgh130X+hrEvBCZziIpxDLFo8Jsm3baUca2thuM9cTUx
         +TLw==
X-Gm-Message-State: APjAAAVU90LNANpqTZf9xozrEx0d+AkzNO4txuGYzmbkAZtpJAt5Xlmd
        E5Nb96Qeti8EMSuocDY8AH//YT7PvliuetaI3dicOw==
X-Google-Smtp-Source: APXvYqxj2Kf4NQn6zAI/marGBfVf9i5t6w0XkS2JIvLPnexUrTI65+lv4tFTmxp1aSV9RDZdYqcvjbFNki+hbtOW3X4=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr24720737otk.145.1565747505094;
 Tue, 13 Aug 2019 18:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <20190813141256.jnbrfld42rtigek3@pengutronix.de>
In-Reply-To: <20190813141256.jnbrfld42rtigek3@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 14 Aug 2019 09:51:34 +0800
Message-ID: <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM documentation
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, 13 Aug 2019 at 22:13, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
> > Add Spreadtrum PWM controller documentation.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Changes from v1:
> >  - Use assigned-clock-parents and assigned-clocks to set PWM clock pare=
nt.
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-sprd.txt |   38 ++++++++++++=
++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Docum=
entation/devicetree/bindings/pwm/pwm-sprd.txt
> > new file mode 100644
> > index 0000000..e6cf312
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> > @@ -0,0 +1,38 @@
> > +Spreadtrum PWM controller
> > +
> > +Spreadtrum SoCs PWM controller provides 4 PWM channels.
> > +
> > +Required porperties:
>
> s/porperties/properties/

Sorry for typos, will fix in next version.

>
> > +- compatible : Should be "sprd,ums512-pwm".
> > +- reg: Physical base address and length of the controller's registers.
> > +- clocks: The phandle and specifier referencing the controller's clock=
s.
> > +- clock-names: Should contain following entries:
> > +  "pwmn": used to derive the functional clock for PWM channel n (n ran=
ge: 0 ~ 3).
> > +  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
> > +- assigned-clocks: Reference to the PWM clock entroes.
>
> s/entroes/entries/

Sure.

>
> > +- assigned-clock-parents: The phandle of the parent clock of PWM clock=
.
>
> I'm not sure you need to point out assigned-clocks and
> assigned-clock-parents as this is general clk stuff. Also I wonder if
> these should be "required properties".

I think I should describe any properties used by PWM node, like
'clocks' and 'clock-names' properties, though they are common clock
properties.
Yes, they are required. Thanks for your comments.

--=20
Baolin Wang
Best Regards
