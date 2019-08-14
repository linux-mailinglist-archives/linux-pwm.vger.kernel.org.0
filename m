Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43B8CCAF
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Aug 2019 09:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHNH0F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Aug 2019 03:26:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43649 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfHNH0F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Aug 2019 03:26:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id y8so2391474oih.10
        for <linux-pwm@vger.kernel.org>; Wed, 14 Aug 2019 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=olhS25dpAXpeU0ZvOtkBvW+ClqVt1x4RdJvEXREO/pM=;
        b=PQPmRWR5gZp7mzNL5oK4V7JWl+aObCQ514py2raT6sWBvoDpoDhuhxyizxfGl2XDNP
         UdsBhgl9sEiDrvP0H8ET+8rIEoPFqY6R1sm9YoFL86uC2rfA6bUw+PV8xE7CK2lySd5m
         ZNBGAwbUtKuUMQWtxa0+IWsAFm8tUM8ypG9BxebjDxqKA0dIeupfD0FzbrZH2TCifaTu
         CXyk57FMxJ+e0lk8uxDEfwiEONa4tZCtX3RT9CFvTMiJd5Wdf+K5M72jTGZ3kdRnDTi7
         QhaxqQDtcl0A1omOHnRG3sSxc8/pfu9CrbwFznkMPVZ+6pLAWZQco9/JqGyRqH5OC2Gu
         1srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=olhS25dpAXpeU0ZvOtkBvW+ClqVt1x4RdJvEXREO/pM=;
        b=PeV3KnjHqAy1ttTD+E+m0Z/z/rm9te/MqLqamcpxos8HNFZ7AVOrwiE0Y/yoXN34uq
         wnyd34AZMLvju8lyJIZ9c3T0APTXxsDxaCli0H8Kd1aaVXoD1dcwNr+SBGP1wuj7qp4M
         BFzudpP6gFEseH7rEyR8qfGhMuzHlHDrFoqKNhog4EEmlvpP9sThWrD0OgXzqzrzGrJN
         /LqEKY+fDBx9yn/vhNCqzelXRQ6FylW8tGr+L35UE3TRZpGNGfE+fdWYA+eaWYfUHfSk
         9bHcL2jYfYI//kIWPt+TRoob6ySVKsT/0bcnsEeIPqnh16SHts5K2PRVd5ii/X18DQ9l
         HuKw==
X-Gm-Message-State: APjAAAU3xTYkCbs3hD1rj8zgauT8t+PIJ9IlAiTppIqpgqQ8LWPL6j16
        fmF0agMgDc2Ds7Pb9/uBoTLvdai6YJLSGsaKuJlaCQ==
X-Google-Smtp-Source: APXvYqw5nOr78y7pKXN0vQAd6beatsPQcxL4mjFV1POgeeN9zP3ZACVssAXIMIfMHPLrY/8lYDNt3otHDUbe5BNSK4s=
X-Received: by 2002:aca:4255:: with SMTP id p82mr4392410oia.6.1565767564780;
 Wed, 14 Aug 2019 00:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <20190813141256.jnbrfld42rtigek3@pengutronix.de> <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
 <20190814070121.o53tj2mtky4hcy3n@pengutronix.de>
In-Reply-To: <20190814070121.o53tj2mtky4hcy3n@pengutronix.de>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 14 Aug 2019 15:25:53 +0800
Message-ID: <CAMz4ku+55O6ORVM9xDv4R954QG4PXV8EkcGypSTB5wKni+Dq+Q@mail.gmail.com>
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

On Wed, 14 Aug 2019 at 15:01, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Wed, Aug 14, 2019 at 09:51:34AM +0800, Baolin Wang wrote:
> > On Tue, 13 Aug 2019 at 22:13, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
> > > > +- assigned-clock-parents: The phandle of the parent clock of PWM c=
lock.
> > >
> > > I'm not sure you need to point out assigned-clocks and
> > > assigned-clock-parents as this is general clk stuff. Also I wonder if
> > > these should be "required properties".
> >
> > I think I should describe any properties used by PWM node, like
> > 'clocks' and 'clock-names' properties, though they are common clock
> > properties.
>
> Then you might want to describe also "status", "assigned-clock-rates",
> "pinctrl-$n", "pinctrl-names", "power-domains", "power-domain-names" and
> probably another dozen I'm not aware of.

We usually do not describe 'status', but if your device node used
"pinctrl-$n", "pinctrl-names" ... common properties, yes, you should
describe them to let users know what is the purpose of these
properties. That's also asked by DT maintainer Rob.

>
> > Yes, they are required. Thanks for your comments.
>
> required in which sense? Why can a Spreadtrum PWM not work when the
> clock parents are unspecified?

On some Spreadtrum platforms, the default source clock of PWM may not
be enabled, so we should force users to select one available source
clock for PWM output clock.

--=20
Baolin Wang
Best Regards
