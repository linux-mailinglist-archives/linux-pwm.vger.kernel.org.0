Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2037BA7119
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Sep 2019 18:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfICQyt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Sep 2019 12:54:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44621 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfICQyt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Sep 2019 12:54:49 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so37453751iog.11
        for <linux-pwm@vger.kernel.org>; Tue, 03 Sep 2019 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ggETW+8FA62Mt4a95WVFTz5hpjErXLoqNww4/66NhtM=;
        b=NMsaZ46UlZVOPpO8QYjZ3BN7EGSLFQ/EkqR07+gdmUu7ZSRKe512669nBwEBcD7DBE
         BetuyRZKMX2pFikifi67XcAVlz/KSnSSsP5XdwDX3FxAEgRR+v4YxnXEkJvG4VrVvj/f
         BIFUryprAmABPSwndpoIBXnd+qlXJ5Ddaa9Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ggETW+8FA62Mt4a95WVFTz5hpjErXLoqNww4/66NhtM=;
        b=JhSTBqCw83lpDK7W1czHvgWUkUKkIQIYiLDviTbPTUQiT1kjBP7nS05JlCjnbER2gm
         uW87fsgCdbnYoeQibbg+m0pDuj+FOxVsDLUxNShFrEVYAwT/EyvWdy7gdiPZt9YdHmkm
         h+nj3gTTtHLLeJkyM6H/9P368DvjDXUcV2bHDwN1B26GjZrQBEfqJkYEt72I4x+V3IlZ
         Ojhjns9modrHinHQwVSOAKU1VDknhzAD4oY4dPpXBT+hGUamtIvwfvNoW69eUAXATUqG
         5qmlrgKwJxM+a+HP+iDO/N2ZXSWbq5tec/Wi4u8ETWCBtEV9apjBWjAhayR0BGzFU0EO
         XrgA==
X-Gm-Message-State: APjAAAW4WAVRPoPNxM5HASLF7OSEQ1bsysWWsw+eJw2DruXnG52E0tNg
        f5tB2uAT4KOcVKbnw+GeIG2afbnkj3Q=
X-Google-Smtp-Source: APXvYqxHDuE2a3j6W61nUYzJO4mU/+s6U7/Ny0l0NkGimToNa/CA8C/7gx8hATFbjiKdolMnGVPuJA==
X-Received: by 2002:a6b:b247:: with SMTP id b68mr1242240iof.207.1567529687926;
        Tue, 03 Sep 2019 09:54:47 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id z14sm12848095iol.86.2019.09.03.09.54.47
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 09:54:47 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id m11so5535643ioo.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Sep 2019 09:54:47 -0700 (PDT)
X-Received: by 2002:a5e:8d14:: with SMTP id m20mr5528472ioj.52.1567529686981;
 Tue, 03 Sep 2019 09:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190824153707.13746-1-uwe@kleine-koenig.org> <20190824153707.13746-6-uwe@kleine-koenig.org>
 <CAD=FV=X8kVU_zr69aKe-+GkAQh-tDwVf8tFogKve3s5O5ndF-g@mail.gmail.com> <20190902142709.wxrjsfzorozgeiuh@pengutronix.de>
In-Reply-To: <20190902142709.wxrjsfzorozgeiuh@pengutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 Sep 2019 09:54:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFTuixKL-VBv-QObiO=Jg43i6W0enprLgXQ0U8=9C49A@mail.gmail.com>
Message-ID: <CAD=FV=XFTuixKL-VBv-QObiO=Jg43i6W0enprLgXQ0U8=9C49A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] pwm: fsl-ftm: Don't update the state for the
 caller of pwm_apply_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm <linux-pwm@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, Sep 2, 2019 at 7:27 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Aug 30, 2019 at 10:39:16AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Sat, Aug 24, 2019 at 8:37 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koeni=
g.org> wrote:
> > >
> > > The pwm-fsl-ftm driver is one of only three PWM drivers which updates
> > > the state for the caller of pwm_apply_state(). This might have
> > > surprising results if the caller reuses the values expecting them to
> > > still represent the same state.
> > >
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> > > ---
> > >  drivers/pwm/pwm-fsl-ftm.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> >
> > Presumably this patch could break something since the pwm-fsl-ftm
> > driver doesn't appear to implement the get_state() function.  ...or
> > did I miss it?
>
> I don't expect breakage. We have more than 50 pwm drivers and only three
> of them made use of adapting the passed state. So unless you do
> something special with the PWM (i.e. more than backlight, LED or fan
> control) I don't think a consumer might care. But it might well be that
> I miss something so feel free to prove me wrong.

I don't have this hardware so I can't prove you wrong.  ...but
presumably someone added the code to return the state on purpose?

Maybe you could implement get_state() for this driver in your series?

-Doug
