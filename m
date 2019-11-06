Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1146F22B8
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Nov 2019 00:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbfKFXff (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Nov 2019 18:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfKFXfe (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 6 Nov 2019 18:35:34 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13F6621882;
        Wed,  6 Nov 2019 23:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573083333;
        bh=acYkWuh1lxFHEeKgrIYJ5Yd9kylQa/fKIKHitMgaldM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y8CyCGFD6r8Yx6zd8knD2LQGyvkkPbvxiV5bsc2HYW4xX9s6Q2f6KRkfGPv+YyaXp
         FL+lDZrxyuN6rJfajkygkBM5zlGJFoIlw3psHHScwjPnUh1cD59AsZ4CvJsvDxyGi6
         lBe3FoyN2A149QlMILkLty2lw6pSRaSAMVjATGlg=
Received: by mail-qt1-f182.google.com with SMTP id u22so267970qtq.13;
        Wed, 06 Nov 2019 15:35:33 -0800 (PST)
X-Gm-Message-State: APjAAAWoSTGtilnWKEgEjUhtt3AgKGZbJ3DQEFC/NKprA0u74EN6TRG2
        z/heRVYrLuPgLmwFOoYq3UhyPImhydEFJ4qAFQ==
X-Google-Smtp-Source: APXvYqwNuYTsv7zmDJbGaopPUrmmqNxKU8Cj804+ATwfmxxu9034v+A6BQ+Qmo8CGUNIZgx7qrGV1CetGwfhUmZEvmQ=
X-Received: by 2002:ac8:7612:: with SMTP id t18mr653216qtq.143.1573083332254;
 Wed, 06 Nov 2019 15:35:32 -0800 (PST)
MIME-Version: 1.0
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-3-benjamin.gaignard@st.com> <20191103110841.3ad3ecfb@archlinux>
 <CA+M3ks5sZ6wwV-V+HCLC8OLdeLqrxK0Ga-pXTsdktQErbMOk4g@mail.gmail.com>
 <20191106040657.GA5294@bogus> <d0196570-9140-c775-742c-89092056e651@st.com>
In-Reply-To: <d0196570-9140-c775-742c-89092056e651@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Nov 2019 17:35:20 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+b_e1MbXx6918+iKfrTgqoozxOZ2rEYgogChZDWR_+iQ@mail.gmail.com>
Message-ID: <CAL_Jsq+b_e1MbXx6918+iKfrTgqoozxOZ2rEYgogChZDWR_+iQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: iio: timer: Convert stm32 IIO trigger
 bindings to json-schema
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 6, 2019 at 1:52 PM Benjamin GAIGNARD
<benjamin.gaignard@st.com> wrote:
>
>
> On 11/6/19 5:06 AM, Rob Herring wrote:
> > On Tue, Nov 05, 2019 at 11:07:16AM +0100, Benjamin Gaignard wrote:
> >> Le dim. 3 nov. 2019 =C3=A0 12:08, Jonathan Cameron <jic23@kernel.org> =
a =C3=A9crit :
> >>> On Thu, 31 Oct 2019 13:30:38 +0100
> >>> Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> >>>
> >>>> Convert the STM32 IIO trigger binding to DT schema format using json=
-schema
> >>>>
> >>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >>> I'm far from great on these as still haven't taken the time I should =
to learn
> >>> the yaml syntax properly.  A few comments inline however based mostly=
 on this
> >>> doesn't quite look like other ones I've seen recently.
> >>>
> >>> Thanks,
> >>>
> >>> Jonathan
> >>>
> >>>> ---
> >>>>   .../bindings/iio/timer/st,stm32-timer-trigger.yaml | 44 ++++++++++=
++++++++++++
> >>>>   .../bindings/iio/timer/stm32-timer-trigger.txt     | 25 ----------=
--
> >>>>   2 files changed, 44 insertions(+), 25 deletions(-)
> >>>>   create mode 100644 Documentation/devicetree/bindings/iio/timer/st,=
stm32-timer-trigger.yaml
> >>>>   delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm=
32-timer-trigger.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iio/timer/st,stm32-ti=
mer-trigger.yaml b/Documentation/devicetree/bindings/iio/timer/st,stm32-tim=
er-trigger.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..1c8c8b55e8cd
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/iio/timer/st,stm32-timer-tri=
gger.yaml
> >>>> @@ -0,0 +1,44 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/iio/timer/st,stm32-timer-trigger=
.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: STMicroelectronics STM32 Timers IIO timer bindings
> >>>> +
> >>>> +maintainers:
> >>>> +  - Benjamin Gaignard <benjamin.gaignard@st.com>
> >>>> +  - Fabrice Gasnier <fabrice.gasnier@st.com>
> >>>> +
> >>>> +properties:
> >>>> +  $nodemane:
> >>> nodename?
> >> That will be in v2
> > No, $nodename is correct. The '$' signifies something we generate and
> > add in. IOW, not a real property. I guess we could have used 'name' her=
e
> > and stuck with traditional OpenFirmware.
> let's go for $name

No, $nodename is correct. You don't have a choice. That is what the
tooling generates.

Rob
