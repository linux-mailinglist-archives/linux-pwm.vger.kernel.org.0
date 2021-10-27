Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E651C43CC67
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Oct 2021 16:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242614AbhJ0Oki (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 10:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242615AbhJ0Okh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 10:40:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775CC061745
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 07:38:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so5286677pji.5
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=619X0KptUed08s0CUBhf/N/JswW0tMPE0BHSDIcOX4Y=;
        b=VwUW9DxGBSkeRgyMzwMqoMCIN9AgwTpLSDg6/KPh+kDvDc76Jrx/wL/eO0gBa4ZpUX
         K0T4FkjE7dVSToBvaN//CHtRYgzB2bUgT/EVG94UxRfxbTBp727tSp88UIjnm8/rxxyq
         g1hKFq/miAgkJZ/NUoCLqVNWadua4TUfxhZKN4Z4+pt+o8KIPBzjvSGsW7HMqkD+2+D7
         3K3mUV5UdUr3krH7L+J+LOvG/kSzhReVRBqR/HNtFRQcr4nEo2uuGLq6O3LFykgA2xht
         MtlLMOL07lOLrRMNnOpHEPA+ft36FjoTkvHGH7kKelhyyATSqxgFzqRWFRyazw6WgIvE
         rHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=619X0KptUed08s0CUBhf/N/JswW0tMPE0BHSDIcOX4Y=;
        b=7xyhcr4dUr72/e2dIZKxSxnINTW4gML5zLCm9xRBcz0m0ZCk29Wa2TQ6XsQVGZKpWo
         i70nAJvSKHgzfeLlPPjTHX8ofCyT4wKg3ahsPKzUghkZugFNvtRlsUSCB/YnEKsrgwup
         pIhim39w0RCcMleBt8JBS7ODbGe4MSRh8S7/u1fWdqhqxEnFKFElc4gLTUW8l6bLatPM
         bLvV0GYgZcpWsVvOMA/okg3FQezU8BqiE3UrXOGGssT9DP65Nj7js6fJIaSi99xjWUCT
         eX8xTi94CVOkV7Yb7h6QwZqz0g+IjwqwBLtBZeLolHSBW5t322oJw5k5r5unQjklRZo1
         IOpQ==
X-Gm-Message-State: AOAM530AirKgGJvvN3LFeJtRX2k1AFQOZci6I8+lUXDN9irWtD7vKiEE
        pxImPFwnWnUM/lYx5SvgqtfiFrLoR7rl6hncv6VY1g==
X-Google-Smtp-Source: ABdhPJx2YdwH/KlEpTrc402ZLzsDivRtCZrcToQPCLTj03ywUTQjxzPidpH1dlmQr/eooVdnXa2HBTRcECMeVOq2ZB0=
X-Received: by 2002:a17:902:edc2:b0:141:6a3f:e676 with SMTP id
 q2-20020a170902edc200b001416a3fe676mr3176904plk.24.1635345491987; Wed, 27 Oct
 2021 07:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
 <20211025170925.3096444-2-bjorn.andersson@linaro.org> <CAG3jFysN4pFqTrF8tGTVapCzysPkvO=MpYosAJnErY-AW7BqgQ@mail.gmail.com>
 <YXlc+7BzbADe/p4A@ripper>
In-Reply-To: <YXlc+7BzbADe/p4A@ripper>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 27 Oct 2021 16:38:00 +0200
Message-ID: <CAG3jFyuUHd0Ra7zWx6byZUiZkJFVgtPkX6-a2RSqN6aGsyST+A@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] drm/bridge: ti-sn65dsi86: Use regmap_bulk_write API
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Uwe Kleine-K?nig" <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 27 Oct 2021 at 16:04, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 27 Oct 01:29 PDT 2021, Robert Foss wrote:
>
> > Hey Bjorn,
> >
> > On Mon, 25 Oct 2021 at 19:07, Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > The multi-register u16 write operation can use regmap_bulk_write()
> > > instead of two separate regmap_write() calls.
> > >
> > > It's uncertain if this has any effect on the actual updates of the
> > > underlying registers, but this at least gives the hardware the
> > > opportunity and saves us one transation on the bus.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >
> > Did you miss including Dougs R-B from v6? As far as I can tell nothing
> > else changed between v6 & v7.
> >
>
> Yes, I missed adding Doug's R-b from v6. I also missed fixing the
> spelling of transaction (transation) in the commit message.
>
> Would you be willing to correct these two items as you apply the
> patches?

Can do.
