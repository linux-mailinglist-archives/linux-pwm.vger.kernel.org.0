Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD9442CC6
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Nov 2021 12:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKBLk0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Nov 2021 07:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhKBLk0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Nov 2021 07:40:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28BC061714
        for <linux-pwm@vger.kernel.org>; Tue,  2 Nov 2021 04:37:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t21so15633854plr.6
        for <linux-pwm@vger.kernel.org>; Tue, 02 Nov 2021 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+LcalwcS+7iwU2Z06DjsWxGkhOqaOpX2CeRBZg6uNxI=;
        b=u1T+gyQ5y9utIQAL69osfNb3bY8W18tAEGHKXB/yOTt4z6DVkjo0Tm9BVQLQYlQvmi
         +RyAD+cAN0ZnryDgfEwhDomhWP5aHyg5Ddw+FwF0gZJTl/XAP/yxFxTYru4YWi1yyGvJ
         Nyj3SvEFcTOcvzmYNQ0CoFLHMwyXenD/+RlY68vQyVJLDAzJrMq+x/p9kEwcpaxEik6P
         WbrrqPpjnKVAB9bhIp9NOjCOgDYCVxAD9qfdxmvVHjjyUpYw53WETAy8gUPku20d08EZ
         Mjm5PXINnW3OWZm3X+mTRbx7nnM77l1Hnq9RZ5CYtf9EDulCgVA5ot0Bz2ITNNcoxFE0
         B+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+LcalwcS+7iwU2Z06DjsWxGkhOqaOpX2CeRBZg6uNxI=;
        b=swOZsRmKl/VfL3nR5GwIC23CS1nFwBy1v9RdXeq9d3G1tDWPUVW1pr30vgA9NhEI1b
         sbvtYxB2/1w09kvYkVKA+Bl6zlDqpQzoThNaAC4Awv2iDGVS9yU4i3lf7W2ylLele0jj
         JfXVm1YNu3741grCbGf3B3b7d/+AOzzVmxKIJLz+gMuTZauLgK2JY5T6OnG3jp19kI/n
         aZ6InSfpcdbzVknmTHxIHmKv6jlrb3bJFUGSqx1J9dbDDeISsD3fB5OBFybpRtJo12xs
         zb7uOTIkb42li1wGk2XaJOWBaNX8dgUeEet9bfmwEkp5uhSfjbT/G6UqsrQIZWEqVZEp
         86yw==
X-Gm-Message-State: AOAM532sUNVA7M8GKst910K58rxeZ4jEagP+QH4aMgpnTRBDi8WWelWS
        mLmZX5HAt0qHsrfSA7cYitlktr7OJvHz7OLGJLKnmg==
X-Google-Smtp-Source: ABdhPJxlukTujJboXT4S57TaNSXOyAMkRW6XndNn4eisc8fX7Oczi13MU70tOQlUfeLfplvXUQ5IVMFqLcPTtBJr/Uo=
X-Received: by 2002:a17:90b:3149:: with SMTP id ip9mr1957728pjb.232.1635853071054;
 Tue, 02 Nov 2021 04:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
 <65243a98-61b9-3311-f41d-fa4782448baa@kali.org> <CAG3jFytmcFcA5W3vmcpWTWrc36-YFMPZ1wAB8gAJfiHHLWmaCA@mail.gmail.com>
 <20211030092736.eam4ahzimiew7erg@pengutronix.de>
In-Reply-To: <20211030092736.eam4ahzimiew7erg@pengutronix.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 2 Nov 2021 12:37:39 +0100
Message-ID: <CAG3jFyuYE_=73LfkQ7KLL+6ZvrGAORT8z1Cw1kmssgn7ewTENQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] pwm: Introduce single-PWM of_xlate function
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hey Uwe

On Sat, 30 Oct 2021 at 11:27, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Wed, Oct 27, 2021 at 05:06:02PM +0200, Robert Foss wrote:
> > On Tue, 26 Oct 2021 at 19:21, Steev Klimaszewski <steev@kali.org> wrote=
:
> > >
> > >
> > > On 10/25/21 12:09 PM, Bjorn Andersson wrote:
> > > > The existing pxa driver and the upcoming addition of PWM support in=
 the
> > > > TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel a=
nd
> > > > thereby a need for a of_xlate function with the period as its singl=
e
> > > > argument.
> > > >
> > > > Introduce a common helper function in the core that can be used as
> > > > of_xlate by such drivers and migrate the pxa driver to use this.
> > > >
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > > Tested-by: Steev Klimaszewski <steev@kali.org>
> > > > ---
> > > >
> > [...]
> >
> > Applied to drm-misc-next.
>
> This is now 3ab7b6ac5d829e60c3b89d415811ff1c9f358c8e in next, the Link:
> added in the commit trailer looks as follows:
>
>         Link: https://patchwork.freedesktop.org/patch/msgid/2021102517092=
5.3096444-1-bjorn.andersson@linaro.org
>
> but this link doesn't work, for me at least. I wonder what's wrong with
> it. If you want to fix it and rewrite the commit, you can also drop the
> duplicated "Tested-by: Steev Klimaszewski <steev@kali.org>".

Weirdly patchwork.fd.o[1] doesn't seem to have the series, but does
have previous versions.

[1] https://patchwork.freedesktop.org/project/dri-devel/patches/?submitter=
=3D&state=3D*&q=3D_xlate&archive=3Dboth&delegate=3D
