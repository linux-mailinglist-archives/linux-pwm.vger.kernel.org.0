Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19EAF278E5
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2019 11:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfEWJJp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 May 2019 05:09:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37058 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbfEWJJp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 May 2019 05:09:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id o7so5842615qtp.4
        for <linux-pwm@vger.kernel.org>; Thu, 23 May 2019 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZDRg3ieis6hoh/yJ9a80gOidWlG1G6Pw/YGxgRuSE94=;
        b=kA31TSrggwsJxxWDnJJPIOo3MgixNqwLlwlFlwOzYC28Qzv9rkp8BWwHIdODxR99Nt
         d7IFt6+f5xHBItXGp2Eu/3CYh18PpggLnYDWOPGEhC58NLAK8u/eOGkbZkra0hb+DjIW
         5fb8+ypRJRIiFczeHfu1xVkpxzf1gcGRUnImDzPZUWqkbSgL6KAMHL9W7a8Fu8M5DujO
         90V5srCCUOkBo351510PYMPxAxjqB4JtbYWAJ2PHaAarEBwCMnecaut6HWHq4qz/oqfM
         qo2HNtUzDfnS3OXjBi1JU+j+hPnA/OKdCeWoN/pvQm7TpUNlroxutZ/9RIUPko5fruIR
         BCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZDRg3ieis6hoh/yJ9a80gOidWlG1G6Pw/YGxgRuSE94=;
        b=DiAn4YsxD5fPu602dtduZ74Q3BbalqV+wh7yrrpPlClWo8rfrEPLn/SfPnGLvEryFL
         Eyt9YHLVxhJBowCWww0DfB+qFF3wnwfUosDWF9dLvkwBjT5yTBaIjoU/tn8KmiPOYnXC
         fpBrdQNczv+Sa9/neEkr+TFy51XfMuiGyaYI3e/8b+2lYN/q3to7Gew/sPqtqgBNob0/
         vFq9kQFF7EQ3E9GjTp6crwEATrZ105CcaWNIh+vIn1UdE0XDOzZ+1XhGKvMZ5cDKLks7
         8vEbmE430rA2WtEJOQnt9JrF+GdhAsVKy8giYOH8P57cG+aaxCzoZuLPnfpdEf+s0hr2
         VJNw==
X-Gm-Message-State: APjAAAU/ZAE5CjSa6ZcfoxmKdyZlJhwponMcPYVHRb4dt2zxxmp7PWGu
        EzAyFlDcUavUTxMtkGhxYyBks8Ecy6pvOaTU021Ysw==
X-Google-Smtp-Source: APXvYqzPHWai2cPVbmyi53PtZyW+rD0M2Kck+rs0vgo/buY2HBfBi20KQ1+3WaNRxJAeDdyBzyejy/NHzp/5Y2dGtco=
X-Received: by 2002:ac8:352d:: with SMTP id y42mr78662075qtb.209.1558602584218;
 Thu, 23 May 2019 02:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com> <45e934af-d677-d7d4-09ea-3ed01872dab6@st.com>
In-Reply-To: <45e934af-d677-d7d4-09ea-3ed01872dab6@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 23 May 2019 11:09:33 +0200
Message-ID: <CA+M3ks5O9YpZ-4f3x=bFn_LxJu+6i3pu7jsWv_93pe14y8V71w@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 0/3] Add PM support to STM32 LP Timer drivers
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, tduszyns@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        u.kleine-koenig@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Le ven. 10 mai 2019 =C3=A0 09:51, Fabrice Gasnier <fabrice.gasnier@st.com> =
a =C3=A9crit :
>
> On 4/18/19 11:37 AM, Fabrice Gasnier wrote:
> > This patch series adds power management support for STM32 LP Timer:
> > - PWM driver
> > - Document the pinctrl states for sleep mode
> >
> > It also adds device link between the PWM consumer and the PWM provider.
> > This allows proper sequencing for suspend/resume (e.g. user will likely
> > do a pwm_disable() before the PWM provider suspend executes), see [1].
> >
> > [1] https://lkml.org/lkml/2019/2/5/770
> >
>
> Hi Thierry,
>
> Please let me know if you have some more comments on this series. It's
> been under review since quite some time now.
>

Hi Thierry,

Does something is blocking on this series ?
How can we progress on it ?

Regards,
Benjamin

> Thanks in advance,
> Best Regards,
> Fabrice
>
> > ---
> > resend v5:
> > - update collected acks
> >
> > Changes in v5:
> > - improve a warning message, fix a style issue.
> >
> > Changes in v4:
> > - improve error handling when adding the PWM consumer device link.
> >
> > Changes in v3:
> > - Move the device_link_add() call to of_pwm_get() as discussed with Uwe=
.
> >
> > Changes in v2:
> > - Don't disable PWM channel in PWM provider: rather refuse to suspend
> >   and report an error as suggested by Uwe and Thierry.
> > - Add patch 3/3 to propose device link addition.
> > - No updates for STM32 LP Timer IIO driver. Patches can be send separat=
ely.
> >
> > Fabrice Gasnier (3):
> >   dt-bindings: pwm-stm32-lp: document pinctrl sleep state
> >   pwm: stm32-lp: Add power management support
> >   pwm: core: add consumer device link
> >
> >  .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  9 ++--
> >  drivers/pwm/core.c                                 | 50 ++++++++++++++=
++++++--
> >  drivers/pwm/pwm-stm32-lp.c                         | 25 +++++++++++
> >  include/linux/pwm.h                                |  6 ++-
> >  4 files changed, 82 insertions(+), 8 deletions(-)
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
